Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262697AbUKRAgn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262697AbUKRAgn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 19:36:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262699AbUKRAgD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 19:36:03 -0500
Received: from newton.linux4geeks.de ([193.30.1.1]:650 "EHLO
	newton.linux4geeks.de") by vger.kernel.org with ESMTP
	id S262701AbUKRA3k convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 19:29:40 -0500
From: Sven Ladegast <sven@linux4geeks.de>
Organization: Linux4Geeks
To: linux-kernel@vger.kernel.org
Subject: [via-rhine.c] bug since 2.6.9 with wake-on-lan ability?
Date: Thu, 18 Nov 2004 01:29:38 +0100
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Message-Id: <200411180129.38929.sven@linux4geeks.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I recently updated from kernel 2.6.7 to 2.6.9 and experienced that wake-on-lan 
with my VIA-Rhine II network controller does not work anymore. The system 
doesn't start up if it gets a magic packet.

I am using a mainbaord with KT-600 chipset made by VIA (ECS Elitegroup 
KT-600A) with an integrated VIA VT6102 network controller into the VT8237 
southbridge.

I saw there were different changes from 2.6.7 to 2.6.9 in via-rhine.c like 
code cleanups and redesign and so on. At the moment I try to track this 
behaviour down in order to create a patch.

I searched the lkml for any articles about this but I could not find any. 
That's why I am posting... Maybe anyone knows something about that?

Regards

Sven
-- 
Sven Ladegast, Friedrich-Fröbel-Straße 11, 93310 Arnstadt / Germany
Phone: +49-175-5334308, PGP-key: 0x5856A5ED

