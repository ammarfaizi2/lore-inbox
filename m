Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932375AbWBMK6F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932375AbWBMK6F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 05:58:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932370AbWBMK6E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 05:58:04 -0500
Received: from smtp.bulldogdsl.com ([212.158.248.7]:36105 "EHLO
	mcr-smtp-001.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S932375AbWBMK6D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 05:58:03 -0500
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: netdev@vger.kernel.org
Subject: 2.6.16, sk98lin out of date
Date: Mon, 13 Feb 2006 10:58:03 +0000
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602131058.03419.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

As I'm sure the drivers/net maintainers are well aware, SysKonnect constantly 
update their sk98lin/sky2 driver without bothering to sync their changes with 
the official linux kernel.

I quickly downloaded driver version 8.31 from http://www.skd.de/ today and 
used the install script to generate a diff against 2.6.16-rc3. Even after 
fixing up some DOS EOLs in the package, the diff was still well over 1.5MBs. 
This is an enormous number of changes.

The reason I'm posting is that my DFI LanParty-UT SLI-D works with this 
version of the driver, but not the version 2.6.16-rc3.

[alistair] 10:55 [~] dmesg | grep sk98lin
sk98lin: Could not read VPD data.
sk98lin: probe of 0000:01:0a.0 failed with error -5

I wonder if it's worth just identifying the "quick fix" (I've seen workarounds 
for corrupt VPDs like mine) or whether a general merge up would be 
beneficial..

If nobody's maintaining this driver I wouldn't mind helping out.

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
