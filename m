Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280961AbRKYSRD>; Sun, 25 Nov 2001 13:17:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280966AbRKYSQx>; Sun, 25 Nov 2001 13:16:53 -0500
Received: from haybaler.sackheads.org ([205.158.174.201]:55053 "HELO
	haybaler.sackheads.org") by vger.kernel.org with SMTP
	id <S280961AbRKYSQl>; Sun, 25 Nov 2001 13:16:41 -0500
Date: Sun, 25 Nov 2001 10:20:49 -0800
From: Jimmie Mayfield <mayfield+kernel@sackheads.org>
To: linux-kernel@vger.kernel.org
Subject: 2.4.16pre1 missing cmd64x I/O stats
Message-ID: <20011125102049.A8590@sackheads.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi.  I've noticed that in non-AC kernels including 2.4.16pre1, /proc/stat 
does not contain disk_io statistics for my CMD649 IDE interface.  

2.4.10ac12:
disk_io: (2,0):(5,5,10,0,0) (11,0):(4,4,16,0,0) (34,0):(5820,2968,44458,2852,16024) (34,1):(7068,7067,56530,1,8) 

2.4.16pre1:
disk_io: (2,0):(79,60,1444,19,1334) (11,0):(147,147,4732,0,0) 


Jimmie

