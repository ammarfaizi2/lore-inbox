Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265227AbTLKTWt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 14:22:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265228AbTLKTWs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 14:22:48 -0500
Received: from fmr06.intel.com ([134.134.136.7]:1485 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S265227AbTLKTWr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 14:22:47 -0500
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: Increasing HZ (patch for HZ > 1000)
Date: Thu, 11 Dec 2003 11:22:19 -0800
Message-ID: <F760B14C9561B941B89469F59BA3A84702C931A4@orsmsx401.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Increasing HZ (patch for HZ > 1000)
Thread-Index: AcO/t5qYwhZyo+lzSYS54Xl8w7aeIgAZBkZg
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "Jean-Marc Valin" <Jean-Marc.Valin@USherbrooke.ca>,
       "Martin J. Bligh" <mbligh@aracnet.com>
Cc: "Linux Kernel" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 11 Dec 2003 19:22:19.0618 (UTC) FILETIME=[18527420:01C3C01C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: linux-kernel-owner@vger.kernel.org 
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of 
> Jean-Marc Valin
> > Why would you want to *increase* HZ? I'd say 1000 is 
> already too high
> > personally, but I'm curious what you'd want to do with it? Embedded
> > real-time stuff?
> 
> Actually, my reasons may sound a little strange, but basically I'd be
> fine with HZ=1000 if it wasn't for that annoying ~1 kHz sound when the
> CPU is idle (probably bad capacitors). By increasing HZ to 10 kHz, the
> sound is at a frequency where the ear is much less sensitive. 
> Anyway, I
> thought some people might be interested in high HZ for other (more
> fundamental) reasons, so I posted the patch.

I'd advocate lower HZ. Say, oh I dunno...100? This is better for power
management and also should make the sound go away.

Hmm, I wonder if HZ=10 would break anything :)

Regards -- Andy
