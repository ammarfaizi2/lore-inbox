Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422893AbWKPKEf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422893AbWKPKEf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 05:04:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422875AbWKPKEf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 05:04:35 -0500
Received: from relay.icomedias.com ([62.99.232.66]:27403 "EHLO
	relay.icomedias.com") by vger.kernel.org with ESMTP
	id S1422868AbWKPKEe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 05:04:34 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: AW: Promise SATA vendor drivers uploaded
Date: Thu, 16 Nov 2006 11:04:31 +0100
Message-ID: <FA095C015271B64E99B197937712FD020F1F2939@freedom.grz.icomedias.com>
In-Reply-To: <455B7D7E.2030400@garzik.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Promise SATA vendor drivers uploaded
Thread-Index: AccI+Agkuva/YMIdSSaVCHbVBT/uOwAamSLA
From: "Martin Bene" <martin.bene@icomedias.com>
To: <linux-ide@vger.kernel.org>
Cc: "Linux Kernel" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> To further assist anyone wishing to hack on sata_promise.c, I just 
> uploaded the long-since-GPL'd vendor drivers for Generation-I and 
> Generation-II chipsets to 
> http://gkernel.sourceforge.net/specs/promise/
> 
> This should help with isolating the proper initialization 
> sequence for a given set of chips, particularly.
> 
> If someone knows of updated versions of these GPL'd drivers, 
> please let me know.

The uploaded versions seem to be version 1.00.0.15 for kernel 2.4 only. 

The newest version (for sataII TX4/300, TX4/150 and friends) I find on
the promise website is 1.01.0.20 for the 2.6 kernel series; not much
newer though, the files are timestamped 2005-07-05.

Also: I'm not quite sure about the license: while the top level files
are GPL, the stuff in cam/ subdirectory seems to have a differenc
license:

 * Copyright (c) 2002 Promise Technology, Inc.  All rights reserved.
 * No part of this document may be reproduced or transmitted in any form
or
 * by any means, electronic or mechanical, for any purpose, without the
 * express written permission of Promise Technology, Inc.

Same license appears in the archives you uploaded to sourceforge btw.

I had been using the promise drivers for quite some time on 2.6.13
because I needed the hotplug functionality - didn't work reliably
though, used to crash the kernel with about 25% probability when
connecting new drives. 

Finaly gave up a few days ago, got a SiI 3114 based controller and
upgraded to 2.6.18 which has the new eh and hotplug for that chipset. 

Bye, Martin
