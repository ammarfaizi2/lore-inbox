Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932176AbWDFPFZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932176AbWDFPFZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 11:05:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932178AbWDFPFZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 11:05:25 -0400
Received: from odin2.bull.net ([129.184.85.11]:21233 "EHLO odin2.bull.net")
	by vger.kernel.org with ESMTP id S932176AbWDFPFY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 11:05:24 -0400
From: "Serge Noiraud" <serge.noiraud@bull.net>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: PREEMPT_RT : 2.6.16-rt12 and boot : BUG ?
Date: Thu, 6 Apr 2006 17:05:36 +0200
User-Agent: KMail/1.7.1
Cc: linux-kernel <linux-kernel@vger.kernel.org>
References: <200604061416.00741.Serge.Noiraud@bull.net> <20060406143139.GA28724@elte.hu>
In-Reply-To: <20060406143139.GA28724@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200604061705.36303.Serge.Noiraud@bull.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jeudi 6 Avril 2006 16:31, Ingo Molnar wrote/a écrit :
> 
> * Serge Noiraud <serge.noiraud@bull.net> wrote:
> 
> > input: ImPS/2 Generic Wheel Mouse as /class/input/input1
> > VFS: Mounted root (ext2 filesystem).
> > Fusion MPT base driver 3.03.07
> > Copyright (c) 1999-2005 LSI Logic Corporation
> > Could not allocate 8 bytes percpu data
> > mptscsih: Unknown symbol scsi_remove_host
> 
> could you increase (double) PERCPU_ENOUGH_ROOM in 
> include/linux/percpu.h, does that solve this problem? (and make sure you 
> use -rt13, -rt12 had a couple of bugs)
Tested with rt12 and 192K : same problem
Tested with rt12 and 256K : same problem.
Tested with rt13 and 256K : same problem.
I'm currently compiling with CONFIG_KALLSYMS_ALL not set.
> 
> 	Ingo
> 
> 

-- 
Serge Noiraud
