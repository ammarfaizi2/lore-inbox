Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270524AbTHLORm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 10:17:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270642AbTHLORm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 10:17:42 -0400
Received: from smtp.bhfc.net ([209.159.192.11]:63361 "EHLO smtp.bhfc.net")
	by vger.kernel.org with ESMTP id S270524AbTHLORk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 10:17:40 -0400
From: Tim Lee <tlee5794@rushmore.com>
Reply-To: tlee5794@rushmore.com
To: linux-kernel@vger.kernel.org
Subject: SiS 648/963 agpgart and ATI Radeon 9500 Pro
Date: Tue, 12 Aug 2003 08:18:18 -0600
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308120818.18796.tlee5794@rushmore.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've been trying to get the above combination to work
for ~6 months now with no luck.  I probably need to give
up and buy a new motherboard or get rid of the ATI 
card but I'm not sure which is the real problem at this 
point.

I'm currently using the 2.4.22-rc2-ac1 kernel with SiS
648 support and latest 3.02.00 ATI drivers from ATI.  The
drivers and kernel work fine as long as I don't use DRI.
As soon as I turn on DRI the system locks up when starting
the XServer.  This has happend since the first kernel I
tried it with (2.4.19) something until the most recent.
I can find no clue in any log as to what has gone wrong.
In the past I was using the try_unsupported option for
agpgart.

Is there any way to debug this or anything someone can
recomend to determine which is the culprit.  I have used
the ATI card and the linux drivers on an older motherboard
with AGP 4x Support and all worked besides the usual ATI
driver glitches.  I would certainly be willing to help
whoever wrote the SiS 648 support try to find out the 
problem if it is with the 648 agp support.

Thanks,
-- 
Tim Lee      
Phone: 605-722-3848
Fluke Networks
6805 Corporate Dr., Suite 100
Colorado Springs, CO 80919

