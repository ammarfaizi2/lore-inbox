Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264138AbUESLVJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264138AbUESLVJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 07:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264147AbUESLUw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 07:20:52 -0400
Received: from blackbox.ecweb.com ([199.72.99.40]:1549 "EHLO
	blackbox.ecweb.com") by vger.kernel.org with ESMTP id S264138AbUESLPr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 07:15:47 -0400
Subject: Re: Trivial Comment Patch: 2.6.6-mm3
From: Danny Cox <Danny.Cox@ECWeb.com>
To: Chris Wedgwood <cw@f00f.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040518200742.GA20835@taniwha.stupidest.org>
References: <1084885737.17460.3.camel@vom>
	 <20040518200742.GA20835@taniwha.stupidest.org>
Content-Type: text/plain
Organization: Electronic Commerce Systems
Message-Id: <1084965494.17460.60.camel@vom>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 19 May 2004 07:18:14 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris,

On Tue, 2004-05-18 at 16:07, Chris Wedgwood wrote:
> On Tue, May 18, 2004 at 09:08:57AM -0400, Danny Cox wrote:
> 
> > This fixes a comment in the stack overflow check that's wrong with
> > 4K stacks.
> 
> >  #ifdef CONFIG_DEBUG_STACKOVERFLOW
> > -	/* Debugging check for stack overflow: is there less than 1KB free? */
> > +	/* Debugging check for stack overflow: is there less than 512B free? */
> >  	{
> >  		long esp;
> 
> akpm, how about just yank the line? the comment's sanity depends on a
> CONFIG option and also a value in another file from a far off land.

	IMHO, I'd say keep the line, but remove the offensive part (everything
past the ':', inclusive).

-- 
Daniel S. Cox
Electronic Commerce Systems

