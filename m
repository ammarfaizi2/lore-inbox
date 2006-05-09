Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751372AbWEIW5k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751372AbWEIW5k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 18:57:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbWEIW5k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 18:57:40 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:42732 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751372AbWEIW5k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 18:57:40 -0400
Date: Tue, 9 May 2006 15:56:59 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Chris Wright <chrisw@sous-sol.org>
cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: Re: [RFC PATCH 05/35] Add sync bitops
In-Reply-To: <20060509085149.024456000@sous-sol.org>
Message-ID: <Pine.LNX.4.64.0605091555540.30338@schroedinger.engr.sgi.com>
References: <20060509084945.373541000@sous-sol.org> <20060509085149.024456000@sous-sol.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 May 2006, Chris Wright wrote:

> Add "always lock'd" implementations of set_bit, clear_bit and
> change_bit and the corresponding test_and_ functions.  Also add
> "always lock'd" implementation of cmpxchg.  These give guaranteed
> strong synchronisation and are required for non-SMP kernels running on
> an SMP hypervisor.

Could you explain why this is done and what is exactly meant with "always 
looked"? Wh the performance impact?
