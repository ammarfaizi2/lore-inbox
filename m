Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265948AbUA1M2L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 07:28:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265944AbUA1M2L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 07:28:11 -0500
Received: from amalthea.dnx.de ([193.108.181.146]:39837 "EHLO amalthea.dnx.de")
	by vger.kernel.org with ESMTP id S265948AbUA1M2H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 07:28:07 -0500
Date: Wed, 28 Jan 2004 13:28:03 +0100
From: Robert Schwebel <robert@schwebel.de>
To: linux-kernel@vger.kernel.org
Subject: DHCP root-path in 2.6
Message-ID: <20040128122803.GP23652@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

the 2.6 behaviour of the root-path option seems to have changed: in 2.4
it was possible to do this in the DHCP configuration:

	option root-path "192.168.1.1:/path/to/root";

to specify an NFS server other than the TFTP boot server where the
kernel comes from; in 2.6 the code in ipconfig.c which parses this
option for the IP address has been removed. 

Was this done on purpuse or by accident? What's the "correct" way to
specify the address? 

Robert
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hornemannstraﬂe 12,  31137 Hildesheim, Germany
    Phone: +49-5121-28619-0 |  Fax: +49-5121-28619-4
