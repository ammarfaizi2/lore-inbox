Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270387AbRIFMKN>; Thu, 6 Sep 2001 08:10:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272465AbRIFMKD>; Thu, 6 Sep 2001 08:10:03 -0400
Received: from mercury.lss.emc.com ([168.159.40.77]:3595 "EHLO
	mercury.lss.emc.com") by vger.kernel.org with ESMTP
	id <S272464AbRIFMJx>; Thu, 6 Sep 2001 08:09:53 -0400
Message-ID: <2CE33F05597DD411AAE800D0B769587C04EA0542@sryoung.lss.emc.com>
From: "conway, heather" <conway_heather@emc.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: v2.4.9 and sequential scan
Date: Thu, 6 Sep 2001 08:10:00 -0400 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Folks,
Are there any plans to change the sequential SCSI scan to REPORT_LUNS
anytime soon?  I've installed v2.4.9 on a  system that is attached via
Adaptec AHA-2944UWs to an external storage box and the host will end up
panicking because it times out trying to scan for all of the LUNs.  Same
thing goes for another host using the Qlogic qla2x00 driver.  
Is there any timeframe for a change from sequential scanning in v2.4.x or is
there a work around so the hosts don't panic if they're attached to external
storage?
Thanks for the help.
Heather
-
To unsubscribe from this list: send the line "unsubscribe linux-scsi" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
