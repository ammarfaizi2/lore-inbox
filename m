Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267514AbUIHPnm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267514AbUIHPnm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 11:43:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268295AbUIHPnm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 11:43:42 -0400
Received: from smtp-out4.blueyonder.co.uk ([195.188.213.7]:4974 "EHLO
	smtp-out4.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S267514AbUIHPnk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 11:43:40 -0400
Message-ID: <413F28AA.9070806@blueyonder.co.uk>
Date: Wed, 08 Sep 2004 16:43:38 +0100
From: Sid Boyce <sboyce@blueyonder.co.uk>
Reply-To: sboyce@blueyonder.co.uk
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: RE: 2.6.9-rc1-mm4
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Sep 2004 15:44:04.0195 (UTC) FILETIME=[AB337B30:01C495BA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > Something strange is happening on my two boxen, Asus A7N8X-E, Athlon 
XP3000+, nForce2 based, FX5200 video, SuSE 9.1 and Acer 1501-LCe laptop 
x86_64 > XP3000+ Mobile, Radeon 9600, SuSE 9.1 x84_64. Building the 
kernel either starting with a base of linux-2.6.8.tar.bz2 or with 
linux-2.6.9-rc1.tar.bz2 I get the >same effect on both - on reboot, 
kernel selected, video puts out a feint shadow, disk activity ceases, 
hard reset required. The config is essentially that posted on the > 
2.6.9-rc1-mm? CDROM bug last week, I've since pruned some scsi and not 
required stuff out, makes no difference. Disabling acpi and apm also no 
difference.
 > Any previous kernel will boot, but most will give the previously 
described CDROM/DVD mount problem.
 > I will retrace my steps and separately download the kernel stuff to 
each box and see if that makes a difference as I seem to be the only one 
to have hit these strange > errors.
2.6.9-rc1-bk15 boots on both. The Acer x86_64 definitely has a bad CDROM 
as it's reading garbage for the vendor and  model.  The x86 box 
generates an Oops on mounting the cdrom, so I shall submit a bug against 
-bk15 for that - the nvidia driver 1.0-6111 for the FX5200 works without 
modding the driver source.
Regards
Sid.

-- 
Sid Boyce .... Hamradio G3VBV and keen Flyer
=====LINUX ONLY USED HERE=====

