Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262899AbVAFQG1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262899AbVAFQG1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 11:06:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262896AbVAFQGZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 11:06:25 -0500
Received: from dhost001-17.intermedia.net ([64.78.61.64]:32418 "EHLO
	DHOST001-17.DEX001.intermedia.net") by vger.kernel.org with ESMTP
	id S262892AbVAFQGD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 11:06:03 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: ARP routing issue
Date: Thu, 6 Jan 2005 08:06:00 -0800
Message-ID: <B8561865DB141248943E2376D0E85215846787@DHOST001-17.DEX001.intermedia.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: ARP routing issue
Thread-Index: AcT0BzpArmlpjjWGTsOmJlB/oPkNFgAAeoWA
From: "Steve Iribarne" <steve.iribarne@dilithiumnetworks.com>
To: "Jan De Luyck" <lkml@kcore.org>, <linux-kernel@vger.kernel.org>
Cc: <linux-net@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jan,

 
-> default gateway is set to 10.0.22.1, on eth0.
-> 
-> Problem is, if I try to ping from another network 
-> (10.216.0.xx) to 10.0.24.xx, i see the following ARP request:
-> 
-> arp who-has 10.0.22.1 tell 10.0.24.xx
->

You see that coming out the eth0 interface??  

If that is the case it is most definately wrong.  Assuming that your
masks are setup properly.  But I haven't worked on the 2.4 kernel for a
long time so I'm not so sure if what you are seeing is a bug that has
been fixed.

-stv
