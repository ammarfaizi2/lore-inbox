Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750763AbWJVSkR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbWJVSkR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 14:40:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbWJVSkR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 14:40:17 -0400
Received: from smtp.osdl.org ([65.172.181.4]:42730 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750763AbWJVSkP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 14:40:15 -0400
Date: Sun, 22 Oct 2006 11:39:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Nigel Cunningham <ncunningham@linuxmail.org>,
       LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
Subject: Re: Freezer.h updated patch.
Message-Id: <20061022113928.11bdd17f.akpm@osdl.org>
In-Reply-To: <200610221429.33656.rjw@sisk.pl>
References: <1161519286.3512.12.camel@nigel.suspend2.net>
	<200610221429.33656.rjw@sisk.pl>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Oct 2006 14:29:33 +0200
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> Hi,
> 
> On Sunday, 22 October 2006 14:14, Nigel Cunningham wrote:
> > Hi guys.
> > 
> > I missed a couple of "#include <freezer.h>"s in yesterdays patch;
> > funnily enough the ones in kernel/power! Here's an updated version.
> > 
> > Rafael, did you still think the freezer.h contents should go into
> > suspend.h?
> 
> Yes.
> 

I think freezer.h is OK.  One 84-line file which does one thing is nice. 
There's little advantage to putting this code into suspend.h along with a
bunch of somewhat-unrelated stuff.

And it expresses the point that the freezer could be used for things other
than suspend.  
