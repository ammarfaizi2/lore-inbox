Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262765AbTEGCAC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 22:00:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262776AbTEGCAC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 22:00:02 -0400
Received: from fmr03.intel.com ([143.183.121.5]:16865 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S262765AbTEGB77 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 21:59:59 -0400
Message-ID: <A46BBDB345A7D5118EC90002A5072C780C8FDF0C@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'Arnaldo Carvalho de Melo'" <acme@conectiva.com.br>,
       "'Gerrit Huizenga'" <gh@us.ibm.com>
Cc: "'Randy.Dunlap'" <rddunlap@osdl.org>,
       "'devenyga@mcmaster.ca'" <devenyga@mcmaster.ca>,
       "'rml@tech9.net'" <rml@tech9.net>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: PATCH: Replace current->state with set_current_state in 2.5.6
	 8
Date: Tue, 6 May 2003 19:12:23 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> From: Arnaldo Carvalho de Melo [mailto:acme@conectiva.com.br]
> 
> > > And I don't really want to review a 176 KB patch (although I did
already
> > > look over most of it a few days ago).  Do people want to take portions
> > > of it for review and then see about Alan merging it, e.g.?

As long as they use set_current_state() and not the __ counterpart,
then they are ok [the memory barrier being to blame for the lost
performance if any is found].

> > Hmm.  Has anyone considered a "Kernel Janitor's" tree?  More
specifically,
> > a patch set, much like -ac or -mm, with the current cleanups so they
> > can be tested, pulled, run through automated batch testing, etc.?
> 
> That is an interesting idea, I'll probably start one.

That's very interesting.

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own
(and my fault)
