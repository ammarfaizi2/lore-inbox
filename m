Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266709AbUBMD27 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 22:28:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266711AbUBMD27
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 22:28:59 -0500
Received: from hera.kernel.org ([63.209.29.2]:27532 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S266709AbUBMD2z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 22:28:55 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: /proc/partitions not done updating when init is ran?
Date: Fri, 13 Feb 2004 03:28:48 +0000 (UTC)
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <c0hg9g$ebe$1@terminus.zytor.com>
References: <46246.192.168.1.12.1076553774.squirrel@mail.2thebatcave.com> <50391.192.168.1.12.1076590842.squirrel@mail.2thebatcave.com> <Pine.LNX.4.58.0402121715310.27694@student.dei.uc.pt> <52044.192.168.1.12.1076632825.squirrel@mail.2thebatcave.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
X-Trace: terminus.zytor.com 1076642928 14703 63.209.29.3 (13 Feb 2004 03:28:48 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Fri, 13 Feb 2004 03:28:48 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <52044.192.168.1.12.1076632825.squirrel@mail.2thebatcave.com>
By author:    "Nick Bartos" <spam99@2thebatcave.com>
In newsgroup: linux.dev.kernel
>
> >
> > Well, does it still happen with 2.4.25-rc2 ?
> >
> 
> yes it does, and it does for 2.6.2 as well.
> 
> I did a couple of dmesg's and it looks like the usb device is not being
> detected until after init is ran.  I would think that the kernel would
> have done all the device detection before running init but I guess not.
> 

Yes, the "delayed detect" behaviour of USB is a big problem.

	-hpa
-- 
PGP public key available - finger hpa@zytor.com
Key fingerprint: 2047/2A960705 BA 03 D3 2C 14 A8 A8 BD  1E DF FE 69 EE 35 BD 74
"The earth is but one country, and mankind its citizens."  --  Bahá'u'lláh
Just Say No to Morden * The Shadows were defeated -- Babylon 5 is renewed!!
