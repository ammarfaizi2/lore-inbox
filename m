Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262084AbSIYWG1>; Wed, 25 Sep 2002 18:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262100AbSIYWG1>; Wed, 25 Sep 2002 18:06:27 -0400
Received: from ausadmmsrr501.aus.amer.dell.com ([143.166.83.88]:21002 "HELO
	AUSADMMSRR501.aus.amer.dell.com") by vger.kernel.org with SMTP
	id <S262084AbSIYWG1>; Wed, 25 Sep 2002 18:06:27 -0400
X-Server-Uuid: ff595059-9672-488a-bf38-b4dee96ef25b
Message-ID: <20BF5713E14D5B48AA289F72BD372D68C1E8C1@AUSXMPC122.aus.amer.dell.com>
From: Matt_Domsch@Dell.com
To: greg@kroah.com
cc: mochel@osdl.org, linux-kernel@vger.kernel.org
Subject: RE: devicefs requests
Date: Wed, 25 Sep 2002 17:11:43 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
X-WSS-ID: 118CEB15876158-01-01
Content-Type: text/plain; 
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Fair enough.  I actually only need the 64-bit unique ID that 
> the USB device provides, and its parent PCI device.  

Oh, and of course being able to walk the list of existing devices on that
bus (similar to bus_for_each_dev() now, with a callback mechanism that
allows comparison of one device (BIOSs idea of a device) with what the
device thinks of itself - to allow matching.

-Matt

--
Matt Domsch
Sr. Software Engineer, Lead Engineer, Architect
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

