Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261813AbVEJWi1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261813AbVEJWi1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 18:38:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261829AbVEJWi0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 18:38:26 -0400
Received: from mail.emacinc.com ([208.248.202.76]:13507 "EHLO mail.emacinc.com")
	by vger.kernel.org with ESMTP id S261796AbVEJWiN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 18:38:13 -0400
From: NZG <ngustavson@emacinc.com>
Organization: EMAC.Inc
To: linux-kernel@vger.kernel.org
Date: Tue, 10 May 2005 17:37:00 -0500
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200505101737.00544.ngustavson@emacinc.com>
X-SA-Exim-Connect-IP: 208.248.202.77
X-SA-Exim-Mail-From: ngustavson@emacinc.com
Subject: spi subsection & cfnvram
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have 3 new beta drivers for the 5282 coldfire architecture.
They were designed against EMAC.Inc's SoM-5282EM module.
This is based on the MMU less 5282 processor 

They are as listed below:

The mcf_qspi driver, ported to the new 2.6 kernel and modularized it to allow 
stackability. Currently the new kobject methodology is not supported yet, cuz 
I don't really understand it yet.

A DS1305 driver which stacks on top of the qspi layer and provides a standard 
misc RTC interface (somewhat SoM-5282EM dependent at this point as it's chip 
selects a little weird).

And a CFNVRAM driver, which provides a simple small partitionless block 
interface to the internal RAM of the 5282 processor(which can be battery 
backed). 

They are available as stand-alone projects at
ftp://SoM:sompublic@ftp.emacinc.com/SoM-5282EM/uClinux-projects

I'm going to try to get them into an official patch submission next week(I'm 
new to this process so please forgive my stumbles),

thx,
NZG.
