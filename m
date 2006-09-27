Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965433AbWI0HpY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965433AbWI0HpY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 03:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965436AbWI0HpY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 03:45:24 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:44006 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S965433AbWI0HpX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 03:45:23 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: When will the lunacy end? (Was Re: [PATCH] uswsusp: add pmops->{prepare,enter,finish} support (aka "platform mode"))
Date: Wed, 27 Sep 2006 09:47:33 +0200
User-Agent: KMail/1.9.1
Cc: Nigel Cunningham <ncunningham@linuxmail.org>, Adrian Bunk <bunk@stusta.de>,
       Pavel Machek <pavel@ucw.cz>, Stefan Seyfried <seife@suse.de>,
       linux-kernel@vger.kernel.org
References: <20060925071338.GD9869@suse.de> <1159335550.5341.25.camel@nigel.suspend2.net> <20060926230040.fbc86f33.akpm@osdl.org>
In-Reply-To: <20060926230040.fbc86f33.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609270947.34408.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 27 September 2006 08:00, Andrew Morton wrote:
> On Wed, 27 Sep 2006 15:39:10 +1000
> Nigel Cunningham <ncunningham@linuxmail.org> wrote:
> 
> > > > If you are saying you will do this job, I can try to redirect such bug 
> > > > reports to the kernel Bugzilla, create a "suspend driver problems" meta 
> > > > bug there, assign it to you and create the dependencies that it tracks 
> > > > the already existing bugs in the kernel Bugzilla.
> > > 
> > > Yes, please do this.
> > > 
> > > [I must say I'm a bit afraid of that but anyway someone has to do it ... ;-)]
> > 
> > :) Can I please get copies too?
> 
> Here are some:

Thanks.

> http://bugme.osdl.org/show_bug.cgi?id=5528

Unresolved, seems to be related to the fact that the support for PowerMac
suspend is still incomplete.

> http://bugzilla.kernel.org/show_bug.cgi?id=5945

Unresolved, the reporter didn't say if the problem is still present in
recent kernels.

> http://bugzilla.kernel.org/show_bug.cgi?id=6101

Old kernel, unidentified driver problem, more information needed from the
reporter.

> http://bugzilla.kernel.org/show_bug.cgi?id=5962

Probably a duplicate of http://bugzilla.kernel.org/show_bug.cgi?id=5534
(resolved), confirmation from the reporter needed.

> http://bugzilla.kernel.org/show_bug.cgi?id=7057

Assigned to Pavel, should be rejected.

> http://bugzilla.kernel.org/show_bug.cgi?id=7067

Duplicate of http://bugzilla.kernel.org/show_bug.cgi?id=6494,
should be fixed by the AHCI suspend patches.

> http://bugzilla.kernel.org/show_bug.cgi?id=7077

Unresolved, assigned to Alan Cox.

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
