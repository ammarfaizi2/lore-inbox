Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262436AbVAJSnp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262436AbVAJSnp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 13:43:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262306AbVAJSkN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 13:40:13 -0500
Received: from mail.tyan.com ([66.122.195.4]:41741 "EHLO tyanweb.tyan")
	by vger.kernel.org with ESMTP id S262301AbVAJShI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 13:37:08 -0500
Message-ID: <3174569B9743D511922F00A0C943142307291394@TYANWEB>
From: YhLu <YhLu@tyan.com>
To: jamesclv@us.ibm.com
Cc: Mikael Pettersson <mikpe@csd.uu.se>, ak@muc.de, Matt_Domsch@dell.com,
       discuss@x86-64.org, linux-kernel@vger.kernel.org,
       suresh.b.siddha@intel.com
Subject: RE: 256 apic id for amd64
Date: Mon, 10 Jan 2005 10:48:40 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James,

I'm working on add amd dual core LinuxBIOS support to our MB. So I can
change the apic id as I want.

When I lift the apic id for CPUS, if the bsp apicid is changed to 0x10, the
jiffies is not changing, So I have to leave to set BSP using apic id 0 in
LinuxBIOS. And lifting others to use 0x11.....
According to Andi, that would be one bug in kernel .....


Regards

YH
