Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264604AbUBIBYL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 20:24:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264608AbUBIBYL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 20:24:11 -0500
Received: from [217.157.19.70] ([217.157.19.70]:23827 "EHLO jehova.dsm.dk")
	by vger.kernel.org with ESMTP id S264604AbUBIBYB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 20:24:01 -0500
From: Thomas Horsten <thomas@horsten.com>
To: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: New mailing list for 2.6 Medley RAID (Silicon Image 3112 etc.) BIOS RAID development
Date: Mon, 9 Feb 2004 01:23:52 +0000
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402090123.52765.thomas@horsten.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've started a mailing list for those interested in the development of a Linux 
driver supporting Medley RAID (the BIOS/software RAID used by the Silicon 
Image 3112 and some CMD chipsets).

My main goal is that I want autodetection for these drives to work in 2.6 
(like the ataraid framework in 2.4), but also to leverage the code in the 
existing MD and DM drivers as far as possilble. This currently works in the 
current 2.4 kernels, thanks to Arjan van de Ven's ataraid framework, which my 
Medley driver for 2.4 uses.

The reason I insist on autodetection is that I think it's important that if 
the BIOS will reckognise the drive without additional intervention, so will 
Linux. This will make the entry route for newbies much simpler.

If you are interested in taking part in the discussions/development of the 2.6 
driver for Medley RAID (and other BIOS "wholedisk" RAID arrays, such as 
Highpoint), I would ask you to join this list.

On the new list we'll also welcome support questions for the 2.4 Medley driver 
and other related issues. I expect this to be a low volume list.

You can find more information about how to subscribe at 
http://lists.infowares.com/cgi-bin/listinfo/medley

More informateion about the 2.4 driver, and the patch source, is at 
http://www.infowares.com/linux/

// Thomas

