Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161314AbWJRTcp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161314AbWJRTcp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 15:32:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161315AbWJRTcp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 15:32:45 -0400
Received: from bizon.gios.gov.pl ([212.244.124.8]:691 "EHLO bizon.gios.gov.pl")
	by vger.kernel.org with ESMTP id S1161314AbWJRTcp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 15:32:45 -0400
Date: Wed, 18 Oct 2006 21:32:39 +0200 (CEST)
From: Krzysztof Oledzki <olel@ans.pl>
X-X-Sender: olel@bizon.gios.gov.pl
To: linux-kernel@vger.kernel.org
Subject: 2.6.18 and tsc clocksource on SMP
Message-ID: <Pine.LNX.4.64.0610182125580.29565@bizon.gios.gov.pl>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-187430788-1637480907-1161199959=:29565"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---187430788-1637480907-1161199959=:29565
Content-Type: TEXT/PLAIN; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hello,

I have just upgraded kernel (2.6.16.x->2.6.18.1) on on of my servers (Dell=
=20
PowerEdge1425SC with 2 CPUs with HT - total 4 CPUs) and noticed that=20
system no longer uses HPET as a clocksource.

# cat /sys/devices/system/clocksource/clocksource0/available_clocksource
acpi_pm jiffies hpet tsc pit

# cat /sys/devices/system/clocksource/clocksource0/current_clocksource
tsc

AFAIK TSC should not be used on SMP systems, shouldn't it?

Best regards,


 =09=09=09=09Krzysztof Ol=EAdzki
---187430788-1637480907-1161199959=:29565--
