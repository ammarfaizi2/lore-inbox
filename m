Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263261AbTDCVIT 
	(for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 16:08:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id S263444AbTDCVIT 
	(for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 16:08:19 -0500
Received: from fmr02.intel.com ([192.55.52.25]:37111 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S263261AbTDCVIR 
	(for <rfc822;linux-kernel@vger.kernel.org>); Thu, 3 Apr 2003 16:08:17 -0500
Message-ID: <F760B14C9561B941B89469F59BA3A84725A248@orsmsx401.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: Dominik Brodowski <linux@brodo.de>, Dave Jones <davej@codemonkey.org.uk>,
       Greg KH <greg@kroah.com>, Pavel Machek <pavel@ucw.cz>,
       Jan Dittmer <j.dittmer@portrix.net>, Mark Studebaker <mds@paradyne.com>,
       azarah@gentoo.org, KML <linux-kernel@vger.kernel.org>,
       sensors@Stimpy.netroedge.com
Subject: RE: lm sensors sysfs file structure
Date: Thu, 3 Apr 2003 13:19:10 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Dominik Brodowski [mailto:linux@brodo.de] 
> > Had occured to me too. There was talk of a libpower or the likes 
> > mentioned on acpi-devel a year or so back, but afaik nothing really 
> > came of it.
> 
> Actually, the "ospmd" tool (available at 
> http://acpi.sourceforge.net ) already seems to > manage APM and 
> ACPI input. Well, and speaking of ACPI and 
> sysfs in the same message: IMHO the /proc/acpi/ interface 
> should be replaced by something in /sysfs/ as well....

Agree w.r.t. ACPI /proc switching to sysfs. Just a matter of someone
sitting down and making the changes.

It is still not clear to me if libpower should subsume libsensors, or
vice versa, or keep them separate. There are areas of overlap, as well
as significant areas of non-overlap.

Regards -- Andy
