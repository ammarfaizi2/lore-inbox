Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270620AbRHNNsQ>; Tue, 14 Aug 2001 09:48:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270626AbRHNNsF>; Tue, 14 Aug 2001 09:48:05 -0400
Received: from postfix2-2.free.fr ([213.228.0.140]:47122 "HELO
	postfix2-2.free.fr") by vger.kernel.org with SMTP
	id <S270620AbRHNNru>; Tue, 14 Aug 2001 09:47:50 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: Camino 2 (82815/82820) v2.4.x eth/sound related lockups
Message-ID: <997796871.3b792c0759fec@imp.free.fr>
Date: Tue, 14 Aug 2001 15:47:51 +0200 (MEST)
From: benjilr@free.fr
Cc: Ime Smits <ime@iaehv.iae.nl>, Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <Pine.BSF.4.05.10108141301230.92637-100000@iaehv.iae.nl>
In-Reply-To: <Pine.BSF.4.05.10108141301230.92637-100000@iaehv.iae.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: IMP/PHP IMAP webmail program 2.2.42
X-Originating-IP: 172.188.172.150
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Funny things in syslog include:
> 
> kernel: mtrr: base(0xe8000000) is not aligned on a
> size(0x4b0000) boundary
> kernel: eepro100: wait_for_cmd_done timeout!
> 
I've had the same problem, with my intel etherExpres Pro/100
But I've solve it, by using the e100 driver provide by intel in replacement of 
the eepro100 driver provide by kernel.

You can find source of e100 at this URL : http://appsr.intel.com/scripts-
df/File_Filter.asp?FileName=e100  I 've used the file e100-1.6.13.tar.gz.
Compile and Install without any problem, and now, the card work perfectly.

Benjamin
