Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <157483-27300>; Sat, 30 Jan 1999 21:13:12 -0500
Received: by vger.rutgers.edu id <157319-27300>; Sat, 30 Jan 1999 21:12:56 -0500
Received: from neon-best.transmeta.com ([206.184.214.10]:12303 "EHLO neon.transmeta.com" ident: "SOCKWRITE-65") by vger.rutgers.edu with ESMTP id <157508-27302>; Sat, 30 Jan 1999 21:12:20 -0500
To: linux-kernel@vger.rutgers.edu
From: hpa@transmeta.com (H. Peter Anvin)
Subject: Re: DES encryption in loop device (kernel 2.2.1)
Date: 31 Jan 1999 02:24:18 GMT
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <790esi$3kl$1@palladium.transmeta.com>
References: <XFMail.990130193525.rdicaire@vic.com>
Reply-To: hpa@transmeta.com (H. Peter Anvin)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 1999 H. Peter Anvin - All Rights Reserved
Sender: owner-linux-kernel@vger.rutgers.edu

Followup to:  <XFMail.990130193525.rdicaire@vic.com>
By author:    rdicaire@vic.com
In newsgroup: linux.dev.kernel
>
> In trying to DES encrypt a loop mounted ext2 file system, I get the
> following errors:
> 
> losetup -e des /dev/loop4 MYFILE3
> Password: xxxxxxxxxxxxxxx
> Init (up to 16 hex digits): xxxxxxxxxxxxx
> ioctl: LOOP_SET_STATUS: Invalid argument
> 
> Using XOR works but we all know XOR isn't secure. Is there a patch
> to fix this? 
> 

Have you included the international kernel patch from kerneli.org?
Otherwise, you're getting a crypto-less kernel.

	-hpa
-- 
"Linux is a very complete and sophisticated operating system.  There
are, and will be, large numbers of applications available for it."
    -- Paul Maritz, Group Vice President for Platforms And Applications,
       Microsoft Corporation [Reference at: http://www.kernel.org/~hpa/ms.html]

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
