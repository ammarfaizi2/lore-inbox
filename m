Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264151AbTEORQH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 13:16:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264152AbTEORQG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 13:16:06 -0400
Received: from ns.suse.de ([213.95.15.193]:54278 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264151AbTEORQG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 13:16:06 -0400
Date: Thu, 15 May 2003 19:28:55 +0200
From: Andi Kleen <ak@suse.de>
To: john stultz <johnstul@us.ibm.com>
Cc: Andi Kleen <ak@suse.de>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>, "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: [PATCH] linux-2.5.69_subarch-fix_A0.patch
Message-ID: <20030515172855.GA10831@Wotan.suse.de>
References: <1052966228.9630.69.camel@w-jstultz2.beaverton.ibm.com> <20030515065120.GA3469@Wotan.suse.de> <1053019259.9630.91.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1053019259.9630.91.camel@w-jstultz2.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You did get around it in the generic subarch (which I love, by the way,
> thanks so much for doing that work), but in a roundabout way. (via
> #ifdef APIC_DEFINITION trickery). 

The best fix is probably to just remove the summit selection and replace
it with the generic architecture.

-Andi
