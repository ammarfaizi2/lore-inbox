Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751157AbVJ2OLX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbVJ2OLX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 10:11:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751164AbVJ2OLX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 10:11:23 -0400
Received: from ams-iport-1.cisco.com ([144.254.224.140]:8322 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1751157AbVJ2OLV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 10:11:21 -0400
To: Pete Clements <clem@clem.clem-digital.net>
Cc: linux-kernel@vger.kernel.org (linux-kernel)
Subject: Re: 2.6.14-git1 fails compile -- i386/pci/fixup.c
X-Message-Flag: Warning: May contain useful information
References: <200510291318.j9TDIjmi018556@clem.clem-digital.net>
From: Roland Dreier <rolandd@cisco.com>
Date: Sat, 29 Oct 2005 07:11:16 -0700
In-Reply-To: <200510291318.j9TDIjmi018556@clem.clem-digital.net> (Pete
 Clements's message of "Sat, 29 Oct 2005 09:18:45 -0400 (EDT)")
Message-ID: <5264rgpg57.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 29 Oct 2005 14:11:17.0067 (UTC) FILETIME=[A0C729B0:01C5DC92]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    >   CC      arch/i386/pci/fixup.o
    > arch/i386/pci/fixup.c:401: toshiba_ohci1394_dmi_table causes a section type conflict
    > make[1]: *** [arch/i386/pci/fixup.o] Error 1
    > make: *** [arch/i386/pci] Error 2

This is fixed by the patch in

    http://lkml.org/lkml/2005/10/29/12

 - R.
