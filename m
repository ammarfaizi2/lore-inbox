Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318045AbSHaWrL>; Sat, 31 Aug 2002 18:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318047AbSHaWrL>; Sat, 31 Aug 2002 18:47:11 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:6673 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318045AbSHaWrK>;
	Sat, 31 Aug 2002 18:47:10 -0400
Date: Sat, 31 Aug 2002 23:51:35 +0100
From: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch 2.4.19] reboot on out-of-file handles
Message-ID: <20020831225135.GH721@gallifrey>
References: <20020831201638.GG721@gallifrey> <1030826468.3582.25.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1030826468.3582.25.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/2.4.18 (i686)
X-Uptime: 23:47:19 up 1 day,  2:44,  1 user,  load average: 2.04, 2.07, 2.13
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Alan Cox (alan@lxorguk.ukuu.org.uk) wrote:
> On Sat, 2002-08-31 at 21:16, Dr. David Alan Gilbert wrote:
> > Hi,
> >   Please find below a patch that adds the ability to panic if you run
> > out of file handles (by setting /proc/sys/fs/file-max-panic to none-0).
> 
> You can already do this reliably in user space as part of your watchdog
> daemon processing.

Ah - good idea.
The only thing that doesn't do (which my patch doesn't do much of), is
log the state of the system at failure - I'd really like to know what
ate all the filehandles.

Dave
 ---------------- Have a happy GNU millennium! ----------------------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM, SPARC and HP-PA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
