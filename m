Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262090AbVDFHUS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262090AbVDFHUS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 03:20:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262130AbVDFHUR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 03:20:17 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:25829 "EHLO
	mailout3.samsung.com") by vger.kernel.org with ESMTP
	id S262090AbVDFHUL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 03:20:11 -0400
Date: Wed, 06 Apr 2005 13:46:36 -0700
From: karthik <karthik.r@samsung.com>
Subject: Info Regarding how the Redeon driver access EDID info
To: linux-kernel@vger.kernel.org
Message-id: <200504061346.36975.karthik.r@samsung.com>
Organization: samsung
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: KMail/1.6.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

          I am not able to understand how the radeon video card  
driver access EDID info of Monitors attached to the cards.The 
driver is calling one funtion 
get_property(dp, propnames[i], NULL);

But in this funtion its just return some value ie 
dp->property->value; how this property->value field is 
Initialized. Is this get_EDID is called only at boot time. how the value of 
the device _node structure is initilized.

If any have any ideas regarding this please mail me.

Karthik



