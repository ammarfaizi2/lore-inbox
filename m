Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318238AbSG3MCW>; Tue, 30 Jul 2002 08:02:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318240AbSG3MCW>; Tue, 30 Jul 2002 08:02:22 -0400
Received: from chaos.analogic.com ([204.178.40.224]:54144 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S318238AbSG3MCV>; Tue, 30 Jul 2002 08:02:21 -0400
Date: Tue, 30 Jul 2002 08:07:19 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Axel Siebenwirth <axel@hh59.org>
cc: JFS-Discussion <jfs-discussion@www-124.southbury.usf.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Testing of filesystems
In-Reply-To: <20020730094902.GA257@prester.freenet.de>
Message-ID: <Pine.LNX.3.95.1020730080434.5365A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jul 2002, Axel Siebenwirth wrote:

> Hi,
> 
> I wonder what a good way is to stress test my JFS filesystem. Is there a tool
> that does something like that maybe? Dont't want performance testing, just
> all kinds of stress testing to see how the filesystem "is" and to check
> integrity and functionality.
> What are you filesystem developers use to do something like that?
> 
> Thanks,
> Axel

Compile the kernel in a directory tree on the file-system you
want to test......

while true ; do make clean ; make -j 16 bzImage ; make modules ; done


Let this run for a day or so...


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

