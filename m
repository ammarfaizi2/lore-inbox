Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266305AbUA2S2G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 13:28:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266306AbUA2S2F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 13:28:05 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:25264 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S266305AbUA2S1s convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 13:27:48 -0500
Subject: Re: Cset 1.1490.4.201 - dasd naming
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: laroche@redhat.com, linux-kernel@vger.kernel.org, zaitcev@redhat.com
X-Mailer: Lotus Notes Release 5.0.12   February 13, 2003
Message-ID: <OF3A1D7E61.B141530F-ONC1256E2A.00653E98-C1256E2A.00656782@de.ibm.com>
From: "Martin Schwidefsky" <schwidefsky@de.ibm.com>
Date: Thu, 29 Jan 2004 19:27:36 +0100
X-MIMETrack: Serialize by Router on D12ML016/12/M/IBM(Release 5.0.9a |January 7, 2002) at
 29/01/2004 19:27:39
MIME-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pete,

> > Is there a story of a real world deployment where the 2.4 scheme was
> > a hindrance which you could share? Honestly, I'm surprised you bring
> > the matter of "persistent names" instead of, say, exhaustion of
> > address range and majors.
> That is probably the main argument to go back to the old names. After
> udev and friends are in place it is not important how the disk is named
> internally. The only place where it would surface is on the root=
> parameter.
>
> I'll discuss this with the Horst again to see if we really need the
> dasd_<busid>_ names or if we can live with the old style names on the
> root= parameter.

We discussed udev and friends today again and we decided to go back to
the old dasdxyz names. You'll send the patch with the next update to
Andrew.

blue skies,
   Martin

Linux/390 Design & Development, IBM Deutschland Entwicklung GmbH
Schönaicherstr. 220, D-71032 Böblingen, Telefon: 49 - (0)7031 - 16-2247
E-Mail: schwidefsky@de.ibm.com


