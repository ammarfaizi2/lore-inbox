Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262442AbVBXSTx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262442AbVBXSTx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 13:19:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262445AbVBXSTx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 13:19:53 -0500
Received: from sigma.informatik.hu-berlin.de ([141.20.20.51]:11406 "EHLO
	sigma.informatik.hu-berlin.de") by vger.kernel.org with ESMTP
	id S262442AbVBXSTe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 13:19:34 -0500
From: Axel =?iso-8859-1?q?Wei=DF?= <aweiss@informatik.hu-berlin.de>
Organization: =?iso-8859-1?q?Humboldt-Universit=E4t_zu?= Berlin
To: linux-kernel@vger.kernel.org
Subject: Question: warnings about undefined symbols in splitted external modules
Date: Thu, 24 Feb 2005 19:19:15 +0100
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200502241919.15785.aweiss@informatik.hu-berlin.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have splitted a device driver for a dsp-board into two separate 
modules. One of them does export some symbols for the other module and 
gets loaded first, so there's no problem loading the second module.

But compilation of the second module shows warnings:
*** Warning: "<symbol>" [<path-to-module>.ko] undefined!

What should I do to get rid of these warnings? Is there a way to tell the 
second module about symbols in the first one (something like 
IMPORT_SYMBOL)?

Regards,
			Axel

-- 
Humboldt-Universität zu Berlin
Institut für Informatik
Signalverarbeitung und Mustererkennung
Dipl.-Inf. Axel Weiß
Rudower Chaussee 25
12489 Berlin-Adlershof
+49-30-2093-3050
** www.freesp.de **
