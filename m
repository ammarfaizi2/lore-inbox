Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932443AbWBGDNk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932443AbWBGDNk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 22:13:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932445AbWBGDNk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 22:13:40 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:64923 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932443AbWBGDNj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 22:13:39 -0500
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10]
	[Suspend2] Modules support.)
From: Lee Revell <rlrevell@joe-job.com>
To: Jim Crilly <jim@why.dont.jablowme.net>
Cc: Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       Nigel Cunningham <nigel@suspend2.net>,
       suspend2-devel@lists.suspend2.net, linux-kernel@vger.kernel.org
In-Reply-To: <20060207030129.GA23860@mail>
References: <20060201113710.6320.68289.stgit@localhost.localdomain>
	 <1139251682.2791.290.camel@mindpipe>
	 <200602070625.49479.nigel@suspend2.net> <200602070051.41448.rjw@sisk.pl>
	 <20060207003713.GB31153@voodoo> <20060207004611.GD1575@elf.ucw.cz>
	 <20060207005930.GD31153@voodoo> <1139275143.2041.24.camel@mindpipe>
	 <20060207030129.GA23860@mail>
Content-Type: text/plain
Date: Mon, 06 Feb 2006 22:13:36 -0500
Message-Id: <1139282017.2041.44.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.90 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-02-06 at 22:01 -0500, Jim Crilly wrote:
> On 02/06/06 08:19:02PM -0500, Lee Revell wrote:
> > On Mon, 2006-02-06 at 19:59 -0500, Jim Crilly wrote:
> > > I guess reasonable is a subjective term. For instance, I've seen quite
> > > a few people vehemently against adding new ioctls to the kernel and
> > > yet you'll be adding quite a few for /dev/snapshot. I'm just of the
> > > same mind as Nigel in that it makes the most sense to me that the
> > > majority of the suspend/hibernation process to be in the kernel. 
> > 
> > No one is saying that ANY new ioctls are bad, just that the KISS
> > principle of engineering dictates that it's bad design to use ioctls
> > where a simple read/write to a sysfs file will do.
> > 
> 
> I understand that, but shouldn't the KISS principle also be applied to
> the user interface of a feature?

Personally I agree with you on suspend2, I think this is something that
needed to Just Work yesterday, and every day it doesn't work we are
losing users... but who am I to talk, I'm not the one who will have to
maintain it.

Lee

