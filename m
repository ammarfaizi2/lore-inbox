Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270516AbTGQUTt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 16:19:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270889AbTGQUSr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 16:18:47 -0400
Received: from fmr05.intel.com ([134.134.136.6]:46030 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S270884AbTGQURN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 16:17:13 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: ACPI oops 2.4.21-0.13mdkenterprise
Date: Thu, 17 Jul 2003 13:32:04 -0700
Message-ID: <F760B14C9561B941B89469F59BA3A847E9704B@orsmsx401.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: ACPI oops 2.4.21-0.13mdkenterprise
Thread-Index: AcNMEMuD8fMj3PrQQnGft3saSh7ikwAkXFTA
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "Jonathan Moore" <writetojon@hotmail.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 17 Jul 2003 20:32:04.0647 (UTC) FILETIME=[7C11F370:01C34CA2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Jonathan Moore [mailto:writetojon@hotmail.com] 
> I am deeply stumped! I have two systems with identical Mandrake 9.1
> installations. One Intel D815EEA2L2 wake on lan works. The other Intel
> SE7501WV2 wake on lan does not work. 
> When I echo 5 >/proc/acpi/sleep on the 7501 I get the 
> following kernel oops.
> Is there anything I need to do 'special' when I power down? 
> Is the echo 5 necessary?
> I don't need it on the D815 motherboard for the WOL to work. 
> I am sure the hardware works because on one occasion
> I managed to get it to WOL successfully but I admit I pressed 
> the power button a few times in desperation (or something) 
> needless to say I cannot repeat.

This is fixed in mainline kernels.

BTW you should just run "poweroff" or "halt -p", not echo anything to
proc.

Regards -- Andy
