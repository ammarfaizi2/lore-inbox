Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261678AbULaEyP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261678AbULaEyP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 23:54:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbULaEyO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 23:54:14 -0500
Received: from fw.osdl.org ([65.172.181.6]:59086 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261678AbULaEyM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 23:54:12 -0500
Date: Thu, 30 Dec 2004 20:53:45 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Herbert Poetzl <herbert@13thfloor.at>
cc: "Georg C. F. Greve" <greve@fsfeurope.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PROBLEM: Kernel 2.6.10 crashing repeatedly and hard
In-Reply-To: <20041231041621.GA14321@mail.13thfloor.at>
Message-ID: <Pine.LNX.4.58.0412302052430.2280@ppc970.osdl.org>
References: <m3is6k4oeu.fsf@reason.gnu-hamburg> <Pine.LNX.4.58.0412301239160.22893@ppc970.osdl.org>
 <m3zmzvl9x1.fsf@reason.gnu-hamburg> <Pine.LNX.4.58.0412301418521.22893@ppc970.osdl.org>
 <20041231041621.GA14321@mail.13thfloor.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 31 Dec 2004, Herbert Poetzl wrote:
> 
> maybe this can provide more information (let me know if
> you need an ASCII version, I'll transcribe it by hand then)

Same thing. Some slab corruption causing problems at free time. The 
real problem happened much earlier, so the oops isn't all that useful. 
What would be useful is if you can pinpoint what triggers it and/or when 
it started happening..

		Linus
