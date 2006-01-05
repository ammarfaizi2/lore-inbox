Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752291AbWAEWwz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752291AbWAEWwz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 17:52:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752294AbWAEWwz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 17:52:55 -0500
Received: from [81.2.110.250] ([81.2.110.250]:56507 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1752292AbWAEWwy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 17:52:54 -0500
Subject: Re: -mm1: drivers/char/amiserial.c doesn't compile
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, Alan Cox <alan@redhat.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060105220805.GG12313@stusta.de>
References: <20060105062249.4bc94697.akpm@osdl.org>
	 <20060105220805.GG12313@stusta.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 05 Jan 2006 22:51:40 +0000
Message-Id: <1136501500.16358.42.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2006-01-05 at 23:08 +0100, Adrian Bunk wrote:
> Alan, your tty-layer-buffering-revamp.patch in -mm causes the following 
> compile error on m68k:


Thanks. I think you just need a "return" instead of the goto now

