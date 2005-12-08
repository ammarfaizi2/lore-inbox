Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932740AbVLHXf0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932740AbVLHXf0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 18:35:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932737AbVLHXfZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 18:35:25 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:8108 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S932695AbVLHXfY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 18:35:24 -0500
Date: Thu, 8 Dec 2005 15:35:05 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Andi Kleen <ak@suse.de>
cc: akpm@osdl.org, Christoph Hellwig <hch@infradead.org>,
       linux-ia64@vger.kernel.org, steiner@sgi.com,
       linux-kernel@vger.kernel.org, Wu Fengguang <wfg@mail.ustc.edu.cn>,
       discuss@x86-64.org
Subject: Re: [discuss] Re: [PATCH 1/3] Zone reclaim V3: main patch
In-Reply-To: <20051208232827.GZ11190@wotan.suse.de>
Message-ID: <Pine.LNX.4.62.0512081531150.31342@schroedinger.engr.sgi.com>
References: <20051208203707.30456.57439.sendpatchset@schroedinger.engr.sgi.com>
 <20051208210850.GS11190@wotan.suse.de> <Pine.LNX.4.62.0512081320200.30786@schroedinger.engr.sgi.com>
 <20051208225102.GW11190@wotan.suse.de> <Pine.LNX.4.62.0512081514510.31246@schroedinger.engr.sgi.com>
 <20051208232827.GZ11190@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Dec 2005, Andi Kleen wrote:

> > My experience is that at 20 systems do not need zone reclaim yet.
> 
> I really cannot confirm your experience here.

Maybe the meaning of these numbers varies? I know that 10 is a local 
access but the assumption in include/linux/numa.h that 20 is a remote 
access is probably already a guess.

I know that our Altix machines seem to use 10 for a local and 20 for 
nonlocal but same box. The distances then increase from there.

