Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262783AbSLBPQo>; Mon, 2 Dec 2002 10:16:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262792AbSLBPQo>; Mon, 2 Dec 2002 10:16:44 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:51450 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262783AbSLBPQo>;
	Mon, 2 Dec 2002 10:16:44 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Arnd Bergmann <arndb@de.ibm.com>
Reply-To: arnd@bergmann-dalldorf.de
To: Christian Borntraeger <christian@borntraeger.net>
Subject: Re: [PATCH] 2.5.50 ctctty not aware of new HZ value
Date: Mon, 2 Dec 2002 17:49:34 +0100
User-Agent: KMail/1.4.3
Organization: IBM Deutschland Entwicklung GmbH
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200212021749.34306.arndb@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Borntraeger wrote:
> this patch replaces 2 numeric values with a HZ-related version in the ctc 
> driver of the S/390.

Thanks, I will integrate this in the s390 cvs tree and submit it
with the next arch updates. Note that HZ has not changed for s390
systems and probably never will (at least it won't go /higher/ than
100, maybe lower), so the patch does not make a functional difference.

	Arnd <><
