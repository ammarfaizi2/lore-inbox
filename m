Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263490AbTDNPym (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 11:54:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263501AbTDNPym (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 11:54:42 -0400
Received: from air-2.osdl.org ([65.172.181.6]:63453 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263490AbTDNPym (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 11:54:42 -0400
Date: Mon, 14 Apr 2003 10:16:34 -0500 (CDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: "Grover, Andrew" <andrew.grover@intel.com>
cc: Dominik Brodowski <linux@brodo.de>, Dave Jones <davej@codemonkey.org.uk>,
       Greg KH <greg@kroah.com>, Pavel Machek <pavel@ucw.cz>,
       Jan Dittmer <j.dittmer@portrix.net>, Mark Studebaker <mds@paradyne.com>,
       <azarah@gentoo.org>, KML <linux-kernel@vger.kernel.org>,
       <sensors@Stimpy.netroedge.com>
Subject: RE: lm sensors sysfs file structure
In-Reply-To: <F760B14C9561B941B89469F59BA3A84725A248@orsmsx401.jf.intel.com>
Message-ID: <Pine.LNX.4.44.0304141014370.9285-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> It is still not clear to me if libpower should subsume libsensors, or
> vice versa, or keep them separate. There are areas of overlap, as well
> as significant areas of non-overlap.

IMHO, neither should subsume the other; there should be a 'libdevice', or
similar that has both a sensor and a power component to it.


	-pat

