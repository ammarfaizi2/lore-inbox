Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130753AbQKHEAu>; Tue, 7 Nov 2000 23:00:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131227AbQKHEAk>; Tue, 7 Nov 2000 23:00:40 -0500
Received: from deliverator.sgi.com ([204.94.214.10]:49498 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S130753AbQKHEA2>; Tue, 7 Nov 2000 23:00:28 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: "Mike A. Harris" <mharris@opensourceadvocate.org>
cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: ide-probe.c:400: `rtc_lock' undeclared and /lib/modules/..../build 
In-Reply-To: Your message of "Tue, 07 Nov 2000 21:48:59 CDT."
             <Pine.LNX.4.21.0011072148270.10929-100000@asdf.capslock.lan> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 08 Nov 2000 14:59:42 +1100
Message-ID: <6444.973655982@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Nov 2000 21:48:59 -0500 (EST), 
"Mike A. Harris" <mharris@opensourceadvocate.org> wrote:
>On Tue, 7 Nov 2000, Alan Cox wrote:
>>Actually they do. I agree that it wants sorting. Im just wondering what the
>>best approach is - maybe check modutils rev and only add the link if its high
>>enough ?
>
>What if build-machine != machine-kernel-was-built-for?

Then you are SOL, but that is a generic cross compile problem.  Anybody
doing cross compile has to do extra steps to copy the results to the
other machine and they can take care of problems like the build symlink
themselves.  The patch in 2.2.18-pre20 fixes the problem for local
compiles, which are 95%+ (SWAG) of the compiles.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
