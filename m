Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262340AbVC2LDY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262340AbVC2LDY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 06:03:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262358AbVC2LDX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 06:03:23 -0500
Received: from mail1.upco.es ([130.206.70.227]:4016 "EHLO mail1.upco.es")
	by vger.kernel.org with ESMTP id S262340AbVC2LDN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 06:03:13 -0500
Date: Tue, 29 Mar 2005 13:03:09 +0200
From: Romano Giannetti <romanol@upco.es>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>
Subject: swsusp not working for me on a PREEMPT 2.6.12-rc1 and 2.6.12-rc1-mm3 kernel
Message-ID: <20050329110309.GA17744@pern.dea.icai.upco.es>
Mail-Followup-To: Romano Giannetti <romanol@upco.es>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	Pavel Machek <pavel@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

   swsusp is not working for me with 2.6.12rc1. I compiled the kernel
   preempt, I am compiling now without preempt to test it. -mm3 has a
   similar behaviour.
   
   All the configuration, dmesg, lsmod etc is here: 
   http://www.dea.icai.upco.es/romano/linux/config-2.6.12-rc1/laptop-config.html   

   
   Perfectly working (swsup included) similar data is in: 
   http://www.dea.icai.upco.es/romano/linux/config-2.6.11-rg/laptop-config.html

   When suspending, it stops dead with thi two lines (hand copied) 
   
   ACPI: PCI interrupt 0000:00:07.5 [C] -> GSI 5 (level, low) -> IRQ5
   ACPI: PCI interrupt 0000:00:0e.0 [A] -> GSI 9 (level, low) -> IRQ9
   
   ...and nothing more. 
   
          Romano    

-- 
Romano Giannetti             -  Univ. Pontificia Comillas (Madrid, Spain)
Electronic Engineer - phone +34 915 422 800 ext 2416  fax +34 915 596 569
