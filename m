Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261998AbVDLBMl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261998AbVDLBMl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 21:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261999AbVDLBMl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 21:12:41 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:51348
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S261998AbVDLBMj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 21:12:39 -0400
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Shawn Starr <shawn.starr@rogers.com>
Subject: Policy question (was Re: [2.6.12-rc1][ACPI][suspend] /proc/acpi/sleep vs /sys/power/state issue - 'standby' on a laptop)
Date: Mon, 11 Apr 2005 20:09:28 -0400
User-Agent: KMail/1.6.2
Cc: Pavel Machek <pavel@ucw.cz>, LKML <linux-kernel@vger.kernel.org>,
       acpi-devel@lists.sourceforge.net
References: <20050406212221.75716.qmail@web88010.mail.re2.yahoo.com>
In-Reply-To: <20050406212221.75716.qmail@web88010.mail.re2.yahoo.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200504112009.30928.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 06 April 2005 05:22 pm, Shawn Starr wrote:
> --- Pavel Machek <pavel@ucw.cz> wrote:
> > Hi!
> >
> > > So nobody minds if I make this into a CONFIG
> >
> > option marked as Deprecated? :)
> >
> > Actually it should probably go through
> >
> > Documentation/feature-removal-schedule.txt
> >
> > ...and give it *long* timeout, since it is API
> > change.
> > 									Pavel

Shouldn't all deprecated features be in feature-removal-schedule.txt?

There are four entries in feature-removal-schedule in 2.6.12-rc2, but
`find . -name "Kconfig" | xargs grep -i deprecated` finds eight entries.  (And 
there's more if the grep -i is for "obsolete" instead...)

Just wondering...

Rob
