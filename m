Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262219AbVCOD2J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262219AbVCOD2J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 22:28:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262221AbVCOD2J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 22:28:09 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:63384 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262219AbVCOD16 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 22:27:58 -0500
Date: Mon, 14 Mar 2005 19:22:03 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Albert Cahalan <albert@users.sourceforge.net>
cc: Matt Mackall <mpm@selenic.com>, john stultz <johnstul@us.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       George Anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Dominik Brodowski <linux@dominikbrodowski.de>,
       David Mosberger <davidm@hpl.hp.com>, Andi Kleen <ak@suse.de>,
       paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, Patricia Gaughen <gone@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>, Max Asbock <masbock@us.ibm.com>,
       mahuja@us.ibm.com, Nishanth Aravamudan <nacc@us.ibm.com>,
       Darren Hart <darren@dvhart.com>, "Darrick J. Wong" <djwong@us.ibm.com>,
       Anton Blanchard <anton@samba.org>, donf@us.ibm.com
Subject: Re: [RFC][PATCH] new timeofday core subsystem (v. A3)
In-Reply-To: <1110852973.1967.180.camel@cube>
Message-ID: <Pine.LNX.4.58.0503141920460.16054@schroedinger.engr.sgi.com>
References: <1110590655.30498.327.camel@cog.beaverton.ibm.com> 
 <20050313004902.GD3163@waste.org>  <1110825765.30498.370.camel@cog.beaverton.ibm.com>
  <20050314192918.GC32638@waste.org>  <1110829401.30498.383.camel@cog.beaverton.ibm.com>
  <20050314195110.GD32638@waste.org>  <1110830647.30498.388.camel@cog.beaverton.ibm.com>
  <20050314202702.GF32638@waste.org> <1110852973.1967.180.camel@cube>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Mar 2005, Albert Cahalan wrote:

> When the vsyscall page is created, copy the one needed function
> into it. The kernel is already self-modifying in many places; this
> is nothing new.

AFAIK this will only works on ia32 and x86_64 and not definitely not
on ia64. Who knows about the other platforms ....

