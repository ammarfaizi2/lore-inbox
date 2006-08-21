Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751320AbWHUX1q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751320AbWHUX1q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 19:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751321AbWHUX1q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 19:27:46 -0400
Received: from rune.pobox.com ([208.210.124.79]:12748 "EHLO rune.pobox.com")
	by vger.kernel.org with ESMTP id S1751320AbWHUX1q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 19:27:46 -0400
Date: Mon, 21 Aug 2006 18:27:38 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Paul Jackson <pj@sgi.com>
Cc: anton@samba.org, simon.derr@bull.net, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH] cpuset code prevents binding tasks to new cpus
Message-ID: <20060821232738.GA11309@localdomain>
References: <20060821132709.GB8499@krispykreme> <20060821104334.2faad899.pj@sgi.com> <20060821192133.GC8499@krispykreme> <20060821204251.GB9828@localdomain> <20060821160454.9e44427b.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060821160454.9e44427b.pj@sgi.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:
> Nathan wrote:
> > -	top_cpuset.cpus_allowed = cpu_online_map;
> > +	top_cpuset.cpus_allowed = cpu_possible_map;
> 
> NAQ
> 
> While this seems sensible on systems not using cpusets (but still using
> kernels configured for cpusets), it is surprising on systems using
> cpusets, on which one expects the cpuset that a task is in to reflect
> the cpus that a task is allowed to use.

Will it actually break anything?

