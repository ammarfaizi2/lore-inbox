Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267956AbTAHVEW>; Wed, 8 Jan 2003 16:04:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267957AbTAHVEW>; Wed, 8 Jan 2003 16:04:22 -0500
Received: from petasus.ch.intel.com ([143.182.124.5]:28877 "EHLO
	petasus.ch.intel.com") by vger.kernel.org with ESMTP
	id <S267956AbTAHVEV>; Wed, 8 Jan 2003 16:04:21 -0500
Message-ID: <C6F5CF431189FA4CBAEC9E7DD5441E01087A7D@orsmsx402.jf.intel.com>
From: "Feldman, Scott" <scott.feldman@intel.com>
To: Jon Fraser <j_fraser@bit-net.com>, linux-kernel@vger.kernel.org,
       Avery Fay <avery_fay@symantec.com>
Subject: RE: Gigabit/SMP performance problem
Date: Wed, 8 Jan 2003 13:12:47 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If you happen to turn on vlans, I be curious about your 
> results.  Our chipsets produced cisco ISL frames instead of 
> 802.1q frames.  Intel admitted the chipset would do it, but 
> 'shouldn't be doing that...'

This problem has been fixed in tot 2.4 and 2.5.  The VLANs were not
being restored after ifup.  

-scott
