Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315267AbSHXCCA>; Fri, 23 Aug 2002 22:02:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315275AbSHXCCA>; Fri, 23 Aug 2002 22:02:00 -0400
Received: from dsl-213-023-038-001.arcor-ip.net ([213.23.38.1]:39336 "EHLO
	starship") by vger.kernel.org with ESMTP id <S315267AbSHXCB7>;
	Fri, 23 Aug 2002 22:01:59 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marc-Christian Petersen <m.c.p@gmx.net>
Subject: Re: 2.4 kernel series and the oom_killer and /proc/sys/vm/overcommit_memory
Date: Sat, 24 Aug 2002 04:07:43 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <200208221719.50568.m.c.p@gmx.net> <1030037573.3090.3.camel@irongate.swansea.linux.org.uk>
In-Reply-To: <1030037573.3090.3.camel@irongate.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17iQL2-0001VV-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 22 August 2002 19:32, Alan Cox wrote:
> 3 is a totally paranoid [overcommit policy] that will require everything in
> ram can be dumped to swap or paged back from backing store

How do you handle the situation where you have a lot of shared memory in a 
half-paged-out state, so that each shared page consumes both ram and swap?

-- 
Daniel
