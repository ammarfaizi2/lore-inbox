Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318892AbSG1C6c>; Sat, 27 Jul 2002 22:58:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318894AbSG1C6c>; Sat, 27 Jul 2002 22:58:32 -0400
Received: from dsl092-237-176.phl1.dsl.speakeasy.net ([66.92.237.176]:64522
	"EHLO whisper.qrpff.net") by vger.kernel.org with ESMTP
	id <S318892AbSG1C6a>; Sat, 27 Jul 2002 22:58:30 -0400
X-All-Your-Base: Are Belong To Us!!!
X-Envelope-Recipient: rwhite@pobox.com
X-Envelope-Sender: stevie@qrpff.net
Message-Id: <5.1.0.14.2.20020727224849.02501e88@whisper.qrpff.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sat, 27 Jul 2002 23:01:45 -0400
To: rwhite@pobox.com, Andries Brouwer <aebr@win.tue.nl>
From: Stevie O <stevie@qrpff.net>
Subject: Re: n_tty.c driver patch (semantic and performance correction)
  (a ll recent versions)
Cc: Russell King <rmk@arm.linux.org.uk>, Ed Vance <EdV@macrolink.com>,
       "'Theodore Tso'" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
       linux-serial@vger.kernel.org
In-Reply-To: <200207271934.27102.rwhite@pobox.com>
References: <20020727232129.GA26742@win.tue.nl>
 <11E89240C407D311958800A0C9ACF7D13A789A@EXCHANGE>
 <200207271507.56873.rwhite@pobox.com>
 <20020727232129.GA26742@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 07:34 PM 7/27/2002 -0700, Robert White wrote:
>So far all I am getting back is one non-public "that's a good idea, but I want 
>to see what everybody else thinks" and a bunch of "but the standard says"...
>
>The standard is OLD and UNREALISTIC (and if you get all lawyer-ish, somewhat 
>inconsitant and vague.) and the modification is one hundred percent 
>compatable with what is in the field and what "more than half" of the users 
>expect.


But... but... the standard says...

   A pending read shall not be satisfied until MIN bytes are received
   (that is, the pending read shall block until MIN bytes are received),
   or a signal is received.

And because I'm too dead-set on doing it that way solely because that's how it's always been done, I won't ever consider changing it.  I'll blindly ignore how much xmodem transfers suck, and the fact that I can come up with no practical purpose at all for this feature, and just repeat what the standard says.  Why should we obey what Linux man pages say? What do the Linux man pages have to do with Linux?

Remember: Computers and their programs aren't here to make our lives easier, or to make tasks simpler. They are here to follow standards.


--
Stevie-O

Real programmers use COPY CON PROGRAM.EXE

