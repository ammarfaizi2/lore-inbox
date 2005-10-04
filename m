Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932158AbVJDOK0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932158AbVJDOK0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 10:10:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932469AbVJDOK0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 10:10:26 -0400
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:14469 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S932158AbVJDOKZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 10:10:25 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andi Kleen <ak@suse.de>
Subject: Re: [RFC][PATCH][Fix] swsusp: Yet another attempt to fix Bug #4959
Date: Tue, 4 Oct 2005 16:11:28 +0200
User-Agent: KMail/1.8.2
Cc: "Discuss x86-64" <discuss@x86-64.org>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
References: <200510011813.54755.rjw@sisk.pl> <200510012145.30067.ak@suse.de> 
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510041611.28763.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, 2 of October 2005 12:06, Rafael J. Wysocki wrote:
> On Saturday, 1 of October 2005 21:45, Andi Kleen wrote:
> > On Saturday 01 October 2005 18:13, Rafael J. Wysocki wrote:
> > 
> > >
> > > This function allocates twice as much memory as needed for the direct
> > > mapping page tables and assigns the second half of it to the resume page
> > > tables.  This area is later marked with PG_nosave by swsusp, so that it is
> > > not overwritten during resume.
> > >
> > I prefered it when the additional page tables were allocated only on demand.
> 
> Me too.  Let's get back to that patch, then. :-)
> 
> Comments etc. will be appreciated.

I haven't got any comments since I posted it on Saturday, so I gather there are
no objections.  Or are there any?

Greetings,
Rafael
