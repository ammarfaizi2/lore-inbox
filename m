Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261735AbREPAgs>; Tue, 15 May 2001 20:36:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261736AbREPAgj>; Tue, 15 May 2001 20:36:39 -0400
Received: from snowbird.megapath.net ([216.200.176.7]:48907 "EHLO
	megapathdsl.net") by vger.kernel.org with ESMTP id <S261735AbREPAg0>;
	Tue, 15 May 2001 20:36:26 -0400
Subject: Re: LANANA: To Pending Device Number Registrants
From: Miles Lane <miles@megapathdsl.net>
To: Tim Jansen <tim@tjansen.de>
Cc: David Brownell <david-b@pacbell.net>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <01051601562302.01000@cookie>
In-Reply-To: <047801c0dd95$231331e0$6800000a@brownell.org> 
	<01051601562302.01000@cookie>
Content-Type: text/plain
X-Mailer: Evolution/0.10 (Preview Release)
Date: 15 May 2001 17:41:29 -0700
Message-Id: <989973690.925.7.camel@agate>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 May 2001 01:56:23 +0200, Tim Jansen wrote:
> On Wednesday 16 May 2001 01:16, David Brownell wrote:
> >Only if it's augmented by additional device IDs, such as the
> >"what 's the physical connection for this interface" sort of
> >primitive that's been mentioned.
> >[...]
> > I suppose that for network interface names, some convention for
> > interface ioctls would suffice to solve that "identify" step.  PCI
> > devices would return the slot_name, USB devices need something
> > like a patch I posted to linux-usb-devel a few months back.
> 
> At this point of the discussion I would like to point to the Device Registry 
> patch (http://www.tjansen.de/devreg) that already solves these problems and 
> offers stable device ids for the identification of devices and finding their 
> /dev nodes.

Does your approach solve the problem of USB devices, like mice, that
don't have device ID's of any sort, where topology is the only way to 
distinguish them?  IIRC, the USB development team was planning to use
topology to provide a limited ability to associate a mouse on a given
port with a display, when XFree86 supports per-Xinerama-display input
device associations.
They new VT console work would benefit from this, too.

    Miles


