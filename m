Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264095AbTKZJUw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 04:20:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264104AbTKZJUw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 04:20:52 -0500
Received: from mail-01.iinet.net.au ([203.59.3.33]:10904 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S264095AbTKZJUv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 04:20:51 -0500
Message-ID: <3FC46FB1.2080604@cyberone.com.au>
Date: Wed, 26 Nov 2003 20:17:37 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>,
       LSE <lse-tech@lists.sourceforge.net>
Subject: General scheduling domains take 2
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

http://www.kerneltrap.org/~npiggin/w24/

I have progressed a bit further, and the data structure is slightly
changed.

I have done code to build the scheduling description for SMT P4s. It
can be enabled with a new config option although don't try this with
NUMA yet (easy to fix). Note this is quite unlikely to actually do
any good on a pentium 4 because I haven't been able to test it!

The generic scheduling description works nicely on the 16 way NUMAQ
at OSDL and gives results very close to those I was getting before,
so I think I have done a good job at recreating that scheduling policy,
and the scheduling domains doesn't appear to have too much overhead.

The data structure is a bit difficult to understand. I have the start
of a paper here http://www.kerneltrap.org/~npiggin/paper.ps.gz but its
only really worth looking at for the pictures at the end for now.

Questions, comments welcome.

Nick


