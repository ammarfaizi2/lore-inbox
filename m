Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287598AbSALWZr>; Sat, 12 Jan 2002 17:25:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287599AbSALWZi>; Sat, 12 Jan 2002 17:25:38 -0500
Received: from mail.cogenit.fr ([195.68.53.173]:39391 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S287598AbSALWZ0>;
	Sat, 12 Jan 2002 17:25:26 -0500
Date: Sat, 12 Jan 2002 23:25:22 +0100
From: Francois Romieu <romieu@cogenit.fr>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-ID: <20020112232522.A6541@fafner.intra.cogenit.fr>
In-Reply-To: <E16P0vl-0007Tu-00@the-village.bc.nu> <1010781207.819.27.camel@phantasy> <20020112121315.B1482@inspiron.school.suse.de> <20020112160714.A10847@planetzork.spacenet> <20020112095209.A5735@hq.fsmlabs.com> <20020112180016.T1482@inspiron.school.suse.de> <005301c19b9b$6acc61e0$0501a8c0@psuedogod> <3C409B2D.DB95D659@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C409B2D.DB95D659@zip.com.au>; from akpm@zip.com.au on Sat, Jan 12, 2002 at 12:23:09PM -0800
X-Organisation: Marie's fan club - II
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Cc: trimmed]

Andrew Morton <akpm@zip.com.au> :
[mini-ll]
> And guess what?   Nobody has tested the damn thing, so it's going
> nowhere.

It allows me to del^W read NFS-mounted mail behind a linux router while I 
copy files locally on the router. If I don't apply mini-ll to the router, 
it's a "server foo not responding, still trying" fest. You know what
"interactivity feel" means when it happens.

If someone suspects the hardware is crap, it's a PIV motherboard with 
built-in Promise20265 and four IBM IC35L060AVER07-0 on their own channel.
Each disk has been able to behave normally during RAID1 rebuild.

Without mini-ll:
  well choosen file I/O => no file I/O, no networking, no console, *big pain*.
With mini-ll:
  well choosen file I/O => *only* those I/O suck (less than before btw).

-- 
Ueimor
