Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267822AbTAMQkt>; Mon, 13 Jan 2003 11:40:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267882AbTAMQks>; Mon, 13 Jan 2003 11:40:48 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:20097 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S267827AbTAMQkY>; Mon, 13 Jan 2003 11:40:24 -0500
Date: Mon, 13 Jan 2003 11:49:08 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: Ravikiran G Thirumalai <kiran@in.ibm.com>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] Make prof_counter use per-cpu areas patch 4/4 -- sparc arch
Message-ID: <20030113114908.B18786@devserv.devel.redhat.com>
References: <20030113122835.GC2714@in.ibm.com> <20030113123825.GF2714@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030113123825.GF2714@in.ibm.com>; from kiran@in.ibm.com on Mon, Jan 13, 2003 at 06:08:25PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: 	Mon, 13 Jan 2003 18:08:25 +0530
> From: Ravikiran G Thirumalai <kiran@in.ibm.com>

> This one's for sparc
> -unsigned int prof_counter[NR_CPUS];
> +DEFINE_PER_CPU(unsigned int, prof_counter);

Thanks. I'll apply at next pull, or Dave will.

-- Pete
