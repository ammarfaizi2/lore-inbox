Return-Path: <linux-kernel-owner+w=401wt.eu-S936966AbWLKSYT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936966AbWLKSYT (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 13:24:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937034AbWLKSYT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 13:24:19 -0500
Received: from dxv00.wellsfargo.com ([151.151.5.40]:35870 "EHLO
	dxv00.wellsfargo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936966AbWLKSYT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 13:24:19 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
Subject: RE: Interphase Tachyon drivers missing.
Date: Mon, 11 Dec 2006 12:22:59 -0600
Message-ID: <E8C008223DD5F64485DFBDF6D4B7F71D023BAB31@msgswbmnmsp25.wellsfargo.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Interphase Tachyon drivers missing.
Thread-Index: AccdTrFnvzUrB7TpSpqSw/lILFxKugAAe8cw
From: <Greg.Chandler@wellsfargo.com>
To: <jeff@garzik.org>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 11 Dec 2006 18:22:59.0409 (UTC) FILETIME=[6303AC10:01C71D51]
X-WFMX: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


My guess is that since it's not in there, I might be the only one who
noticed.  Unfortunatly that looks to be bad news for me...  I have 5
machines with these cards, and my pockets are not so deep as to be able
to replace them with something newer.  

My goal was to get AOE working over the FC card {rather than ethernet}
and retire my FC SAN.  {I have my moments for doing stupid things like
this} {and yes it was a bet....}

I took a brief look at the code {I am no developer, let alone a driver
maintainer} but I think I can get the driver shored up with a current
kernel {I hope}.  The question is will anyone other than me care,
because if not, I doubt that the driver will be re-added from what you
said.


-----Original Message-----
From: Jeff Garzik [mailto:jeff@garzik.org] 
Sent: Monday, December 11, 2006 12:03 PM
To: Chandler, Greg
Cc: linux-kernel@vger.kernel.org
Subject: Re: Interphase Tachyon drivers missing.

Greg.Chandler@wellsfargo.com wrote:
> I went to upgrade my kernel on a couple of boxes yesterday and noticed

> that the Interphase Tachyon chipset Fibre Channel driver was removed 
> from the kernel.  I think 2.6.1 was the last one it was still in.  Was

> there a reason it was pulled?
> If not, do I have to volunteer to put it back in or can someone with 
> more skill re-add it?

It was dropped because it was unmaintained, and quickly falling behind
mainline.  If it's a maintained driver with an active userbase, we're
interested...

	Jeff





