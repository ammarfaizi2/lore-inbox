Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262365AbVCIUKJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262365AbVCIUKJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 15:10:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262394AbVCIUGm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 15:06:42 -0500
Received: from fire.osdl.org ([65.172.181.4]:3007 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261213AbVCIUFf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 15:05:35 -0500
Date: Wed, 9 Mar 2005 12:04:58 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: Direct io on block device has performance regression on 2.6.x
 kernel
Message-Id: <20050309120458.7c25f5e3.akpm@osdl.org>
In-Reply-To: <200503091721.j29HLNg24054@unix-os.sc.intel.com>
References: <20050308222737.3712611b.akpm@osdl.org>
	<200503091721.j29HLNg24054@unix-os.sc.intel.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Chen, Kenneth W" <kenneth.w.chen@intel.com> wrote:
>
> Andrew Morton wrote on Tuesday, March 08, 2005 10:28 PM
> > But before doing anything else, please bench this on real hardware,
> > see if it is worth pursuing.
> 
> Let me answer the questions in reverse order.  We started with running
> industry standard transaction processing database benchmark on 2.6 kernel,
> on real hardware (4P smp, 64 GB memory, 450 disks) running industry
> standard db application.  What we measured is that with best tuning done
> to the system, 2.6 kernel has a huge performance regression relative to
> its predecessor 2.4 kernel (a kernel from RHEL3, 2.4.21 based).

That's news to me.  I thought we were doing OK with big database stuff. 
Surely lots of people have been testing such things.

> And yes, it is all worth pursuing, the two patches on raw device recuperate
> 1/3 of the total benchmark performance regression.

On a real disk driver?  hm, I'm wrong then.

Did you generate a kernel profile?

