Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261517AbVENXSJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261517AbVENXSJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 19:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261520AbVENXSJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 19:18:09 -0400
Received: from orb.pobox.com ([207.8.226.5]:20406 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S261517AbVENXSG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 19:18:06 -0400
Date: Sat, 14 May 2005 18:17:54 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Srivatsa Vaddagiri <vatsa@in.ibm.com>
Cc: Paul Jackson <pj@sgi.com>, dipankar@in.ibm.com, dino@in.ibm.com,
       Simon.Derr@bull.net, lse-tech@lists.sourceforge.net, akpm@osdl.org,
       nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org,
       rusty@rustcorp.com.au
Subject: Re: [Lse-tech] Re: [PATCH] cpusets+hotplug+preepmt broken
Message-ID: <20050514231754.GN3614@otto>
References: <20050511195156.GE3614@otto> <20050513123216.GB3968@in.ibm.com> <20050513172540.GA28018@in.ibm.com> <20050513125953.66a59436.pj@sgi.com> <20050513202058.GE5044@in.ibm.com> <20050513135233.6eba49df.pj@sgi.com> <20050513210251.GI5044@in.ibm.com> <20050513195851.5d6665d0.pj@sgi.com> <20050514163012.GL3614@otto> <20050514172317.GD32720@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050514172317.GD32720@in.ibm.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Srivatsa Vaddagiri wrote:
> > The changelog leads me to believe that it was intended that the same
> > change should have been made to sched_setaffinity by now.  I think
> > it's safe to remove it; I can't see why it would be necessary any
> > more.
> 
> I recommend that we keep the lock_cpu_hotplug in sched_affinity
> unless we figure out a different way of solving the race I highlighted above
> or we ban code like that in acpi_processor_set_performance :)

Ok, thanks for the education.  I agree.

Nathan
