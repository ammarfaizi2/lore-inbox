Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267259AbUHJEJ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267259AbUHJEJ7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 00:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267409AbUHJEJ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 00:09:59 -0400
Received: from smtp3.ispsnet.net ([64.63.240.3]:24479 "EHLO smtp3.ispsnet.net")
	by vger.kernel.org with ESMTP id S267259AbUHJEJ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 00:09:56 -0400
From: Robert Crawford <flacycads@access4less.net>
Organization: Florida Cycads
To: linux-kernel@vger.kernel.org
Subject: 2.6.8-rc3-mm1 & mm2 break k3b
Date: Tue, 10 Aug 2004 00:11:30 +0000
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200408100011.30730.flacycads@access4less.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I posted this on the Con Kolivas kernel list, and he suggested I post here, 
regarding 2.6.8-rc3-mm kernels. I'm no expert by any means, but have been 
testing kernels since 2.5.67, and have posted about kernels on the Gentoo & 
PCLOS forums, among others.

"Just tested the latest staircase7.I with 2.6.8-rc3 vanilla, and 
2.6.8-rc3-mm2, and both work fine- no problems I can see so far on my test 
box. However,  2.6.8-rc3-mm1 and mm2 both still break my k3b cd burning 
software, with these errors (using cdrecord 2.1a33, on Gentoo) :

Unable to determine the last tracks data mode. using default
cdrecord returned an unknown error (code 12)
Cannot allocate memory

Sometimes it says to lower the burn speed, even when it's set to 4x (on a 48x 
burner), but that doesn't solve the problem. I get the same errors.

This doesn't occur with all previous mm kernels (up to 2.6.8-rc2-mm2), or any 
other kernel I've tried, and not with any ck patches, so I'm convinced it's 
the rc3-mm patches causing this, and not anything ck." If I boot with other 
kernels, same hardware, same config file, k3b works perfectly.

Robert Crawford
