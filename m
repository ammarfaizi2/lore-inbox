Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271183AbTG2WSp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 18:18:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271850AbTG2WSp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 18:18:45 -0400
Received: from fmr06.intel.com ([134.134.136.7]:43255 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S271183AbTG2WSi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 18:18:38 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: [2.6.0-test-ac3] ACPI + sensors => health chip flatlines
Date: Tue, 29 Jul 2003 15:18:28 -0700
Message-ID: <F760B14C9561B941B89469F59BA3A847E970A1@orsmsx401.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [2.6.0-test-ac3] ACPI + sensors => health chip flatlines
Thread-Index: AcNWC8u0dIyG6SyMRGmvFTpc345xiAAE2QMg
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "Mika Liljeberg" <mika.liljeberg@welho.com>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 29 Jul 2003 22:18:28.0564 (UTC) FILETIME=[56236140:01C3561F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Mika Liljeberg [mailto:mika.liljeberg@welho.com] 
> This has happened twice now. I have the following in my kernel log:
> 
> acpi_power-0377 [25] acpi_power_transition : Error 
> transitioning device [FAN] to D0
> acpi_bus-0256 [24] acpi_bus_set_power    : Error 
> transitioning device [FAN] to D0
> acpi_thermal-0611 [23] acpi_thermal_active   : Unable to turn 
> cooling device [c1be7d34] 'on'
> 
> Everything under /sys/devices/legacy/i2c-1/1-0290 is frozen 
> to the same
> values, none of the sensors are being updated. 
> 
> Not quite sure what is going on but it looks like an ACPI thermal trip
> routine might be messing up the W83627HF sensor driver.

Greg KH and I have talked about this a little and I think it's going to
be 2.7 before this gets resolved.

-- Andy
