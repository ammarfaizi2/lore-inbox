Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286590AbSAIN46>; Wed, 9 Jan 2002 08:56:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286687AbSAIN4s>; Wed, 9 Jan 2002 08:56:48 -0500
Received: from mustard.heime.net ([194.234.65.222]:37580 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S286590AbSAIN4g>; Wed, 9 Jan 2002 08:56:36 -0500
Date: Wed, 9 Jan 2002 14:56:31 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: Mark Hahn <hahn@physics.mcmaster.ca>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] Error reading multiple large files
In-Reply-To: <Pine.LNX.4.33.0201071413250.5017-100000@coffee.psychology.mcmaster.ca>
Message-ID: <Pine.LNX.4.30.0201091454060.6953-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> you really should try akpm's "[patch, CFT] improved disk read latency"
> patch.  it sounds almost perfect for your application.

hi

It seemed like it helped first, but after a while, some 99 processes went
Defunct, and locked. After this, the total 'bi' as reported from vmstat
went down to ~ 900kB per sec

What should I do? Run Windoze?

--
Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA

Computers are like air conditioners.
They stop working when you open Windows.

