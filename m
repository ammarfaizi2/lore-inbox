Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261607AbVDJVMI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261607AbVDJVMI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 17:12:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261608AbVDJVMI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 17:12:08 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:51927 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261607AbVDJVMD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 17:12:03 -0400
Subject: Re: [PATCH] re-export cancel_rearming_delayed_workqueue
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1113162531.15213.0.camel@laptopd505.fenrus.org>
References: <1113160044.6737.12.camel@mulgrave>
	 <1113162531.15213.0.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Sun, 10 Apr 2005 16:11:46 -0500
Message-Id: <1113167506.6737.21.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-04-10 at 21:48 +0200, Arjan van de Ven wrote:
> I have absolutely no problem with such an export / unstatic if there are
> users... could you just send them in one go ?

Actually, no ... this is a nasty cross tree dependency.  The piece of
code is queued in the parisc tree, but Matthew can't really send it to
Linus until the interface it uses is in the tree.  It's someone else's
code, I just fixed its problems.

James




