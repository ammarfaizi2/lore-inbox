Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262981AbSLFPR7>; Fri, 6 Dec 2002 10:17:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263215AbSLFPR7>; Fri, 6 Dec 2002 10:17:59 -0500
Received: from rth.ninka.net ([216.101.162.244]:59354 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id <S262981AbSLFPR6>;
	Fri, 6 Dec 2002 10:17:58 -0500
Subject: Re: [RFC] generic device DMA implementation
From: "David S. Miller" <davem@redhat.com>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200212060741.XAA06036@adam.yggdrasil.com>
References: <200212060741.XAA06036@adam.yggdrasil.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 06 Dec 2002 07:50:09 -0800
Message-Id: <1039189809.22320.2.camel@rth.ninka.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-12-05 at 23:41, Adam J. Richter wrote:
> These change
> will eliminate a difficulty in supporting devices on inconsistent-only
> machines

These systems simply do not exist.

You can turn the cache off on pages or the cpu caches are fully coherent
with the device with caches turned on for the page.

What platform is the exception?  Not bothering to implement the
cache-disabled mapping solution does not make a platform a candidate
for the answer to this question.

I think you are solving a non-problem, but if you want me to see your
side of the story you need to give me specific examples of where
pci_alloc_consistent() is "IMPOSSIBLE".

