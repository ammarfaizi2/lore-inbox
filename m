Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264488AbTICUiT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 16:38:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264459AbTICUiT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 16:38:19 -0400
Received: from law11-f71.law11.hotmail.com ([64.4.17.71]:54537 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S264488AbTICUiR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 16:38:17 -0400
X-Originating-IP: [144.92.164.196]
X-Originating-Email: [muthian_s@hotmail.com]
From: "Muthian S" <muthian_s@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Remote SCSI Emulation 
Date: Wed, 03 Sep 2003 20:38:14 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <LAW11-F717fcGuKeddZ000021c9@hotmail.com>
X-OriginalArrivalTime: 03 Sep 2003 20:38:15.0108 (UTC) FILETIME=[4CB5D040:01C3725B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Certain SCSI adapters like the Adaptec AHA 29160 are reportedly capable of
acting as a target and can receive SCSI commands from initiators.  Such an
adapter can be used to facilitate remote SCSI emulation by a PC.
For instance, if two PCs have the adapter, the two adapters can be
directly connected by a SCSI bus and the second PC can in effect serve as
an "emulated SCSI disk".  Such a setup is extremely helpful in various
scenarios.

However, for this to work, the OS on the second PC (which serves as the
emulated scsi disk) should be capable of handling incoming SCSI requests and
directing them to an appropriate software layer.  Apparently, the CAM
subsystem of FreeBSD has this capability.  I was wondering if there is a
similar mechanism in linux.

It would be really helpful if people have comments on whether such a setup 
is
possible in linux, and if yes, are there specific adapters that are known
to work in this fashion.

thanks,
Muthian.

_________________________________________________________________
Get MSN 8 and enjoy automatic e-mail virus protection.  
http://join.msn.com/?page=features/virus

