Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262676AbVG2RQm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262676AbVG2RQm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 13:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262662AbVG2ROX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 13:14:23 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:7179 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S262677AbVG2ROE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 13:14:04 -0400
Date: Fri, 29 Jul 2005 18:14:08 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Daniel Walker <dwalker@mvista.com>
Subject: Re: [PATCH] speed up on find_first_bit for i386 (let compiler do
 the work)
In-Reply-To: <Pine.LNX.4.58.0507290924140.3307@g5.osdl.org>
Message-ID: <Pine.LNX.4.61L.0507291746060.21257@blysk.ds.pg.gda.pl>
References: <1122473595.29823.60.camel@localhost.localdomain> 
 <1122512420.5014.6.camel@c-67-188-6-232.hsd1.ca.comcast.net> 
 <1122513928.29823.150.camel@localhost.localdomain> 
 <1122519999.29823.165.camel@localhost.localdomain> 
 <1122521538.29823.177.camel@localhost.localdomain> 
 <1122522328.29823.186.camel@localhost.localdomain>  <42E8564B.9070407@yahoo.com.au>
  <1122551014.29823.205.camel@localhost.localdomain> 
 <Pine.LNX.4.58.0507280823210.3227@g5.osdl.org>  <1122565640.29823.242.camel@localhost.localdomain>
  <Pine.LNX.4.61L.0507281725010.31805@blysk.ds.pg.gda.pl>
 <1122569848.29823.248.camel@localhost.localdomain> <Pine.LNX.4.58.0507281018170.3227@g5.osdl.org>
 <Pine.LNX.4.61L.0507291456540.21257@blysk.ds.pg.gda.pl>
 <Pine.LNX.4.58.0507290924140.3307@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Jul 2005, Linus Torvalds wrote:

> It has another downside too: it's extra complexity and potential for bugs 
> in the compiler. And if you tell me gcc people never have bugs, I will 
> laugh in your general direction.

 You mean these that have been sitting in their Bugzilla for some three 
years with no resolution and only occasional scratching of heads? ;-)

  Maciej
