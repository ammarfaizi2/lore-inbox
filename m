Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264301AbTLBTQk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 14:16:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264321AbTLBTQk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 14:16:40 -0500
Received: from crisium.vnl.com ([194.46.8.33]:55561 "EHLO crisium.vnl.com")
	by vger.kernel.org with ESMTP id S264301AbTLBTQf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 14:16:35 -0500
Date: Tue, 2 Dec 2003 19:16:32 +0000
From: Dale Amon <amon@vnl.com>
To: linux-kernel@vger.kernel.org
Subject: Buslogic driver warnings
Message-ID: <20031202191632.GY11972@vnl.com>
Mail-Followup-To: Dale Amon <amon@vnl.com>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux, the choice of a GNU generation
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed this when I started a test build for my workstation
with hopes of moving it over to 2.6.0-test11:

drivers/scsi/BusLogic.c: In function `BusLogic_InitializeProbeInfoListISA':
drivers/scsi/BusLogic.c:700: warning: `check_region' is deprecated (declared at include/linux/ioport.h:119)
drivers/scsi/BusLogic.c:704: warning: `check_region' is deprecated (declared at include/linux/ioport.h:119)
drivers/scsi/BusLogic.c:708: warning: `check_region' is deprecated (declared at include/linux/ioport.h:119)
drivers/scsi/BusLogic.c:712: warning: `check_region' is deprecated (declared at include/linux/ioport.h:119)
drivers/scsi/BusLogic.c:716: warning: `check_region' is deprecated (declared at include/linux/ioport.h:119)
drivers/scsi/BusLogic.c:720: warning: `check_region' is deprecated (declared at include/linux/ioport.h:119)
drivers/scsi/BusLogic.c: In function `BusLogic_InitializeMultiMasterProbeInfo':
drivers/scsi/BusLogic.c:973: warning: `check_region' is deprecated (declared at include/linux/ioport.h:119)
drivers/scsi/BusLogic.c:988: warning: `check_region' is deprecated (declared at include/linux/ioport.h:119)
drivers/scsi/BusLogic.c:993: warning: `check_region' is deprecated (declared at include/linux/ioport.h:119)
drivers/scsi/BusLogic.c:998: warning: `check_region' is deprecated (declared at include/linux/ioport.h:119)
drivers/scsi/BusLogic.c:1003: warning: `check_region' is deprecated (declared at include/linux/ioport.h:119)
drivers/scsi/BusLogic.c:1008: warning: `check_region' is deprecated (declared at include/linux/ioport.h:119)

Presumably someone is going to soon obsolete check_region, 
which will then break the Buslogic driver and most of
my machines.

Is anyone working on this driver these days?

-- 
------------------------------------------------------
   Dale Amon     amon@islandone.org    +44-7802-188325
       International linux systems consultancy
     Hardware & software system design, security
    and networking, systems programming and Admin
	      "Have Laptop, Will Travel"
------------------------------------------------------
