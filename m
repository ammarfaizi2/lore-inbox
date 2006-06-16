Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751356AbWFPT7K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751356AbWFPT7K (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 15:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751496AbWFPT7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 15:59:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:29577 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751356AbWFPT7J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 15:59:09 -0400
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <clameter@sgi.com>
Subject: Re: [PATCH] Use zoned VM Counters for NUMA statistics V2
Date: Fri, 16 Jun 2006 21:57:41 +0200
User-Agent: KMail/1.9.3
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.64.0606161118210.15940@schroedinger.engr.sgi.com> <200606162119.41293.ak@suse.de> <Pine.LNX.4.64.0606161242130.16315@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0606161242130.16315@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200606162157.41762.ak@suse.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 16 June 2006 21:46, Christoph Lameter wrote:
> On Fri, 16 Jun 2006, Andi Kleen wrote:
> 
> > I don't think such a beast exists so far. So from that
> > angle it doesn't help.
> 
> Hmmm.. Seemed to me that the L1 cacheline size is 64 byte on i386 at least 
> for some modern cpus but then I am not that familiar with i386.

On K8 32bit NUMA has never worked. P4/Xeon has 128 bytes. Woodcrest will have
64 bytes, but so far there are no NUMA systems with it. Even if so
they will likely run 64bit.

-Andi
