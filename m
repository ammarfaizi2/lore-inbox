Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030183AbWCXNgk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030183AbWCXNgk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 08:36:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932619AbWCXNgk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 08:36:40 -0500
Received: from fmr18.intel.com ([134.134.136.17]:10121 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S932585AbWCXNgj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 08:36:39 -0500
Message-ID: <4423F5D5.4070103@linux.intel.com>
Date: Fri, 24 Mar 2006 14:36:21 +0100
From: Arjan van de Ven <arjan@linux.intel.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org, gregkh@suse.de
Subject: Re: [patch] Ignore MCFG if the mmconfig area isn't reserved in the
 e820 table
References: <1143138170.3147.43.camel@laptopd505.fenrus.org>	<200603231856.12227.ak@suse.de>	<1143140539.3147.44.camel@laptopd505.fenrus.org>	<1143141320.3147.47.camel@laptopd505.fenrus.org> <p73k6ak593d.fsf@verdi.suse.de>
In-Reply-To: <p73k6ak593d.fsf@verdi.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> I added the patch to my patchkit now.

thanks

> I also have an older patch (needs a bit
> more cleanup) that checks for all busses if they are reachable using MCFG
> Still needs some more work and interaction check with PCI hotplug though.
>

yes more advanced tests are going to be useful; at least this one was simple and catches
a large portion of the problem cases.
