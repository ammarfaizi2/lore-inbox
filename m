Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030308AbWA0LWp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030308AbWA0LWp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 06:22:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030304AbWA0LWp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 06:22:45 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:23514 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1030308AbWA0LWo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 06:22:44 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [PATCH -mm] swsusp: userland interface (rev 2)
Date: Fri, 27 Jan 2006 12:24:12 +0100
User-Agent: KMail/1.9
Cc: Pavel Machek <pavel@ucw.cz>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <200601240929.37676.rjw@sisk.pl> <20060126020926.GR5501@mail> <20060127034248.GA27861@vrfy.org>
In-Reply-To: <20060127034248.GA27861@vrfy.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200601271224.12983.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Friday, 27 January 2006 04:42, Kay Sievers wrote:
> On Wed, Jan 25, 2006 at 09:09:27PM -0500, Jim Crilly wrote:
> > On 01/24/06 11:44:37PM +0100, Pavel Machek wrote:
> > > On Út 24-01-06 17:38:34, Dave Jones wrote:
> > > >  > We'll of course try to get the interface right at the first
> > > >  > try. OTOH... if wrong interface is in kernel for a month, I do not
> > > >  > think it is reasonable to keep supporting that wrong interface for a
> > > >  > year before it can be removed. One month of warning should be fair in
> > > >  > such case...
> > > > 
> > > > Users want to be able to boot between different kernels.
> > > > Tying functionality to specific versions of userspace completely
> > > > screws them over.
> > > 
> > > Well, by the time we have any _users_ interface should be
> > > stable. Actually I believe interface will be stable from day 0, but...
> > >
> > I'm sure gregkh thought the same thing with about sysfs and udev and we've
> > seen how well that's worked out...
> 
> Well, that was just an unfortunate "bug".
> 
> Declaring interfaces "stable" makes as much sense as all the other
> tries to define crazy enterprise "standards" nobody follows in real
> world.
> 
> In a developing environment, interfaces _become_ stable and don't get
> _declared_ by anybody as such. We are not talking about syscall
> interfaces or things that are simple enough to be kept stable, if you
> cross a certain level of complexity, you just can't apply these rules
> anymore.
> 
> Interfaces mature over the time they get used. Only the _use_ of it
> collects the needed information to form the model behind it. They get
> improved up to the point that changing the interface causes more
> pain than it's worth this change. Then an interface has _become_ "stable"
> cause it makes sense at that point.

Agreed.

> "by the time we have any _users_ interface should be stable", that's
> such a nonsense. If you don't have any user, you don't know if this
> interface works at all and only if it gets used you get the needed
> feedback to improve it.

I think Pavel meant "users who don't work on it themselves".

Greetings,
Rafael
