Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262603AbTKXSdF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 13:33:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262725AbTKXSdF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 13:33:05 -0500
Received: from hosting-agency.de ([195.69.240.23]:55424 "EHLO mailagency.de")
	by vger.kernel.org with ESMTP id S262603AbTKXSdC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 13:33:02 -0500
From: Jakob Lell <jlell@JakobLell.de>
To: Michael Buesch <mbuesch@freenet.de>
Subject: Re: hard links create local DoS vulnerability and security problems
Date: Mon, 24 Nov 2003 19:35:17 +0100
User-Agent: KMail/1.5.4
Cc: root@chaos.analogic.com, linux-kernel@vger.kernel.org
References: <200311241736.23824.jlell@JakobLell.de> <200311241857.41324.jlell@JakobLell.de> <200311241921.50001.mbuesch@freenet.de>
In-Reply-To: <200311241921.50001.mbuesch@freenet.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311241935.17446.jlell@JakobLell.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 24 November 2003 19:21, Michael Buesch wrote:
> On Monday 24 November 2003 18:57, Jakob Lell wrote:
> > > > To solve the problem, the kernel shouldn't allow users to create hard
> > > > links to
> > > > files belonging to someone else.
> > >
> > > No. Users must be able to create hard links to files that belong
> > > to somebody else if they are readable. It's a requirement.
> >
> > If this is REALLY neccessary, it might be possible to prevent hard links
> > to setuid binaries.
>
> What about _not_ modifying the mainstream-kernel behaviour,
> but adding an option, to make users unable to create such hard-links,
> to selinux and/or grsec?
Hello,
this would be possible. However, most admins don't install this patches and 
thus stay vulnerable. Is there any reason why users should be able to create 
hard links to setuid programs belonging to anyone else?
Regards
 Jakob

