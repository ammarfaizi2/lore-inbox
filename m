Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750898AbWHGCKf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750898AbWHGCKf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 22:10:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750897AbWHGCKf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 22:10:35 -0400
Received: from ns1.suse.de ([195.135.220.2]:12171 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750895AbWHGCKf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 22:10:35 -0400
From: Andi Kleen <ak@suse.de>
To: virtualization@lists.osdl.org
Subject: Re: [patch 7/8] Add a bootparameter to reserve high linear address space.
Date: Mon, 7 Aug 2006 04:10:22 +0200
User-Agent: KMail/1.9.3
Cc: Pavel Machek <pavel@ucw.cz>, Jeremy Fitzhardinge <jeremy@xensource.com>,
       akpm@osdl.org, xen-devel@lists.xensource.com,
       Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org
References: <20060803002510.634721860@xensource.com> <20060803002518.595166293@xensource.com> <19700101001522.GA3999@ucw.cz>
In-Reply-To: <19700101001522.GA3999@ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200608070410.22803.ak@suse.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 01 January 1970 01:15, Pavel Machek wrote:
> Hi!
> 
> > Add a bootparameter to reserve high linear address space for hypervisors.
> > This is necessary to allow dynamically loaded hypervisor modules, which
> 
> Dynamically loaded hypervisor? Do we really want to support that?

I hope so. IMHO letting Linux boot first and then the Hypervisor is 
a better design than the other way round which requires a lot of duplicated code.

-Andi
