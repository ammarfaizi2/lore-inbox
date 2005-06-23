Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262882AbVFWI3L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262882AbVFWI3L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 04:29:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262856AbVFWIZH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 04:25:07 -0400
Received: from general.keba.co.at ([193.154.24.243]:33607 "EHLO
	helga.keba.co.at") by vger.kernel.org with ESMTP id S262449AbVFWHjh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 03:39:37 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: PCMCIA: Statically linked CF card driver?
Date: Thu, 23 Jun 2005 09:39:15 +0200
Message-ID: <AAD6DA242BC63C488511C611BD51F367323249@MAILIT.keba.co.at>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: PCMCIA: Statically linked CF card driver?
Thread-Index: AcV3xqrClXZ6ddTIRhujjrTWXQaBxg==
From: "kus Kusche Klaus" <kus@keba.com>
To: <linux-pcmcia@lists.infradead.org>, <dahinds@users.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Environment:
* Embedded system, ARM platform, sa1100 processor
* Current Linux standard (or RT) kernel (2.6.12-something)
* Statically linked kernel, no module infrastructure and no initrd at
all
* Static /dev, no udev or devfs
* "hotplug" or card services not wanted
* sa1100 PCMCIA interface, PC Card / CF adapter
  (e.g. Kingston Model No. CF/ADP)
  (possibly other PC cards like WLAN, too,
  but a CF adapter is the only PC card 
  we really should officially support)

Question:
* Any chance to get the CF card working in that environment?
* Any chance to boot from it?

Wishes and non-wishes:
* It would be nice to be able to replace the CF 
  without rebooting.
* It can be assumed that the PC card CF adapter 
  is present during boot.
* There is no need to support hotplugging of the PC card CF adapter.
  (i.e. the PC card CF adapter could be treated as a static,
  builtin device, with its driver linked into the kernel).

Many thanks in advance for any help!

Klaus Kusche
> Entwicklung Software - Steuerung
> Software Development - Control
> 
> KEBA AG
> A-4041 Linz
> Gewerbepark Urfahr
> Tel +43 / 732 / 7090-3120
> Fax +43 / 732 / 7090-6301
> E-Mail: kus@keba.com
> www.keba.com
> 
> 
