Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262759AbUCOVlS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 16:41:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262762AbUCOVlS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 16:41:18 -0500
Received: from ztxmail04.ztx.compaq.com ([161.114.1.208]:32011 "EHLO
	ztxmail04.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S262759AbUCOVlR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 16:41:17 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: RE: major number 115 changed ! Conflict ?
Date: Mon, 15 Mar 2004 15:40:36 -0600
Message-ID: <C50AB9511EE59B49B2A503CB7AE1ABD10661138E@cceexc19.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: major number 115 changed ! Conflict ?
Thread-Index: AcQKqHGb00toIYVWQ/Kjgx8XDeEDmAALVSYA
From: "Cagle, John (ISS-Houston)" <john.cagle@hp.com>
To: "Romain Lievin" <romain@lievin.net>
Cc: <greg@kroah.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 15 Mar 2004 21:41:16.0196 (UTC) FILETIME=[3E8D8E40:01C40AD6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Romain Liévin wrote:
> I noticed that major 115 points on /dev/speaker. 
> Nevertheless, this number has been officially (?) allocated 
> to me for tipar.o and tiglusb.o modules in March 2002. These 
> modules are within the 2.4 & 2.6 kernels.
> 
> Is there anyone who can tell me whether it's correct ? May a 
> conflict be possible with the speaker device if tipar/tiglusb 
> are loaded ?

Character Major 115 is still allocated for your ti link cable
devices.  To verify, just check www.lanana.org.

The devices.txt file hasn't been kept current in the bk trees,
but I'm in the process of preparing a patch to update it and I
hope it will be accepted.

Regards,
John Cagle

device@lanana.org
jcagle@kernel.org

