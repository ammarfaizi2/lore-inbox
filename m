Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267937AbUHEXaj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267937AbUHEXaj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 19:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267940AbUHEXaj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 19:30:39 -0400
Received: from mms2.broadcom.com ([63.70.210.59]:57872 "EHLO mms2.broadcom.com")
	by vger.kernel.org with ESMTP id S267937AbUHEXag convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 19:30:36 -0400
X-Server-Uuid: 011F2A72-58F1-4BCE-832F-B0D661E896E8
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: MMCONFIG violates pci power mgmt spec
Date: Thu, 5 Aug 2004 16:30:30 -0700
Message-ID: <B1508D50A0692F42B217C22C02D84972020F3BBC@NT-IRVA-0741.brcm.ad.broadcom.com>
Thread-Topic: MMCONFIG violates pci power mgmt spec
thread-index: AcR7PgxljgrWLOiIRJ2dQCjBuk0JIwABXxDg
From: "Michael Chan" <mchan@broadcom.com>
To: "Roland Dreier" <roland@topspin.com>
cc: linux-kernel@vger.kernel.org
X-WSS-ID: 6D0C1C9E15C5121525-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> I believe the PCI Express spec says that config writes are 
> never posted. (I'll check later to be sure)
> 
>  - Roland
> 

Yes, the config write on the PCI Express link is never posted. But the
mmconfig write that gets translated by the chipset to config write on
the PCI Express link may or may not be posted. It is implementation
specific.

Michael

