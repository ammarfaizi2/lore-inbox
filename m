Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262115AbTHUVdV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 17:33:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262910AbTHUVdV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 17:33:21 -0400
Received: from holomorphy.com ([66.224.33.161]:25488 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262115AbTHUVdT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 17:33:19 -0400
Date: Thu, 21 Aug 2003 14:33:50 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Theurer <habanero@us.ibm.com>
Cc: Dave Hansen <haveblue@us.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: CPU boot problem on 2.6.0-test3-bk8
Message-ID: <20030821213350.GJ4306@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Theurer <habanero@us.ibm.com>,
	Dave Hansen <haveblue@us.ibm.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>,
	"Martin J. Bligh" <mbligh@aracnet.com>
References: <200308201658.05433.habanero@us.ibm.com> <200308211056.29876.habanero@us.ibm.com> <1061482159.19036.1716.camel@nighthawk> <200308211202.02871.habanero@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308211202.02871.habanero@us.ibm.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 21, 2003 at 12:02:02PM -0500, Andrew Theurer wrote:
> smp_boot_cpus() bit: 80
> Booting processor 16/114 eip 2000
> Not responding.
> Unmapping cpu 16 from all nodes
> CPU #114 not responding - cannot use it.

cpu_present_to_apicid() needs a similar treatment to dhansen's prior
bits. diff incoming shortly.


-- wli
