Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264973AbUGZHeh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264973AbUGZHeh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 03:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264984AbUGZHeh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 03:34:37 -0400
Received: from fmr06.intel.com ([134.134.136.7]:63972 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S264973AbUGZHef convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 03:34:35 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: RE: [patch] kernel events layer
Date: Mon, 26 Jul 2004 00:31:03 -0700
Message-ID: <F989B1573A3A644BAB3920FBECA4D25A6EBFB5@orsmsx407>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch] kernel events layer
Thread-Index: AcRy11yXAKZs8M37REeM/aetuCWnJAACvh8Q
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "Andrew Morton" <akpm@osdl.org>
Cc: <cw@f00f.org>, <rml@ximian.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 26 Jul 2004 07:34:14.0936 (UTC) FILETIME=[F3A97180:01C472E2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Andrew Morton [mailto:akpm@osdl.org]
>
> I hope we'll hear more from Greg on this next week - see if we can come up
> with some way to use the kobject/sysfs namespace for this.
> 
> Although heaven knows how "tmpfs just ran out of space" would map onto
> kobject/sysfs.

methinks: if the message is related to some object that has a kobject
representation, use it. If not, come up with one on a case by case
basis [now this is the difficult one--is where it'd be difficult to
keep things on leash].

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own (and my fault)

