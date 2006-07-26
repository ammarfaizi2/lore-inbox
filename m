Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030373AbWGZDZx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030373AbWGZDZx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 23:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030374AbWGZDZx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 23:25:53 -0400
Received: from ozlabs.org ([203.10.76.45]:30098 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1030373AbWGZDZw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 23:25:52 -0400
Subject: Re: [PATCH 5/6] Begin abstraction of sensitive instructions:
	asm	files
From: Rusty Russell <rusty@rustcorp.com.au>
To: Peter Chubb <peter@chubb.wattle.id.au>
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>
In-Reply-To: <873bcp6y3s.wl%peter@chubb.wattle.id.au>
References: <200607212326_MC3-1-C5B8-F9ED@compuserve.com>
	 <1153575288.13198.16.camel@localhost.localdomain>
	 <873bcp6y3s.wl%peter@chubb.wattle.id.au>
Content-Type: text/plain
Date: Wed, 26 Jul 2006 13:25:47 +1000
Message-Id: <1153884349.5500.55.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-07-26 at 09:52 +1000, Peter Chubb wrote:
> >>>>> "Rusty" == Rusty Russell <rusty@rustcorp.com.au> writes:
> 
> Rusty> 	Agreed: certainly eax should be mentioned.  GET_CR0_INTO_EAX?
> Rusty> MOV is a bit close to describing how it's happening (which, on
> Rusty> paravirt it might not be) so it might lead the reader to
> Rusty> unwarranted assumptions.
> 
> Aren't these ideal cases to use a tool to convert, rather than adding
> manual changes to the source?  The `afterburner' approach works quite
> well for this kind of thing.

Agreed, afterburner works well in that it's minimally invasive in the
source.  However, that is precisely the opposite of the aim of patches
like this one which are integrated: that the source code be explicit.

Cheers,
Rusty.
-- 
Help! Save Australia from the worst of the DMCA: http://linux.org.au/law

