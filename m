Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261521AbVGZAUl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261521AbVGZAUl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 20:20:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261543AbVGZAUl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 20:20:41 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:18101 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261521AbVGZAUj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 20:20:39 -0400
Subject: Re: [patch 2.6.13-rc3] i386: clean up user_mode macros
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andi Kleen <ak@suse.de>, Vincent Hanquez <vincent.hanquez@cl.cam.ac.uk>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Chuck Ebbert <76306.1226@compuserve.com>
In-Reply-To: <Pine.LNX.4.58.0507251608430.6074@g5.osdl.org>
References: <200507251901_MC3-1-A589-A433@compuserve.com>
	 <Pine.LNX.4.58.0507251608430.6074@g5.osdl.org>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Mon, 25 Jul 2005 20:20:12 -0400
Message-Id: <1122337212.4895.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-07-25 at 16:13 -0700, Linus Torvalds wrote:

> I _really_ prefer
> 
> 	x != 0
> 
> over 
> 
> 	!!x

Good to hear.  This means that you should have no problem accepting my
previous patch for signal.c that changed the x ^ y to x != y.  And I
would also assume that you prefer x *= 2 over x <<= 1 (also since the
first person to show this example used x <<= 2. Right Lee? :-)

-- Steve


