Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262484AbVA0GBL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262484AbVA0GBL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 01:01:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262488AbVA0GBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 01:01:10 -0500
Received: from relay1.mail2web.com ([168.144.1.81]:33295 "EHLO
	relay1.mail2web.com") by vger.kernel.org with ESMTP id S262484AbVA0GBJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 01:01:09 -0500
Message-ID: <18910-220051427616499@M2W055.mail2web.com>
X-Priority: 3
Reply-To: sudhir@digitallink.com.np
X-Originating-IP: 203.78.173.74
X-URL: http://mail2web.com/
From: "sudhir@digitallink.com.np" <sudhir@digitallink.com.np>
To: linux-kernel@vger.kernel.org
Subject: confguring grub to load new kernel
Date: Thu, 27 Jan 2005 01:01:06 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-OriginalArrivalTime: 27 Jan 2005 06:01:06.0460 (UTC) FILETIME=[97176DC0:01C50435]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just compiled kernel 2.6.10 and now wondering how to make the grub to
load the newkernel.

The grub.conf file is configured as:

#boot=/dev/hda
default=1
timeout=10
splashimage=(hd0,5)/boot/grub/splash.xpm.gz
title Red Hat Linux (2.4.20-8)
        root (hd0,5)
        kernel /boot/vmlinuz-2.4.20-8 ro root=LABEL=/
        initrd /boot/initrd-2.4.20-8.img
title DOS
        rootnoverify (hd0,0)
        chainloader +1
                                                                            
    
How should I change the configuration?

sudhir

--------------------------------------------------------------------
mail2web - Check your email from the web at
http://mail2web.com/ .


