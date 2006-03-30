Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932206AbWC3NZf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932206AbWC3NZf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 08:25:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932207AbWC3NZf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 08:25:35 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:7851 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932206AbWC3NZe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 08:25:34 -0500
Date: Thu, 30 Mar 2006 18:53:59 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: balbir@in.ibm.com, nagar@watson.ibm.com, greg@kroah.com,
       arjan@infradead.org, hadi@cyberus.ca, ak@suse.de,
       linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] Re: [Patch 0/8] per-task delay accounting
Message-ID: <20060330132359.GB1701@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <442B271D.10208@watson.ibm.com> <20060329210314.3db53aaa.akpm@osdl.org> <20060330062357.GB18387@in.ibm.com> <20060329224737.071b9567.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060329224737.071b9567.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2006 at 10:47:37PM -0800, Andrew Morton wrote:
> 
> Sounds fine to me, but I'm not a stakeholder.
> 
> Trolling back through lse-tech gives us:
> 
> Scalable statistics counters with /proc reporting:
>   Ravikiran G Thirumalai <kiran@in.ibm.com>
>   (Kiran feft IBM, but presumably the requirement lives on)

Not necessarily in that form. A lot of statistics has now become
per-cpu, something we wanted to achieve back then. Automatic
/proc reporting was an idea only tossed around, but /proc is now
deprecated for such things. There may be a need for fast export of 
counters to userspace, but those requirements are not yet clear.

This is different from per-task accounting infrastructure that
people are trying to develop.

Thanks
Dipankar
