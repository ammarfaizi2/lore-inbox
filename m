Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261193AbVA0UuT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbVA0UuT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 15:50:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261192AbVA0Uqt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 15:46:49 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61900 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261187AbVA0UqC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 15:46:02 -0500
Message-ID: <41F952F4.7040804@pobox.com>
Date: Thu, 27 Jan 2005 15:45:40 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>, Netdev <netdev@oss.sgi.com>
CC: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>
Subject: [ANN] removal of certain net drivers coming soon: eepro100, xircom_tulip_cb,
 iph5526
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(GregKH cc'd for his deprecated list)

Though this has already been mentioned, I thought I would send out a 
reminder.  The following net drivers are slated for removal "soon", in 
the next kernel version or so:


1) iphase (iph5526 a.k.a. drivers/net/fc/*)

Been broken since 2.3 or 2.4.  Only janitors have kept it compiling.


2) xircom_tulip_cb

Unmaintained, and does not work for all xircom 32bit cards.  xircom_cb, 
on the other hand, works for ALL xircom 32bit cards.


3) eepro100

Unmaintained; users should use e100.

When I last mentioned eepro100 was going away, I got a few private 
emails saying complaining about issues not yet taken care of in e100. 
eepro100 will not be removed until these issues are resolved.



