Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261863AbUKCUWE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261863AbUKCUWE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 15:22:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261865AbUKCUWD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 15:22:03 -0500
Received: from minimail.digi.com ([204.221.110.13]:46579 "EHLO
	minimail.digi.com") by vger.kernel.org with ESMTP id S261863AbUKCUUk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 15:20:40 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: patch for sysfs in the cyclades driver
Date: Wed, 3 Nov 2004 14:20:39 -0600
Message-ID: <71A17D6448EC0140B44BCEB8CD0DA36E04B9D81C@minimail.digi.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: patch for sysfs in the cyclades driver
Thread-Index: AcTB4Db/dWj2VOolS6Ov2E4ZZlm1bgAALCag
From: "Kilau, Scott" <Scott_Kilau@digi.com>
To: "Greg KH" <greg@kroah.com>
Cc: <germano.barreiro@cyclades.com>, <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Maybe we can allow a "custom" name to be sent into the
> > tty_register_device() call?  Like add another option parameter
called
> > "custom_name" that if non-NULL, is used instead of the derived name?

> Why?  What would you call it that would be any different from what we
> use today?  I guess I don't understand why you don't like the kernel
> names.

> greg k-h

Well, tty name compatibly reasons with a couple of our drivers.

Most of our new Linux users for a couple of our older products are
coming
from a specific different OS who are adamant that we keep the tty names
the way they were used to under that OS.

Also, I can see some oddball products out there that might need
only 1 tty out there.

Instead of forcing "ttyoddball0" for the name, it would
be nice to let the driver use "ttyoddball", or whatever it wanted.

In fact, it would be similar to the existing entries for "console" and
"ptmx"...

Scott Kilau
Digi International
