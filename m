Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161352AbWALWJ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161352AbWALWJ5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 17:09:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161356AbWALWJ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 17:09:57 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:1719 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1161352AbWALWJ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 17:09:56 -0500
Date: Thu, 12 Jan 2006 23:09:16 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Adrian Bunk <bunk@stusta.de>
cc: Jon Mason <jdmason@us.ibm.com>, Muli Ben-Yehuda <mulix@mulix.org>,
       Jiri Slaby <slaby@liberouter.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prevent trident driver from grabbing pcnet32 hardware
In-Reply-To: <20060112220039.GX29663@stusta.de>
Message-ID: <Pine.LNX.4.61.0601122307440.30373@yvahk01.tjqt.qr>
References: <20060112175051.GA17539@us.ibm.com> <43C6ADDE.5060904@liberouter.org>
 <20060112200735.GD5399@granada.merseine.nu> <20060112214719.GE17539@us.ibm.com>
 <20060112220039.GX29663@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> After looking at the ALSA driver, it doesn't support PCI IDs for
>> ALI_5451 or CYBER5050.  Someone should look into porting any necessary
>> code from sound/oss/trident.c to sound/pci/trident/trident.c
>
>CYBER5050 is discussed in ALSA bug #1293 (tester wanted).
>ALI_5451 is supported by the snd-ali5451 driver.

And I have a (working) ALI 5451; for whoever wants to know that.



Jan Engelhardt
-- 
