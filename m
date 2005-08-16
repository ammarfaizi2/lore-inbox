Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932366AbVHPTTO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932366AbVHPTTO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 15:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932371AbVHPTTO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 15:19:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:5049 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932366AbVHPTTN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 15:19:13 -0400
Date: Tue, 16 Aug 2005 12:18:53 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Chris Wright <chrisw@osdl.org>
cc: Andrew Morton <akpm@osdl.org>, Zachary Amsden <zach@vmware.com>,
       Chuck Ebbert <76306.1226@compuserve.com>, virtualization@lists.osdl.org,
       linux-kernel <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] i386 / desc_empty macro is incorrect
In-Reply-To: <20050816190509.GE7762@shell0.pdx.osdl.net>
Message-ID: <Pine.LNX.4.58.0508161218230.3553@g5.osdl.org>
References: <200508161306_MC3-1-A75D-6646@compuserve.com> <430233FF.7090106@vmware.com>
 <20050816190509.GE7762@shell0.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 16 Aug 2005, Chris Wright wrote:
> 
> Chuck Ebbert noticed that the desc_empty macro is incorrect.  Fix it.

x86-64 had the same thing. I added that to the fix as obvious.

		Linus
