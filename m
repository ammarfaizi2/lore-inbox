Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316599AbSGLQBR>; Fri, 12 Jul 2002 12:01:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316600AbSGLQBQ>; Fri, 12 Jul 2002 12:01:16 -0400
Received: from speech.braille.uwo.ca ([129.100.109.30]:54227 "EHLO
	speech.braille.uwo.ca") by vger.kernel.org with ESMTP
	id <S316599AbSGLQBP>; Fri, 12 Jul 2002 12:01:15 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Advice saught on math functions
References: <E17T2P5-0003DF-00@the-village.bc.nu>
From: Kirk Reiser <kirk@braille.uwo.ca>
Date: 12 Jul 2002 12:04:00 -0400
In-Reply-To: <E17T2P5-0003DF-00@the-village.bc.nu>
Message-ID: <x7hej5djbj.fsf@speech.braille.uwo.ca>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> This is how Nicholas stuff works, you can still get the kernel messages
> by scrolling back. I'm told this meets S508.

I don't give two shits about S508.  For one thing that is a
U.S. statute.  It has no relevance here.

> Actually some of this is true for sighted people. You only get console
> messages after PCI is initialised, until then they are queued away or
> only on serial console.

Even though, pci gets initialized pretty early in the boot sequence
doesn't it?  Considerably before init?

> 
> If you are using a conventional BIOS then the first kernel messages being
> readable as they occur versus just after seems to have only a little value.
> If you have a fully accessible LinuxBIOS thats something quite different.
> In that case can you use a Linuxbios hook for the console speech until
> user space takes over ?

I don't really know.  I haven't had time to really get into the BIOS
accessibility yet.  I know for serial synths we can turn serial on in
lilo and at least hear what is going on.  Without modifying lilo for
each synth other than serial we have no way of knowing whether we have
the full lilo prompt or what.

If we could modify a linux BIOS and then flash it onto any flashable
BIOS that would be really useful.

  Kirk


-- 

Kirk Reiser				The Computer Braille Facility
e-mail: kirk@braille.uwo.ca		University of Western Ontario
phone: (519) 661-3061
