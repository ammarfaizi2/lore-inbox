Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315599AbSGSD4J>; Thu, 18 Jul 2002 23:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318434AbSGSD4J>; Thu, 18 Jul 2002 23:56:09 -0400
Received: from mta4.srv.hcvlny.cv.net ([167.206.5.10]:54688 "EHLO
	mta4.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id <S315599AbSGSD4I>; Thu, 18 Jul 2002 23:56:08 -0400
Date: Thu, 18 Jul 2002 23:57:28 -0400
From: "D. Sen" <dsen@auditorymodels.org>
Subject: AGP and Thinkpad APM/suspend problems
To: linux-kernel@vger.kernel.org
Message-id: <3D378E28.9040305@auditorymodels.org>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020529
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reporting that both the IBM Thinkpad A31 and the Thinkpad T30 does not 
survive a suspend-resume cycle when the X server is configured to run at 
AGP >1x mode. The machines suspend fine. But an attempt to resume the 
machine, freezes it (requiring a cold reboot).

Both machines have Radeon Mobility Chipsets.

AGP speed is set using ==> "Option        "AGPMode" "N" in 
/etc/X11/XF86Config-4

A note on XIG's website which might be relevant (seems to attribute the 
problem to APM):

   3.0-28 05/07/2002

       - corrected a problem that would cause multiple server
         invokations to hang on ATI chips.  This was related to the
         APM fix made in the previous version.

   3.0-27 05/06/2002

       - corrected a problem with APM whereby the AGP bridge would not
         be shutdown/re-initialized properly during APM events.  This
         could cause the server to lock in certain cases when the
         machine was 'woken up' after a suspend.




