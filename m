Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131031AbQKVA7V>; Tue, 21 Nov 2000 19:59:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131993AbQKVA7L>; Tue, 21 Nov 2000 19:59:11 -0500
Received: from mail01.onetelnet.fr ([213.78.0.138]:11842 "EHLO
	mail01.onetelnet.fr") by vger.kernel.org with ESMTP
	id <S131031AbQKVA7A>; Tue, 21 Nov 2000 19:59:00 -0500
Message-ID: <3A1B20E4.25871E33@onetelnet.fr>
Date: Wed, 22 Nov 2000 02:27:00 +0100
From: Fort David <epopo@onetelnet.fr>
Reply-To: epopo@onetelnet.fr
Organization: DLR network
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Stephen Gutknecht (linux-kernel)" <linux-kernel@i405.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Better testing of hardware (was: Defective Read Hat)
In-Reply-To: <0066CB04D783714B88D83397CCBCA0CD49AF@spike2.i405.net>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Stephen Gutknecht (linux-kernel)" wrote:

> Part of the issue is that there exists no "easy to use" standardized test
> software.  Full 32-bit concurrent use of many devices can reveal problems
> that users do not often see in normal applications.
>
> One major hardware review site found stability problems with the Intel
> Pentium 3 1130Mhz processor that ultimately lead to Intel delaying the
> release -- it passed all tests but not a compile of the Linux Kernel!  This
> was on more than 3 different processors.
> http://www.tomshardware.com/cpu/00q3/0008281/pentiumiii-04.html
>
> A Linux Kernel compile test does a really good job of testing the hard disk,
> RAM, and CPU... as it executes all types of instructions and the final
> output depends on all prior steps completing correctly.  On a really fast
> system (> 900Mhz) might make sense to run it twice, once to "warm up" the
> CPU and other components.  Most "benchmarks" just test speed, not the actual
> stability or data integrity (they write results to a device but don't check
> for data corruption, or they test only one device at a time, not all at
> once).
>
> What a Linux kernel compile DOESN'T test is the network interfaces and video
> cards.
>
>

Compiling over NFS with compilation lines producing some kind of openGL
animation ?

--
%-------------------------------------------------------------------------%
% FORT David,                                                             %
% 7 avenue de la morvandière                                   0240726275 %
% 44470 Thouare, France                                epopo@onetelnet.fr %
% ICU:78064991   AIM: enlighted popo             fort@irin.univ-nantes.fr %
%--LINUX-HTTPD-PIOGENE----------------------------------------------------%
%  -datamining <-/                        |   .~.                         %
%  -networking/flashed PHP3 coming soon   |   /V\        L  I  N  U  X    %
%  -opensource                            |  // \\     >Fear the Penguin< %
%  -GNOME/enlightenment/GIMP              | /(   )\                       %
%           feel enlighted....            |  ^^-^^                        %
%                           http://ibonneace.dnsalias.org/ when connected %
%-------------------------------------------------------------------------%



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
