Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292681AbSBZSpB>; Tue, 26 Feb 2002 13:45:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292420AbSBZSoy>; Tue, 26 Feb 2002 13:44:54 -0500
Received: from chaos.analogic.com ([204.178.40.224]:17803 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S292659AbSBZSol>; Tue, 26 Feb 2002 13:44:41 -0500
Date: Tue, 26 Feb 2002 13:47:21 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "H. Peter Anvin" <hpa@zytor.com>
cc: Mike Fedyk <mfedyk@matchmail.com>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        linux-kernel@vger.kernel.org
Subject: Re: ext3 and undeletion
In-Reply-To: <3C7BD534.4080806@zytor.com>
Message-ID: <Pine.LNX.3.95.1020226134154.4315B-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Feb 2002, H. Peter Anvin wrote:

> Richard B. Johnson wrote:
> 
> > 
> > All the deleted files, with the correct path(s), are now in the
> > top directory file the file-system ../lost+found directory. They
> > are still owned by the original user, still subject to the same
> > quota. The disk space can't run out because you have simply moved
> > files that didn't exceed the disk space before they were moved.
> > 
> 
> 
> Ummm... it never occurred to you why someone would delete files in the
> first place?
> 
> 	-hpa

Yep. They probably thought they had changed directory to some scratch
file-system and they were cleaning it up! Most wildcard deletions are
truly accidental like this :

ls .c>*  # woops, made a file called '*', I'll fix it..
rm *     # Good, now back to work...
ls *.c >files


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).

        111,111,111 * 111,111,111 = 12,345,678,987,654,321

