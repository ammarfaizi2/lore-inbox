Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261560AbVCOGAV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261560AbVCOGAV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 01:00:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262274AbVCOGAU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 01:00:20 -0500
Received: from fire.osdl.org ([65.172.181.4]:47303 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261560AbVCOGAQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 01:00:16 -0500
Date: Mon, 14 Mar 2005 21:59:58 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: nikita@clusterfs.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm counter operations through macros
Message-Id: <20050314215958.15544c65.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0503142148510.16812@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0503110422150.19280@schroedinger.engr.sgi.com>
	<20050311182500.GA4185@redhat.com>
	<Pine.LNX.4.58.0503111103200.22240@schroedinger.engr.sgi.com>
	<16946.62799.737502.923025@gargle.gargle.HOWL>
	<Pine.LNX.4.58.0503142103090.16582@schroedinger.engr.sgi.com>
	<20050314214506.050efadf.akpm@osdl.org>
	<Pine.LNX.4.58.0503142148510.16812@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@sgi.com> wrote:
>
> On Mon, 14 Mar 2005, Andrew Morton wrote:
> 
>  > I don't think the MM_COUNTER_T macro adds much, really.  How about this?
> 
>  Then you wont be able to get rid of the counters by
> 
>  #define MM_COUNTER(xx)
> 
>  anymore.

Why would we want to do that?
