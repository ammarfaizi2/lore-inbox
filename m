Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264903AbSJVU4N>; Tue, 22 Oct 2002 16:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264901AbSJVU4J>; Tue, 22 Oct 2002 16:56:09 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:12731 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264900AbSJVU4I>; Tue, 22 Oct 2002 16:56:08 -0400
Subject: Re: [patch] generic nonlinear mappings, 2.5.44-mm2-D0
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@digeo.com>, Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
In-Reply-To: <Pine.LNX.4.44.0210222237180.22860-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0210222237180.22860-100000@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 22 Oct 2002 22:18:26 +0100
Message-Id: <1035321506.329.161.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-10-22 at 21:42, Ingo Molnar wrote:
> 2Tb should still work. And to get to the 16 TB limit you'd have to
> recompile with PAE. It costs some (rather limited) RAM overhead and some
> fork() overhead. I think ext2/ext3fs's current 2Tb/4Tb limit is a much
> bigger problem, you cannot compile around that - are there any patches in
> fact that lift that limit? (well, one solution is to use another
> filesystem.)

At > 2Tb XFS/JFS would probably make a lot more sense anyway. We have
the 320Gb disks available now, no doubt by the time 2.6 is out we'll be
looking at 640Gb disks

