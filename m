Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751163AbWCVJc4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163AbWCVJc4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 04:32:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751164AbWCVJcz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 04:32:55 -0500
Received: from mta2.cl.cam.ac.uk ([128.232.0.14]:49356 "EHLO mta2.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S1751163AbWCVJcz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 04:32:55 -0500
In-Reply-To: <44210C4B.7050307@vmware.com>
References: <20060322063040.960068000@sorel.sous-sol.org> <20060322063751.151430000@sorel.sous-sol.org> <44210C4B.7050307@vmware.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <b996c814fbd26c1521380aed1fdd4a56@cl.cam.ac.uk>
Content-Transfer-Encoding: 7bit
Cc: virtualization@lists.osdl.org, Ian Pratt <ian.pratt@xensource.com>,
       xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org,
       Chris Wright <chrisw@sous-sol.org>
From: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Subject: Re: [Xen-devel] [RFC PATCH 14/35] subarch modify CPU capabilities
Date: Wed, 22 Mar 2006 09:33:09 +0000
To: Zachary Amsden <zach@vmware.com>
X-Mailer: Apple Mail (2.623)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 22 Mar 2006, at 08:35, Zachary Amsden wrote:

> That's pretty heinous.  Suppose Xen decides to start supporting any of 
> these features.  Now, you need to change all of the Xen modified 
> kernels to remove pieces of this.

Well, old kernels would still work and most of those features aren't 
all that useful in a virtualised environment anyway. But, point taken, 
adding a hypervisor trap for CPUID and making use of it would clean up 
that code.

  -- Keir

