Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261668AbUFBKiR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261668AbUFBKiR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 06:38:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261672AbUFBKiR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 06:38:17 -0400
Received: from plus.ds14.agh.edu.pl ([149.156.124.14]:55224 "EHLO
	plus.ds14.agh.edu.pl") by vger.kernel.org with ESMTP
	id S261668AbUFBKiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 06:38:16 -0400
From: =?iso-8859-2?q?Pawe=B3_Sikora?= <pluto@pld-linux.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [compilation err] mod_devicetable.h
Date: Wed, 2 Jun 2004 12:37:09 +0200
User-Agent: KMail/1.6.2
Cc: mmazur@pld-linux.org, cieciwa@pld-linux.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200406021237.09205.pluto@pld-linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

when I compile keagle (http://damien.bergamini.free.fr/ueagle/keagle.html)
g++3.4.0 reports an error on .../include/linux/mod_devicetable.h:18

struct pci_device_id {
        __u32 vendor, device;       /* Vendor and device ID or PCI_ANY_ID*/
        __u32 subvendor, subdevice; /* Subsystem ID's or PCI_ANY_ID */
        __u32 class, class_mask;    /* (class,subclass,prog-if) triplet */
              ^^^^^
mod_devicetable.h:18: error: expected identifier before ',' token
mod_devicetable.h:18: error: expected unqualified-id before ',' token

I can use mod_devicetable.h in userspace and c++ too.
Using a c++'s keywords as a var-names is a very bad idea.

Best regards, Paul.

-- 
If you think of MS-DOS as mono, and Windows as stereo,
  then Linux is Dolby Digital and all the music is free...
