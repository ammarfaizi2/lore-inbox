Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751038AbVJQRJm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751038AbVJQRJm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 13:09:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751044AbVJQRJm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 13:09:42 -0400
Received: from cantor2.suse.de ([195.135.220.15]:3302 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751038AbVJQRJl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 13:09:41 -0400
From: Andi Kleen <ak@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: x86_64: 2.6.14-rc4 swiotlb broken
Date: Mon, 17 Oct 2005 19:09:54 +0200
User-Agent: KMail/1.8
Cc: Andrew Morton <akpm@osdl.org>, Ravikiran G Thirumalai <kiran@scalex86.org>,
       linux-kernel@vger.kernel.org, discuss@x86-64.org, tglx@linutronix.de,
       shai@scalex86.org
References: <20051017093654.GA7652@localhost.localdomain> <200510171826.40711.ak@suse.de> <Pine.LNX.4.64.0510170938240.23590@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510170938240.23590@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510171909.54860.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 17 October 2005 18:42, Linus Torvalds wrote:
> We call it "low" memory because it happens to have "low" addresses.

Well in NUMA bootmem it never was, unless you registered the nodes reversed.
It always starts with the highest node
(which I can't easily do, ARM does it so fixing it properly breaks them) 

-Andi
