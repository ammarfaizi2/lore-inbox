Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262548AbTEVIEb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 04:04:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262567AbTEVIEb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 04:04:31 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:23637 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S262548AbTEVIEa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 04:04:30 -0400
Date: Thu, 22 May 2003 08:17:23 +0000
From: Arjan van de Ven <arjanv@redhat.com>
To: Keith Mannthey <kmannth@us.ibm.com>
Cc: Zwane Mwaikambo <zwane@linuxpower.ca>,
       "Martin J. Bligh" <mbligh@aracnet.com>, davem@redhat.com,
       habanero@us.ibm.com, haveblue@us.ibm.com, wli@holomorphy.com,
       arjanv@redhat.com, pbadari@us.ibm.com,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       gh@us.ibm.com, johnstul@us.ltcfwd.linux.ibm, jamesclv@us.ibm.com,
       Andrew Morton <akpm@digeo.com>
Subject: Re: =?iso-8859-1?Q?userspace_irq_balancer=C2=A0?=
Message-ID: <20030522081723.B25926@devserv.devel.redhat.com>
References: <1053541725.16886.4711.camel@dyn9-47-17-180.beaverton.ibm.com> <1053560371.19335.4725.camel@dyn9-47-17-180.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1053560371.19335.4725.camel@dyn9-47-17-180.beaverton.ibm.com>; from kmannth@us.ibm.com on Wed, May 21, 2003 at 04:39:29PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 21, 2003 at 04:39:29PM -0700, Keith Mannthey wrote:
>   This makes building meaningful apicid masks (more than one cpu) a bit
> tricky.  For example a user would have to know that cpus 1,2,9,10 were
> on the same cluster not (1,2,3,4) as you would expect. Since the bios
> can do what it will it makes it hard to build masks of capable clusters
> easily in all situations.

with sysfs the kernel can export some topology info; iirc that was desired
anyway for other HPC applications anyway ?

