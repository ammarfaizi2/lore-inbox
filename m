Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131479AbQLHPV1>; Fri, 8 Dec 2000 10:21:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131526AbQLHPVR>; Fri, 8 Dec 2000 10:21:17 -0500
Received: from chaos.analogic.com ([204.178.40.224]:50560 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S131479AbQLHPVC>; Fri, 8 Dec 2000 10:21:02 -0500
Date: Fri, 8 Dec 2000 09:50:11 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Rik van Riel <riel@conectiva.com.br>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Jeff V. Merkey" <jmerkey@timpanogas.org>,
        Peter Samuelson <peter@cadcamlab.org>, linux-kernel@vger.kernel.org
Subject: Re: [Fwd: NTFS repair tools]
In-Reply-To: <Pine.LNX.4.21.0012081226160.8655-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.3.95.1001208093143.11788A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Dec 2000, Rik van Riel wrote:

> On Fri, 8 Dec 2000, Alan Cox wrote:
> 
> > I am very firmly against removing something because people do
> > not read manuals, what is next fdisk , mkfs ?.
> 
> I must say I like the CONFIG_MORON though. By setting that the
> (l)user exposes his true identity and leaves little for us to
> doubt ;)
> 
> Added to the Patch of the Month page as suggested by David
> Weinehall:
> 
> 	http://www.surriel.com/potm/
> 
> regards,
> 

Question. Which of the following files will first be executed if
found in a distribution?

Script started on Fri Dec  8 09:34:17 2000
# pwd
/DANGER/DANGER/DANGER
# ls -la
total 3128
drwxr-xr-x   2 root     root         4096 Dec  8 09:34 .
drwxrwxrwx   3 root     root         4096 Dec  8 09:32 ..
-rwxr-xr-x   1 root     root       634503 Dec  8 09:33 corruption
-rwxr-xr-x   1 root     root       634503 Dec  8 09:33 death
-rwxr-xr-x   1 root     root       634503 Dec  8 09:32 do_not_execute
-rwxr-xr-x   1 root     root       634503 Dec  8 09:33 this_can_break_your_machine
-rwxr-xr-x   1 root     root       634503 Dec  8 09:33 this_is_harmful
# exit
exit
Script done on Fri Dec  8 09:34:39 2000

Answer; Anything that looks exciting. I'd go for death, but the less bold
might try corruption first. Things that are only harmful get no attention
at all.

In the 'olden' days, stuff in /sbin was considered off-limits without
the explicit written documentation at hand (Try to partition a hard-
disk under Ultrix). When asked; "Do you want to write (Y/N)?", the
answers were not Y/N!  You had to look in the documentation and
find that the only way to commit the write was by typing
"Yes, absolutely, positively!"

This helped keep the learners from destroying their systems.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.0 on an i686 machine (799.54 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
