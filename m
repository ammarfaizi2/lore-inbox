Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130188AbRAHRYr>; Mon, 8 Jan 2001 12:24:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131211AbRAHRYh>; Mon, 8 Jan 2001 12:24:37 -0500
Received: from smtp01.mrf.mail.rcn.net ([207.172.4.60]:65517 "EHLO
	smtp01.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id <S130188AbRAHRYZ>; Mon, 8 Jan 2001 12:24:25 -0500
Date: Mon, 8 Jan 2001 12:24:20 -0500 (EST)
From: "Mohammad A. Haque" <mhaque@haque.net>
To: Paul Powell <moloch16@yahoo.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 'console=' kernel parameter questions
In-Reply-To: <20010108165050.13240.qmail@web119.yahoomail.com>
Message-ID: <Pine.LNX.4.30.0101081220080.15703-100000@viper.haque.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I do believe RedHat kernels have this feature compiled in.

This is probably an typo in the email but it's /dev/ttyS0 . Note the
capital 'S'.

On Mon, 8 Jan 2001, Paul Powell wrote:

> Hello,
>
> I am running an unmodified RedHat 6.2 kernel
> (kernel version 2.2.14-5.0)
>
> I am trying to redirect the linux startup messages to
> the serial port.  I've added the 'console=' parameter
> to my lilo.conf file.  I've tried several iterations
> such as
> 'console=ttys0','console=cua0','console=ttys0,9600n8',
> etc....
>
> They all fail to produce any output to the serial port
> although they do remove the text from my screen.  When
> I have booted RedHat I can type 'echo blah >
> /dev/cua0' and I see text output from the serial port.
>  Interestingly when I try to echo to /dev/ttys0 I get
> an IO error message. I'm using a null modem cable
> connect to a windows machine to watch the serial port.
>
> My question: why can I see output when booted into
> RedHat but not when booting the OS?  I've read that
> you have to compile this feature into the kernel.
> Does anyone know if RedHat's kernel come with this
> feature built in?
>

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
