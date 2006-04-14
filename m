Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964796AbWDNMiJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964796AbWDNMiJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 08:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964800AbWDNMiJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 08:38:09 -0400
Received: from nammta.apcc.com ([159.215.21.91]:30986 "EHLO nammta.apcc.com")
	by vger.kernel.org with ESMTP id S964796AbWDNMiI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 08:38:08 -0400
Subject: Linux with CAN over SPI
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Cc: Mike.Johnson@apc.com
X-Mailer: Lotus Notes Release 6.5.2 June 01, 2004
Message-ID: <OFA3BE8291.CF7F1657-ON85257150.00446A1A-85257150.004564FA@apcc.com>
From: Mike.Johnson@apc.com
Date: Fri, 14 Apr 2006 08:37:58 -0400
MIME-Version: 1.0
X-MIMETrack: Serialize by Router on Mako/NAM/APCC(Release 6.0.5|March 27, 2005) at 04/14/2006
 08:37:59 AM,
	Itemize by SMTP Server on NAMMTA/APCMTA(Release 6.0.5|March 27, 2005) at 04/14/2006
 08:37:59 AM,
	Serialize by Router on NAMMTA/APCMTA(Release 6.0.5|March 27, 2005) at 04/14/2006
 08:38:08 AM,
	Serialize complete at 04/14/2006 08:38:08 AM
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


All,

I'm looking for some information about a CAN driver and how it might
nterface to an SPI port of the PPC 875 processor.

I am new to the linux world and am trying to write a CAN device driver that
uses SPI to communicate to the external CAN chip.

The latest kernel has some CAN and SPI support. I am beginning to put some
of the pieces together on how these work, but It's new to me how these are
truly instantiated and implemented in the kernel.

Does anyone know of a white paper or any documentation that may explain the
general process of a network device driver installation? (I do know that
the CAN driver is considered a network interface, not a "char" or "block"
interface.)

What is the order of steps to initialize the SPI driver? I'm guessing the
SPI driver need to be initialized before it can detect the presents of the
CAN chip.

Does the CAN driver try to talk to the CAN chip via SPI to determine its
existance?

These are the questions I'm hoping to fill in.

I have been reading the O'reilly book on device drivers...this helps
some.....but any other real world help would be appreciated.

Thank-you,

Mike

Michael Johnson
American Power Conversion
132 Fairgrounds Road
West Kingston, RI  02892
tele: (401) 789 - 5735 x2982


http://www.apc.com
http://www.netbotz.com
http://www.datacenteruniversity.com

