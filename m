Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284519AbRLER2B>; Wed, 5 Dec 2001 12:28:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284521AbRLER1t>; Wed, 5 Dec 2001 12:27:49 -0500
Received: from mustard.heime.net ([194.234.65.222]:35989 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S284519AbRLER1n>; Wed, 5 Dec 2001 12:27:43 -0500
Date: Wed, 5 Dec 2001 18:27:30 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: <linux-kernel@vger.kernel.org>
Subject: io scheduling / serializing io requests / readahead
Message-ID: <Pine.LNX.4.30.0112051824120.2754-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi

Are there any ways to tell Linux to use some sort of readahead
functionality that'll give me the ability to schedule I/O more loosely, so
some 100 files can be read concurrently without ruining the system by
seeking all the time?

I've tried to alter /proc/sys/vm/(min|max)-readahead, but it doesn't have
any effect...

roy

--
Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA

Computers are like air conditioners.
They stop working when you open Windows.


