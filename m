Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262422AbTENQxL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 12:53:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262578AbTENQxK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 12:53:10 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:64469 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S262422AbTENQxK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 12:53:10 -0400
Date: Wed, 14 May 2003 18:06:30 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Ray Lee <ray-lk@madrabbit.org>
Cc: thomas@horsten.com, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.69 Changes to Kconfig and i386 Makefile to include support for various K7 optimizations
Message-ID: <20030514170630.GA21120@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Ray Lee <ray-lk@madrabbit.org>, thomas@horsten.com,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <1052930982.12607.243.camel@orca.madrabbit.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1052930982.12607.243.camel@orca.madrabbit.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 14, 2003 at 09:49:42AM -0700, Ray Lee wrote:

 > > I don't think this is worth the extra complication. The potential wins
 > > (if any) outweigh the confusion to users who might have no clue as to 
 > > what core they have. 
 > How's about a "This CPU" option instead, a la gcccpuopt [1], that sets
 > the correct CPU options for the current machine/gcc combo?

arch/i386/Makefile already does this. the original poster wanted to
increase the granularity further, splitting athlon into several types
of athlon.

		Dave

