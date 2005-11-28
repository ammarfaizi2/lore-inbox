Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932130AbVK1Sih@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932130AbVK1Sih (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 13:38:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932167AbVK1Sih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 13:38:37 -0500
Received: from stat9.steeleye.com ([209.192.50.41]:37841 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S932130AbVK1Sig (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 13:38:36 -0500
Subject: Re: [patch] drivers/scsi/dpt_i2o.c: fix a NULL pointer dereference
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       markus.lidel@shadowconnect.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, Mark Salyzyn <mark_salyzyn@adaptec.com>
In-Reply-To: <20051126233637.GC3988@stusta.de>
References: <20051126233637.GC3988@stusta.de>
Content-Type: text/plain
Date: Mon, 28 Nov 2005 12:37:11 -0600
Message-Id: <1133203032.3325.46.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-11-27 at 00:36 +0100, Adrian Bunk wrote:
> The Coverity checker spotted this obvious NULL pointer dereference.

It's a bit late for this one, since Linus already put it in, but for
future reference, could you please try to use proper descriptions.  This
isn't an "obvious NULL pointer dereference", it's actually a use after
free of a data structure.

Thanks,

James


