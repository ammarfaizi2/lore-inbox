Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263786AbTEFPEt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 11:04:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263788AbTEFPEp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 11:04:45 -0400
Received: from dsl093-002-214.det1.dsl.speakeasy.net ([66.93.2.214]:50188 "EHLO
	pumpkin.fieldses.org") by vger.kernel.org with ESMTP
	id S263786AbTEFPEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 11:04:20 -0400
Date: Tue, 6 May 2003 11:16:44 -0400
To: Matti Aarnio <matti.aarnio@zmailer.org>
Cc: Simon Kelley <simon@thekelleys.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Binary firmware in the kernel - licensing issues.
Message-ID: <20030506151644.GA19898@fieldses.org>
References: <3EB79ECE.4010709@thekelleys.org.uk> <20030506121954.GO24892@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030506121954.GO24892@mea-ext.zmailer.org>
User-Agent: Mutt/1.3.28i
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 06, 2003 at 03:19:54PM +0300, Matti Aarnio wrote:
> On Tue, May 06, 2003 at 12:38:54PM +0100, Simon Kelley wrote:
> > I shall contact Atmel for advice and clarification but my question for
> > the list is, what should I ask them to do? It's unlikely that they will
> > release the source to the firmware and even if they did I wouldn't want
> > firmware source  in the kernel tree since the kernel-build toolchain
> > won't be enough to build the firmware. What permissions do they have to
> > give to make including this stuff legal and compatible with the rest of
> > the kernel?
> 
> Adding a phrase like:  "This firmware binary block is intended to be
> used in BSD/GPL licensed driver"   would definitely clarify it.
> Possibly adding:
>   "Source code/further explanations for this binary block
>    are available at file FFFF.F / are not available."

It's not Atmel whose permission you need to do this, it's the other
kernel developers whose permission you need.  By releasing their code
under the GPL, the people who hold copyright on all the other kernel
code have essentially given you permission to modify and redistribute
their code as long as you make source available for the resulting work.

The question is whether adding this binary blob to the linux kernel
violates the license that the kernel developers gave you.  I can't see
how Amtel saying it's OK would make it so.

--Bruce Fields
