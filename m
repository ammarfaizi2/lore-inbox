Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274862AbRLGL0T>; Fri, 7 Dec 2001 06:26:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282707AbRLGL0J>; Fri, 7 Dec 2001 06:26:09 -0500
Received: from mustard.heime.net ([194.234.65.222]:6283 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S274862AbRLGL0E>; Fri, 7 Dec 2001 06:26:04 -0500
Date: Fri, 7 Dec 2001 12:25:48 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: Bernd Eckenfels <ecki@lina.inka.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: /proc/sys/vm/(max|min)-readahead effect????
In-Reply-To: <E16C3XL-0007nM-00@calista.inka.de>
Message-ID: <Pine.LNX.4.30.0112071224260.28883-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > It works
>
> what results do you get?
>
> >>       echo file_readahead:100 > /proc/ide/ide0/hda/settings

echo file_readahead:1024 > /proc/ide/ide0/hda/settings

...gave me full throughput to the disk (this disk can do ~25MB/s) while
reading 50 files concurrently :-)

--
Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA

Computers are like air conditioners.
They stop working when you open Windows.

