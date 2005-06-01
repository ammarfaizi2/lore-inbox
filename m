Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261176AbVFALZc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261176AbVFALZc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 07:25:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261190AbVFALZc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 07:25:32 -0400
Received: from holomorphy.com ([66.93.40.71]:54163 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261176AbVFALZ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 07:25:29 -0400
Date: Wed, 1 Jun 2005 04:25:20 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: linux-kernel@vger.kernel.org,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [rfc: patch 0/6] scalable fd management
Message-ID: <20050601112520.GD20782@holomorphy.com>
References: <20050530105042.GA5534@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050530105042.GA5534@in.ibm.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2005 at 04:20:42PM +0530, Dipankar Sarma wrote:
> I would appreciate if someone tests this on an arch without
> cmpxchg (sparc32??). I intend to run some more tests
> with preemption enabled and also on ppc64 myself.

sparc32 SMP is not going to be a good choice for this. By and large
ll/sc -style architectures don't have explicit cmpxchg instructions so
ppc64 at least nominally fits the bill. SMP Alpha testing may also be
enlightening (as usual).


-- wli
