Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317890AbSFSOis>; Wed, 19 Jun 2002 10:38:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317892AbSFSOir>; Wed, 19 Jun 2002 10:38:47 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:56455 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S317890AbSFSOir>; Wed, 19 Jun 2002 10:38:47 -0400
Date: Wed, 19 Jun 2002 16:35:46 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Keith Owens <kaos@ocs.com.au>
cc: Robbert Kouprie <robbert@radium.jvb.tudelft.nl>,
       linux-kernel@vger.kernel.org
Subject: Re: The buggy APIC of the Abit BP6 
In-Reply-To: <25764.1024495399@ocs3.intra.ocs.com.au>
Message-ID: <Pine.GSO.3.96.1020619163120.15094K-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jun 2002, Keith Owens wrote:

> You do not have the data required to (a) detect the problem and (b)
> recover even if you could detect the problem.  The APIC bus has a
> single bit checksum, the APIC hardware detects single bit errors and
> does a retransmission.  It _cannot_ detect double bit errors, the bad
> data is accepted and processed with undefined side effects.

 Thanks to the way the checksum is calculated (a two-bit cumulative sum),
about 75% of double-bit errors are detected as well. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

