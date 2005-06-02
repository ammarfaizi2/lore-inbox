Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261652AbVFBXRz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261652AbVFBXRz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 19:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261481AbVFBXRy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 19:17:54 -0400
Received: from fmr21.intel.com ([143.183.121.13]:9092 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S261670AbVFBXQ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 19:16:26 -0400
Date: Thu, 2 Jun 2005 16:15:27 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Ashok Raj <ashok.raj@intel.com>, Andi Kleen <ak@muc.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       discuss@x86-64.org, Rusty Russell <rusty@rustycorp.com.au>,
       Srivattsa Vaddagiri <vatsa@in.ibm.com>
Subject: Re: [patch 5/5] x86_64: Provide ability to choose using shortcuts for IPI in flat mode.
Message-ID: <20050602161527.A16913@unix-os.sc.intel.com>
References: <20050602125754.993470000@araj-em64t> <20050602130112.159708000@araj-em64t> <Pine.LNX.4.61.0506021408080.3157@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.61.0506021408080.3157@montezuma.fsmlabs.com>; from zwane@arm.linux.org.uk on Thu, Jun 02, 2005 at 02:10:47PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 02, 2005 at 02:10:47PM -0600, Zwane Mwaikambo wrote:
> On Thu, 2 Jun 2005, Ashok Raj wrote:
> 
> > This patch provides an option to switch broadcast or use mask version 
> > for sending IPI's. If CONFIG_HOTPLUG_CPU is defined, we choose not to 
> > use broadcast shortcuts by default, otherwise we choose broadcast mode
> > as default.
> > 
> > both cases, one can change this via startup cmd line option, to choose
> > no-broadcast mode.
> > 
> > 	no_ipi_broadcast=1
> > 
> Have you already submitted the i386 version? I think it's a sane fix.


I haven't submitted for i386 yet, i can do the same there as well for flat
mode. I will send one over next...

-- 
Cheers,
Ashok Raj
- Open Source Technology Center
