Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265667AbTAXVEI>; Fri, 24 Jan 2003 16:04:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265670AbTAXVEH>; Fri, 24 Jan 2003 16:04:07 -0500
Received: from flamingo.mail.pas.earthlink.net ([207.217.120.232]:21953 "EHLO
	flamingo.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S265667AbTAXVEF>; Fri, 24 Jan 2003 16:04:05 -0500
Date: Fri, 24 Jan 2003 16:19:06 -0500
To: akpm@digeo.com, piggin@cyberone.com.au
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: Re: big ext3 sequential write improvement in 2.5.51-mm1 gone in 2.5.53-mm1?
Message-ID: <20030124211906.GA15788@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> qsbench isn't really a thing which should be optimised for.

The way I run qsbench simulates an uncommon workload.

> It is important to specify how much memory you have, and how you are
> invoking qsbench.

There is 3.75 GB of ram.  I grab MemTotal from /proc/meminfo, and run
4 qsbench processes.  Each qsbench uses 30% of MemTotal (1089 megs).  

-- 
Randy Hron
http://home.earthlink.net/~rwhron/kernel/bigbox.html

