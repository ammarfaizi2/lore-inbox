Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316798AbSGQWk5>; Wed, 17 Jul 2002 18:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316803AbSGQWk5>; Wed, 17 Jul 2002 18:40:57 -0400
Received: from pintail.mail.pas.earthlink.net ([207.217.120.122]:46261 "EHLO
	pintail.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S316798AbSGQWk4>; Wed, 17 Jul 2002 18:40:56 -0400
Date: Wed, 17 Jul 2002 14:42:30 -0400
To: lse-tech@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: cpu affinity and lmbench - ac and mjc
Message-ID: <20020717184230.GA11256@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

LMbench shows some differences several local 
communication, local bandwidth, and context switch 
metrics between 2.4.19-pre10-ac2 and 2.4.19-pre10-mjc1.

The latency/bandwidth differences are similar to
2.4.19-pre10aa2 and 2.4.19-jam2, but bigger.  

In trying to isolate the differences in the aa/jam
series, it appeared the irqrate/irqbalance in jam2
was the differentiating factor.  

mjc1 and ac2 are similar to jam/aa. mjc1 is a patchset
to ac2.  mjc1 doesn't include irqrate/irqbalance though.

I ran ac2 with 1 cpu enabled on a quad xeon to get a
better idea of how processor affinity affects lmbench.

Analysis of mjc1, ac2, and ac2 with 1 cpu is here:

http://home.earthlink.net/~rwhron/kernel/lmbench_affinity.html

comments, suggestions welcome.

-- 
Randy Hron
http://home.earthlink.net/~rwhron/kernel/bigbox.html

