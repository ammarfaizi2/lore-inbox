Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262937AbSL0NRf>; Fri, 27 Dec 2002 08:17:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264931AbSL0NRf>; Fri, 27 Dec 2002 08:17:35 -0500
Received: from [195.39.17.254] ([195.39.17.254]:6916 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S262937AbSL0NRe>;
	Fri, 27 Dec 2002 08:17:34 -0500
Date: Fri, 27 Dec 2002 14:24:20 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Anomalous Force <anomalous_force@yahoo.com>
Cc: wa@almesberger.net, ebiederm@xmission.com, linux-kernel@vger.kernel.org
Subject: Re: holy grail
Message-ID: <20021227132419.GA404@elf.ucw.cz>
References: <20021227010338.A1406@almesberger.net> <20021227072142.26177.qmail@web13208.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021227072142.26177.qmail@web13208.mail.yahoo.com>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

> > Your best bet would be to use a system that already implements some
> > form of checkpointing or process migration, and use this to
> > preserve user space state across kexec reboots. openMosix may be
> 
> [snip]
> 
> preserving user state would not be so much the problem as would
> the various internal kernel data structures (vm stuff, dcache, etc.)

Actually, you want to kill vm structures, dcache etc. You only want
userspace-visible state to be carried forward to minimize possibility
of bringing bugs to new kernel.
								Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
