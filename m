Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261590AbTITR2g (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Sep 2003 13:28:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261914AbTITR2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Sep 2003 13:28:36 -0400
Received: from dp.samba.org ([66.70.73.150]:60870 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261590AbTITR2f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Sep 2003 13:28:35 -0400
Date: Sun, 21 Sep 2003 03:24:12 +1000
From: Anton Blanchard <anton@samba.org>
To: "Villacis, Juan" <juan.villacis@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, jbarnes@sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.x] additional kernel event notifications
Message-ID: <20030920172412.GD23414@krispykreme>
References: <7F740D512C7C1046AB53446D372001732DEC72@scsmsx402.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7F740D512C7C1046AB53446D372001732DEC72@scsmsx402.sc.intel.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The current event notifications used by tools like Oprofile, while quite
> useful, are not sufficient.  The additional event notifications we
> propose can provide a more complete picture for performance tuning on
> Linux, particularly for dynamically generated code (such as found in
> Java).  

Could you please explain why you cant build on top of oprofile? If arch
specific profilers start going in, we are going to have 5 different ways
of doing the same thing.

We really need to work together on this. We for example have a bunch of
ppc64 profiling stuff but throwing that into the kernel to create yet
another profiler is not the answer.

Anton
