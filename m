Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316683AbSGBJRc>; Tue, 2 Jul 2002 05:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316684AbSGBJRc>; Tue, 2 Jul 2002 05:17:32 -0400
Received: from d12lmsgate-2.de.ibm.com ([195.212.91.200]:20392 "EHLO
	d12lmsgate-2.de.ibm.com") by vger.kernel.org with ESMTP
	id <S316683AbSGBJRb>; Tue, 2 Jul 2002 05:17:31 -0400
Importance: Normal
Sensitivity: 
Subject: Re: hd_geometry question.
To: Andries Brouwer <aebr@win.tue.nl>
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OF25B15FAC.FE67359D-ONC1256BEA.0032B6AA@de.ibm.com>
From: "Martin Schwidefsky" <schwidefsky@de.ibm.com>
Date: Tue, 2 Jul 2002 11:16:06 +0200
X-MIMETrack: Serialize by Router on D12ML016/12/M/IBM(Release 5.0.9a |January 7, 2002) at
 02/07/2002 11:19:48
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>About a partition one wants to know start and length.
>About a full disk one wants to know size, and perhaps a (fake) geometry.
>
>The vital partition data cannot depend on obscure hardware info.
>So, the units used must be well-known. Earlier, everything was in
>512-byte sectors, but there are a few places where that is inconvenient
>or unnatural, and now that one has more than 2^32 sectors and 64 bits
>are needed anyway, things are measured in bytes.
>
>That the start field comes with the HDIO_GETGEO ioctl and the size with
>the BLKGETSIZE ioctl is due to history. Both are given in 512-byte sectors.
>BLKGETSIZE64 gives bytes.

Just to make sure I got that right, HDIO_GETGEO delivers a FAKE geometry
based on the assumption that the sector size is 512 bytes ?

blue skies,
   Martin


