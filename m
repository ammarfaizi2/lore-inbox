Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271156AbTG1XBL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 19:01:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271159AbTG1XBL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 19:01:11 -0400
Received: from fmr05.intel.com ([134.134.136.6]:55020 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S271156AbTG1XBI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 19:01:08 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: ACPI failure (2.6.0-test<x> and 2.4.22-pre<x>)
Date: Mon, 28 Jul 2003 16:01:05 -0700
Message-ID: <F760B14C9561B941B89469F59BA3A8470255EEB2@orsmsx401.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: ACPI failure (2.6.0-test<x> and 2.4.22-pre<x>)
Thread-Index: AcNVNDko5D9xiU1yR1+tz71VN9+WwAAJlf0g
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "Richard A Nelson" <cowboy@vnet.ibm.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 28 Jul 2003 23:01:05.0940 (UTC) FILETIME=[200A3D40:01C3555C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Richard A Nelson [mailto:cowboy@vnet.ibm.com] 
> On either 2.6, or 2.4, booting with ACPI enabled gets as far as
> parsing the ACPI EC table - at which point it oops with bad pointer
> and halts the system.  Sorry at this point I don't have the register
> contents; it took a while to narrow it this far - and have the
> screen in such a state that I can see any relevant information other
> than the the trying to kill init message :)

Could you try, say, 2.5.70? That would help me understand if it's a
regression or not.

If that also fails, then I think determining exactly where it is oopsing
(probably via printks) would be the next best way to go.

Regards -- Andy
