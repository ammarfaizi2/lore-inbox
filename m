Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136447AbRD3GJS>; Mon, 30 Apr 2001 02:09:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136446AbRD3GJI>; Mon, 30 Apr 2001 02:09:08 -0400
Received: from relay8.Austria.EU.net ([193.154.160.146]:56058 "EHLO
	relay8.austria.eu.net") by vger.kernel.org with ESMTP
	id <S136447AbRD3GIt>; Mon, 30 Apr 2001 02:08:49 -0400
Message-ID: <3AED016D.5D77F29E@eunet.at>
Date: Mon, 30 Apr 2001 08:08:45 +0200
From: Michael Reinelt <reinelt@eunet.at>
Organization: netWorks
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: DMI deactivated - why?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-AntiVirus: OK (checked by AntiVir Version 6.6.0.12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

I found a quite interesting file: arch/i386/kernel/dmi_scan.c

It should print some DMI values at boot. As far as I remember, I've seen
these at times of 2.4.0 or so. Now these outputs are deactivated with a 
#define dmi_printk(x)

Can someone explain why this has been deactivated? I would find these
values quite useful!

TIA, Michael

-- 
netWorks       	                                  Vox: +43 316  692396
Michael Reinelt                                   Fax: +43 316  692343
Geisslergasse 4					  GSM: +43 676 3079941
A-8045 Graz, Austria			      e-mail: reinelt@eunet.at
