Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318357AbSIFHSO>; Fri, 6 Sep 2002 03:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318369AbSIFHSO>; Fri, 6 Sep 2002 03:18:14 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:11787 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S318357AbSIFHSN>; Fri, 6 Sep 2002 03:18:13 -0400
Message-ID: <3D785AE4.A7E3DF2D@zip.com.au>
Date: Fri, 06 Sep 2002 00:36:04 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.33 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: Martin.Bligh@us.ibm.com, hadi@cyberus.ca, tcw@tempest.prismnet.com,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com, niv@us.ibm.com
Subject: Re: Early SPECWeb99 results on 2.5.33 with TSO on e1000
References: <18563262.1031269721@[10.10.2.3]> <20020905.235159.128049953.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
> ...
> 
> NAPI is also not the panacea to all problems in the world.
> 

Mala did some testing on this a couple of weeks back.  It appears that
NAPI damaged performance significantly.

http://www-124.ibm.com/developerworks/opensource/linuxperf/netperf/results/july_02/netperf2.5.25results.htm
