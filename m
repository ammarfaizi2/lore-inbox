Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261554AbUCKCox (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 21:44:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261202AbUCKCox
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 21:44:53 -0500
Received: from mail0.lsil.com ([147.145.40.20]:26066 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S262961AbUCKCor (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 21:44:47 -0500
Message-ID: <0E3FA95632D6D047BA649F95DAB60E57033BC460@exa-atlanta.se.lsil.com>
From: "Mukker, Atul" <Atulm@lsil.com>
To: "'dan carpenter'" <error27@email.com>, linux-kernel@vger.kernel.org
Cc: linux-scsi@vger.kernel.org
Subject: RE: megaraid on opteron w/ 8G RAM
Date: Wed, 10 Mar 2004 21:44:42 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What is the megaraid2 driver version? Can you inline the panic messages?

-Atul Mukker

-----Original Message-----
From: dan carpenter [mailto:error27@email.com]
Sent: Wednesday, March 10, 2004 9:19 PM
To: linux-kernel@vger.kernel.org
Cc: linux-scsi@vger.kernel.org
Subject: megaraid on opteron w/ 8G RAM


I'm using the megaraid 1.19.6 driver on RedHat Work Station 
x86_64.  It works great with only 4 gigs of RAM installed, 
but it locks up when I load the module with 8 gigs of RAM 
installed.  It generally locks up in the issue_scb_block() 
but it's not always consistent about which line it locks 
up on within that function.

On the default Suse Linux Enterprise Server 8 the module 
loads but after around 5 hours of running drive tests the 
drives stop responding.

I also tried the megaraid2 module and that kernel panics 
when the module is loaded.

I'm using an arima motherboard with the 1.84 BIOS.

Is this a known issue?  Has anyone been able to make a 
similar config work?

regards,
dan carpenter
-- 
___________________________________________________________
Sign-up for Ads Free at Mail.com
http://promo.mail.com/adsfreejump.htm

-
To unsubscribe from this list: send the line "unsubscribe linux-scsi" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
