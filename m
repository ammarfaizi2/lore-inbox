Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261609AbUJaTJ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261609AbUJaTJ0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 14:09:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261624AbUJaTJ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 14:09:26 -0500
Received: from smtp812.mail.sc5.yahoo.com ([66.163.170.82]:42115 "HELO
	smtp812.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261609AbUJaTJU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 14:09:20 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Configurable Magic Sysrq
Date: Sun, 31 Oct 2004 14:09:15 -0500
User-Agent: KMail/1.6.2
Cc: Pavel Machek <pavel@suse.cz>, Jan Kara <jack@suse.cz>, akpm@osdl.org
References: <20041029093941.GA2237@atrey.karlin.mff.cuni.cz> <20041031185222.GB5578@elf.ucw.cz>
In-Reply-To: <20041031185222.GB5578@elf.ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410311409.16400.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 31 October 2004 01:52 pm, Pavel Machek wrote:
> Hi!
> 
> >   I know about a few people who would like to use some functionality of
> > the Magic Sysrq but don't want to enable all the functions it provides.
> > So I wrote a patch which should allow them to do so. It allows to
> > configure available functions of Sysrq via /proc/sys/kernel/sysrq (the
> > interface is backward compatible). If you think it's useful then use it :)
> > Andrew, do you think it can go into mainline or it's just an overdesign?
> 
> Actually, there's one more thing that wories me... Original choice of
> PC hotkey (alt-sysrq-key) works *very* badly on many laptop
> keyboards. Like sysrq is only recognized with fn, but key is not
> recognized when you hold fn => you have no chance to use magic sysrq.
> 

Actually if I understand it correctly it is Alt-PrtScrn-key - just let go
of your "Fn" key and I think it will work fine. At least it does on my
laptop.

-- 
Dmitry
