Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932136AbWELPbk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932136AbWELPbk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 11:31:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932140AbWELPbk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 11:31:40 -0400
Received: from duch.mimuw.edu.pl ([193.0.96.2]:46467 "EHLO duch.mimuw.edu.pl")
	by vger.kernel.org with ESMTP id S932139AbWELPbk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 11:31:40 -0400
Date: Fri, 12 May 2006 17:31:39 +0200
From: Tomasz Malesinski <tmal@mimuw.edu.pl>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Segfault on the i386 enter instruction
Message-ID: <20060512153139.GA4852@duch.mimuw.edu.pl>
References: <20060512131654.GB2994@duch.mimuw.edu.pl> <p734pzv73oj.fsf@bragg.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p734pzv73oj.fsf@bragg.suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2006 at 03:50:20PM +0200, Andi Kleen wrote:
> Handling it like you expect would require to disassemble 
> the function in the page fault handler and it's probably not 
> worth doing that for this weird case.

Does it mean that the ENTER instruction should not be used to create
stack frames in Linux programs?

-- 
Tomek Malesinski
