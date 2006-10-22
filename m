Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750734AbWJVU2n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbWJVU2n (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 16:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbWJVU2n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 16:28:43 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:38579 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1750734AbWJVU2n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 16:28:43 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: Freezer.h updated patch.
Date: Sun, 22 Oct 2006 22:27:45 +0200
User-Agent: KMail/1.9.1
Cc: Nigel Cunningham <ncunningham@linuxmail.org>,
       LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
References: <1161519286.3512.12.camel@nigel.suspend2.net> <200610221429.33656.rjw@sisk.pl> <20061022113928.11bdd17f.akpm@osdl.org>
In-Reply-To: <20061022113928.11bdd17f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610222227.45973.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, 22 October 2006 20:39, Andrew Morton wrote:
> On Sun, 22 Oct 2006 14:29:33 +0200
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> 
> > Hi,
> > 
> > On Sunday, 22 October 2006 14:14, Nigel Cunningham wrote:
> > > Hi guys.
> > > 
> > > I missed a couple of "#include <freezer.h>"s in yesterdays patch;
> > > funnily enough the ones in kernel/power! Here's an updated version.
> > > 
> > > Rafael, did you still think the freezer.h contents should go into
> > > suspend.h?
> > 
> > Yes.
> > 
> 
> I think freezer.h is OK.  One 84-line file which does one thing is nice. 
> There's little advantage to putting this code into suspend.h along with a
> bunch of somewhat-unrelated stuff.

All of this stuff has one thing in common: it is only used for suspend
(to disk or to RAM) now.

> And it expresses the point that the freezer could be used for things other
> than suspend.  

Okay, then.  Let's take the patch as is.


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
