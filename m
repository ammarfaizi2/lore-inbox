Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262948AbUCKCSv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 21:18:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262946AbUCKCSv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 21:18:51 -0500
Received: from webmail-outgoing.us4.outblaze.com ([205.158.62.67]:6062 "EHLO
	webmail-outgoing.us4.outblaze.com") by vger.kernel.org with ESMTP
	id S262948AbUCKCSs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 21:18:48 -0500
X-OB-Received: from unknown (205.158.62.93)
  by wfilter.us4.outblaze.com; 11 Mar 2004 02:18:30 -0000
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "dan carpenter" <error27@email.com>
To: linux-kernel@vger.kernel.org
Cc: linux-scsi@vger.kernel.org
Date: Wed, 10 Mar 2004 21:18:47 -0500
Subject: megaraid on opteron w/ 8G RAM
X-Originating-Ip: 67.112.215.16
X-Originating-Server: ws3-3.us4.outblaze.com
Message-Id: <20040311021847.B02281D7244@ws3-3.us4.outblaze.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

