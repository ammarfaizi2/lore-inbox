Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261747AbTCZPdV>; Wed, 26 Mar 2003 10:33:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261731AbTCZPdV>; Wed, 26 Mar 2003 10:33:21 -0500
Received: from franka.aracnet.com ([216.99.193.44]:8604 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S261748AbTCZPdU>; Wed, 26 Mar 2003 10:33:20 -0500
Date: Wed, 26 Mar 2003 07:44:28 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: New: Framebuffer Console corrupted 
Message-ID: <228300000.1048693468@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://bugme.osdl.org/show_bug.cgi?id=504

           Summary: Framebuffer Console corrupted
    Kernel Version: 2.5.66
            Status: NEW
          Severity: normal
             Owner: mbligh@aracnet.com
         Submitter: smart@smartpal.de


Distribution: RedHat 8.0
Hardware Environment: Dell Latitude C640, Ati Radeon Mobility M7 LW
Software Environment: Kernel/Textconsole
Problem Description: options set to "yes": CONFIG_FB, CONFIG_FB_RADEON,
CONFIG_FRAMEBUFFER_CONSOLE, CONFIG_LOGO_LINUX_CLUT224 gives a corrupted
output, the guess that it's due to unmatching resolution between FB and
GraphicsCard is strengthened by the fact that switching into X for a short
moment shows two small textconsoles side by side (odd/pair line console
halves probably).


