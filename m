Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311609AbSCXGn7>; Sun, 24 Mar 2002 01:43:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311634AbSCXGnu>; Sun, 24 Mar 2002 01:43:50 -0500
Received: from dsl092-237-176.phl1.dsl.speakeasy.net ([66.92.237.176]:60680
	"EHLO whisper.qrpff.net") by vger.kernel.org with ESMTP
	id <S311609AbSCXGnj>; Sun, 24 Mar 2002 01:43:39 -0500
Message-Id: <5.1.0.14.2.20020324013457.022907d0@whisper.qrpff.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sun, 24 Mar 2002 01:38:17 -0500
To: Pavel Machek <pavel@suse.cz>, Jeff Garzik <jgarzik@mandrakesoft.com>
From: Stevie O <stevie@qrpff.net>
Subject: Re: fadvise syscall?
Cc: Anton Altaparmakov <aia21@cam.ac.uk>, Andrew Morton <akpm@zip.com.au>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <20020322160542.G37@toy.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 04:05 PM 3/22/2002 +0000, Pavel Machek wrote:
>> 
>> 
>> I disagree, and here's the main reasons:
>> 
>> * fadvise(2) usefulness extends past open(2).  It may be useful to call 
>> it at various points during runtime.
>
>open(/proc/self/fd/0, O_NEW_FLAGS)?

So to use fadvise(), the system must have /proc mounted?



Not everybody mounts /proc -- it provides a lot of potential information to anybody who can access it ("hmm... they  have a QZ48257 ethernet chipset [cat /proc/pci] -- lets see, sending this specific sequence of bytes in a TCP packet will lock up the receiver...").


--
Stevie-O

Real programmers use COPY CON PROGRAM.EXE

