Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964853AbWCPUvN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964853AbWCPUvN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 15:51:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964856AbWCPUvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 15:51:12 -0500
Received: from mx1.redhat.com ([66.187.233.31]:53952 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964853AbWCPUvM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 15:51:12 -0500
Date: Thu, 16 Mar 2006 15:50:56 -0500
From: Dave Jones <davej@redhat.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: signal_cache slab corruption.
Message-ID: <20060316205056.GA11091@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Hugh Dickins <hugh@veritas.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20060313181524.GA26234@redhat.com> <Pine.LNX.4.61.0603140921270.5164@goblin.wat.veritas.com> <20060314170153.GB32080@redhat.com> <Pine.LNX.4.61.0603162013350.25141@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0603162013350.25141@goblin.wat.veritas.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2006 at 08:29:08PM +0000, Hugh Dickins wrote:

 > I'd be interested in the signal_cache line from your /proc/slabinfo,
 > to see what cachep->num is usually in your configuration.  But it's
 > an idle interest: I won't have anything interesting to say, whatever
 > it is...

after 3 days of uptime on a slightly newer kernel..
signal_cache         134    143    696   11    2 : tunables   32   16    8 : slabdata     13     13      0 : globalstat   98892    176   173  156                              0    0  129  940 : cpustat  19802  17821  36683      2

the other had seen a little more abuse. These last three days, that
box has been quite idle most of the time, whereas the box that crashed
was my workhorse for most of last week.

		Dave

-- 
http://www.codemonkey.org.uk
