Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030471AbVLHGna@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030471AbVLHGna (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 01:43:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030473AbVLHGna
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 01:43:30 -0500
Received: from mx1.redhat.com ([66.187.233.31]:10193 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030471AbVLHGna (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 01:43:30 -0500
Date: Thu, 8 Dec 2005 01:43:12 -0500
From: Dave Jones <davej@redhat.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: for_each_online_cpu broken ?
Message-ID: <20051208064312.GG28201@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Andi Kleen <ak@suse.de>,
	linux-kernel@vger.kernel.org
References: <20051208050738.GE24356@redhat.com> <20051208052632.GF11190@wotan.suse.de> <20051208053302.GA28201@redhat.com> <20051208063050.GL11190@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051208063050.GL11190@wotan.suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2005 at 07:30:50AM +0100, Andi Kleen wrote:
 > > This was seen with a .15rc5-git1 kernel.
 > > Is this something still living in your x86-64 patchset or -mm ?
 > 
 > Only the change for less additional CPUs. 

Ok, then I'm at a loss why it's dumping state for NR_CPUS cpus.
I'm away tomorrow, but I'll poke at it some more on Friday.

		Dave

