Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161130AbWKEGV2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161130AbWKEGV2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 01:21:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161136AbWKEGV2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 01:21:28 -0500
Received: from ozlabs.org ([203.10.76.45]:60128 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1161130AbWKEGV1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 01:21:27 -0500
Subject: Re: [PATCH 1/7] paravirtualization: header and stubs
	for	paravirtualizing critical operations
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andi Kleen <ak@suse.de>
Cc: Zachary Amsden <zach@vmware.com>, Chris Wright <chrisw@sous-sol.org>,
       virtualization@lists.osdl.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org
In-Reply-To: <200611050646.15334.ak@suse.de>
References: <20061029024504.760769000@sous-sol.org>
	 <200611032209.40235.ak@suse.de>
	 <1162701815.29777.6.camel@localhost.localdomain>
	 <200611050646.15334.ak@suse.de>
Content-Type: text/plain
Date: Sun, 05 Nov 2006 17:21:25 +1100
Message-Id: <1162707685.29777.53.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-11-05 at 06:46 +0100, Andi Kleen wrote:
> > Andi, the patches work against Andrew's tree, and he's merged them in
> > rc4-mm2.  There are a few warnings to clean up, but it seems basically
> > sound.
> > 
> > At this point I our think time is better spent on beating those patches
> > up, rather than going back and figuring out why they don't work in your
> > tree.
> 
> My tree is basically mainline as base. Sure if you don't care about mainline
> merges we can ignore it there and keep it forever in -mm* until Andrew
> gets tired of it?
> 
> That's a possible strategy, but only if you want to keep it as a mm-only
> toy forever.

Andi, it's been simpler for us to get the code into Andrew's tree, in
nice bit-size pieces.  We've had trouble every time we've tried to get
stuff into your tree.  In addition, Andrew's tree gives the code
exposure and testing.

If Andrew says we have to get those patches into mainline through you,
then I'll spend all that time re-spinning the patches for you from the
-mm tree until they go in.  It doesn't seem like a good use of anyone's
time though.

Rusty.

