Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262556AbVG2JrE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262556AbVG2JrE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 05:47:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262559AbVG2JrD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 05:47:03 -0400
Received: from tim.rpsys.net ([194.106.48.114]:65215 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S262556AbVG2Jq6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 05:46:58 -0400
Subject: [patch 6/8] w100fb: Rewrite for platform independence
From: Richard Purdie <rpurdie@rpsys.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Fri, 29 Jul 2005 10:46:54 +0100
Message-Id: <1122630414.7747.95.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The code w100fb was based on was horribly Sharp SL-C7x0 specific
and there was little else that could be done as I had no access to
anything else with a w100 in it. There is no real documentation 
about this chipset available.

Ian Molton has access to other platforms with the w100 (Toshiba
e-series) and so between us, we've improved w100fb and made it 
platform independent. Ian Molton also added support for the 
very similar w3220 and w3200 chipsets.

There are a lot of changes here and it nearly amounts to a rewrite 
of the driver but it has been extensively tested and is being used 
in preference to the original driver in the Zaurus community. I'd
therefore like to update the mainline code to reflect this. 

Signed-off-by: Richard Purdie <rpurdie@rpsys.net>

The patch is large so for LKML I'm linking to it:
http://www.rpsys.net/openzaurus/patches/w100_core-r1.patch


