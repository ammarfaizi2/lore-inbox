Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264381AbTDXCAO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 22:00:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264379AbTDXCAO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 22:00:14 -0400
Received: from almesberger.net ([63.105.73.239]:7 "EHLO host.almesberger.net")
	by vger.kernel.org with ESMTP id S264381AbTDXCAN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 22:00:13 -0400
Date: Wed, 23 Apr 2003 23:11:49 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Jamie Lokier <jamie@shareable.org>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Matthias Schniedermeyer <ms@citd.de>, Marc Giger <gigerstyle@gmx.ch>,
       linux-kernel <linux-kernel@vger.kernel.org>, pat@suwalski.net
Subject: Re: [Bug 623] New: Volume not remembered.
Message-ID: <20030423231149.I3557@almesberger.net>
References: <21660000.1051114998@[10.10.2.4]> <20030423164558.GA12202@citd.de> <1508310000.1051116963@flay> <20030423183413.C1425@almesberger.net> <1560860000.1051133781@flay> <20030423191427.D3557@almesberger.net> <1570840000.1051136330@flay> <20030424001134.GD26806@mail.jlokier.co.uk> <20030423214332.H3557@almesberger.net> <20030424011137.GA27195@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030424011137.GA27195@mail.jlokier.co.uk>; from jamie@shareable.org on Thu, Apr 24, 2003 at 02:11:37AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:
> In fact, forget about "volume".  Just have a "silent" parameter that
> defaults to 0,

Default to make useless or disturbing noise ...

> and determines whether the device starts silent or
> loads preset defaults.

So these defaults would be hard-coded values that take into account,
among other factors:

 - the actual audio hardware (e.g. variations in the analog part)
 - possibly the position of a "volume" knob somewhere
 - the environment of the machine (ambient noise, acceptable
   volume level)

And all that for what ? If you want to turn up the volume after
booting, all you need is one whole line in your rc scripts. So
far I haven't seen a single argument as to why this wouldn't be
sufficient.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
