Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262424AbVCKCQf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262424AbVCKCQf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 21:16:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262393AbVCKCQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 21:16:34 -0500
Received: from ozlabs.org ([203.10.76.45]:28388 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S263083AbVCKCLc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 21:11:32 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16944.65119.216720.79612@cargo.ozlabs.ibm.com>
Date: Fri, 11 Mar 2005 13:11:43 +1100
From: Paul Mackerras <paulus@samba.org>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: werner@sgi.com, torvalds@osdl.org, davej@redhat.com,
       benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: Re: AGP bogosities
In-Reply-To: <200503101804.04371.jbarnes@engr.sgi.com>
References: <16944.62310.967444.786526@cargo.ozlabs.ibm.com>
	<200503101804.04371.jbarnes@engr.sgi.com>
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Barnes writes:

> I have a system in my office with several gfx pipes on different AGP busses, 
> and I'd like that to work well too! :)

Interesting, could you post the output from lspci -v on that system?

What is the relationship in the PCI device tree between the video
cards and their bridges?  Is there for instance only one AGP bridge
per host bridge?

Paul.
