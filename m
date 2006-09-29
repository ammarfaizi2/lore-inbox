Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422843AbWI2VrB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422843AbWI2VrB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 17:47:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422841AbWI2VrB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 17:47:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:62157 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1422840AbWI2VrA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 17:47:00 -0400
From: Andi Kleen <ak@suse.de>
To: Dave Jones <davej@redhat.com>
Subject: Re: 2.6.18-mm2
Date: Fri, 29 Sep 2006 23:46:48 +0200
User-Agent: KMail/1.9.3
Cc: Ingo Molnar <mingo@elte.hu>, Jim Cromie <jim.cromie@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060928014623.ccc9b885.akpm@osdl.org> <200609292236.15330.ak@suse.de> <20060929213644.GH22014@redhat.com>
In-Reply-To: <20060929213644.GH22014@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609292346.48376.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 29 September 2006 23:36, Dave Jones wrote:
> On Fri, Sep 29, 2006 at 10:36:15PM +0200, Andi Kleen wrote:
> 
>  > The only reason to not use it are old broken BIOS or old CPUs 
>  > without local APIC, but those can be all handled at runtime like
>  > the 64bit kernel does.
>  > 
>  > The SUSE kernel has a imho good default heuristic based on 
>  > DMI date, DMI number of processors and of course trusting the ACPI tables
>  > (don't use if disabled there) 
>  
> Any plans to push those heuristics to mainline too ?

Yes, probably not for .19 though. I wanted to do it together 
with the removal of the APIC CONFIGs and a lot of cleanup in this
area that will come from that.

-Andi

