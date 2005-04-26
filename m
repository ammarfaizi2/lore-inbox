Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261223AbVDZB5l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261223AbVDZB5l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 21:57:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261248AbVDZB5l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 21:57:41 -0400
Received: from mx1.redhat.com ([66.187.233.31]:48280 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261223AbVDZB5i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 21:57:38 -0400
Date: Mon, 25 Apr 2005 18:57:31 -0700
Message-Id: <200504260157.j3Q1vV6M011223@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86_64: handle iret faults better
In-Reply-To: Linus Torvalds's message of  Monday, 25 April 2005 15:51:32 -0700 <Pine.LNX.4.58.0504251548310.18901@ppc970.osdl.org>
X-Fcc: ~/Mail/linus
X-Shopping-List: (1) Elevated condiments
   (2) Spherical dogs
   (3) Chic winches
   (4) Igneous gratuitous apparitions
   (5) Geopolitical malnutrition
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What would you think about a general hack to let given fixup table entries
say the code wants the trap and error info made available (pushed on the
stack or whatever)?  Conversely, would there be any harm in always setting
->thread.error_code and ->thread.trap_no for a kernel trap?  


Thanks,
Roland
