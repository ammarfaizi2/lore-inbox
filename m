Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318127AbSGRPYh>; Thu, 18 Jul 2002 11:24:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318135AbSGRPYh>; Thu, 18 Jul 2002 11:24:37 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:17928 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S318127AbSGRPYg>; Thu, 18 Jul 2002 11:24:36 -0400
Date: Thu, 18 Jul 2002 12:27:08 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Bill Davidsen <davidsen@tmr.com>
cc: stoffel@lucent.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Backups done right (was [ANNOUNCE] Ext3 vs Reiserfs benchmarks)
In-Reply-To: <Pine.LNX.3.96.1020718105612.7522B-100000@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.4.44L.0207181226490.12241-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Jul 2002, Bill Davidsen wrote:
> On Tue, 16 Jul 2002 stoffel@lucent.com wrote:
>
> >   3a. lock mirrored volume, flush any outstanding transactions, break
> >       mirror.
> >                 --or--
> >   3b. snapshot filesystem to another volume.
>
> Good summary. The problem is that 3a either requires a double morror or
> leaving the f/s un mirrored, and 3b can take a very long time for a big
> f/s.

3b should be fairly quick since you only need to do an in-memory
copy of some LVM metadata.

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

