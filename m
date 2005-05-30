Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261780AbVE3WB4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261780AbVE3WB4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 18:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261782AbVE3WB4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 18:01:56 -0400
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:45704 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S261780AbVE3WBx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 18:01:53 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: OT] Joerg Schilling flames Linux on his Blog
Date: Tue, 31 May 2005 06:00:31 +0800
Message-ID: <26A66BC731DAB741837AF6B2E29C10171E6158@xmb-hkg-413.apac.cisco.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: OT] Joerg Schilling flames Linux on his Blog
Thread-Index: AcVk/Mw0p/qFDlvTQ/SE5urv89P3VAAY9xyA
From: "Lincoln Dale \(ltd\)" <ltd@cisco.com>
To: "Joerg Schilling" <schilling@fokus.fraunhofer.de>,
       <dtor_core@ameritech.net>
Cc: <mrmacman_g4@mac.com>, <linux-kernel@vger.kernel.org>, <7eggert@gmx.de>
X-OriginalArrivalTime: 30 May 2005 22:01:48.0174 (UTC) FILETIME=[2D0A3AE0:01C56563]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> "Lincoln Dale \(ltd\)" <ltd@cisco.com> wrote:
> 
> > > But what you claim is simply impossible.
> >
> > wrong. again.
> >
> > look up the man page for udev(8), pay particular attention 
> to the part 
> > that can tie devname into device serial number.
> > take note of the example shown under 'serial'.
> 
> Let me give up here :-(
> 
> If you don't understand that the availability of the device 
> serial number is not a basic SCSI feature, it makes no sense 
> to continue this discussion.

bzzt.

oh but it IS a standard SCSI feature.  unit serial number is part of the
VPD page 80h.
Multipathing software for FC HBAs have made use of this for quite a
while now.

(ok, we're quibbling here - its OPTIONAL for a device to support this -
but i can go back ~7 years of SCSI/FC devices i have here and all
devices i've found do return this...).



cheers,

lincoln.
