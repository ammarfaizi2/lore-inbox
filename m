Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317161AbSFKQZ1>; Tue, 11 Jun 2002 12:25:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317162AbSFKQZ0>; Tue, 11 Jun 2002 12:25:26 -0400
Received: from loewe.cosy.sbg.ac.at ([141.201.2.12]:65180 "EHLO
	loewe.cosy.sbg.ac.at") by vger.kernel.org with ESMTP
	id <S317161AbSFKQZZ>; Tue, 11 Jun 2002 12:25:25 -0400
Date: Tue, 11 Jun 2002 18:25:26 +0200 (MET DST)
From: "Thomas 'Dent' Mirlacher" <dent@cosy.sbg.ac.at>
To: Linux-Kernel ML <linux-kernel@vger.kernel.org>
Subject: write-permission check for root
Message-ID: <Pine.GSO.4.05.10206111821320.18111-100000@mausmaki.cosy.sbg.ac.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi list,

i was wondering if if it's reasonable to disable root write access
for procfs,driverfs files (which have file permissions set to read
only)

looking at the variables exported to sysctl: if those have read-only
permission, they are intended to be read-only, even for root.

did i miss the point here? any comments?

thanks,

	tm

-- 
in some way i do, and in some way i don't.

