Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932414AbWJKS6X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932414AbWJKS6X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 14:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbWJKS6W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 14:58:22 -0400
Received: from ext-nj2ut-13.online-age.net ([64.14.54.246]:63137 "EHLO
	ext-nj2ut-13.online-age.net") by vger.kernel.org with ESMTP
	id S1751281AbWJKS6W convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 14:58:22 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: GRIO in Linux XFS?
Date: Wed, 11 Oct 2006 14:58:18 -0400
Message-ID: <CAEAF2308EEED149B26C2C164DFB20F4DDE78B@ALPMLVEM06.e2k.ad.ge.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: GRIO in Linux XFS?
Thread-Index: AcbtZzbJ7waav4EISm+KrJy+MZb6lA==
From: "Phetteplace, Thad \(GE Healthcare, consultant\)" 
	<Thad.Phetteplace@ge.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 11 Oct 2006 18:58:19.0279 (UTC) FILETIME=[375B69F0:01C6ED67]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


what is the status of GRIO support in the Linux port of XFS?
Also, if the answer is 'non existent', what is the recommended
alternative?  I've got an application that needs to stream a
huge amount of data to the harddrive without dropping any and
without blocking the sender.  We will be pushing the limits
of our high-end raid striped disks.  This seems the exactly
the type of thing GRIO was made for, but last I heard it was
missing from Linux XFS with no plans to add it.  Any change
in that?  I know I can get almost there with I/O priorities
and the RT features in 2.6... but its not quite the same
thing.
 
Apologies if this has been beat to death here or elsewhere...
I've googled the heck out of this and rummaged around in the
list archives (as much as this fscking corporate firewall will
let me) with little result.  I'll gladly RTFM if someone can
point me at the right one.  :-/

Feel free to CC me on replies, as I read the LKML in digest
format.

Thanks,

Thad Phetteplace

