Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751148AbVHXQny@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751148AbVHXQny (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 12:43:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbVHXQny
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 12:43:54 -0400
Received: from de01egw02.freescale.net ([192.88.165.103]:61417 "EHLO
	de01egw02.freescale.net") by vger.kernel.org with ESMTP
	id S1751148AbVHXQnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 12:43:53 -0400
Date: Wed, 24 Aug 2005 11:43:36 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@nylon.am.freescale.net
To: linux-kernel@vger.kernel.org
cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 00/15] Remove asm/segment.h from low hanging architectures
Message-ID: <Pine.LNX.4.61.0508241139100.23956@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following set of patches removes the use and existence of 
asm/segment.h from the architecture ports that it was fairly trivial to do 
so.  I need to work with the arch maintainers on the following 
architectures since they use asm/segment.h heavily:

m32r
um
frv
h8300
i386
m68knommu
m68k
v850
x86_64

If any arch maintainers want to go a head kill asm/segment.h in that last 
I would be very appreciative.

Thanks

- kumar
