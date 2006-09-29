Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422826AbWI2VhA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422826AbWI2VhA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 17:37:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422828AbWI2VhA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 17:37:00 -0400
Received: from mx1.redhat.com ([66.187.233.31]:6629 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1422826AbWI2Vg7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 17:36:59 -0400
Date: Fri, 29 Sep 2006 17:36:44 -0400
From: Dave Jones <davej@redhat.com>
To: Andi Kleen <ak@suse.de>
Cc: Ingo Molnar <mingo@elte.hu>, Jim Cromie <jim.cromie@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-mm2
Message-ID: <20060929213644.GH22014@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Andi Kleen <ak@suse.de>,
	Ingo Molnar <mingo@elte.hu>, Jim Cromie <jim.cromie@gmail.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060928014623.ccc9b885.akpm@osdl.org> <200609290108.15400.ak@suse.de> <20060929201449.GA32262@elte.hu> <200609292236.15330.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609292236.15330.ak@suse.de>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2006 at 10:36:15PM +0200, Andi Kleen wrote:

 > The only reason to not use it are old broken BIOS or old CPUs 
 > without local APIC, but those can be all handled at runtime like
 > the 64bit kernel does.
 > 
 > The SUSE kernel has a imho good default heuristic based on 
 > DMI date, DMI number of processors and of course trusting the ACPI tables
 > (don't use if disabled there) 
 
Any plans to push those heuristics to mainline too ?

	Dave
