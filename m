Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261774AbTKTTkV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 14:40:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261793AbTKTTkU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 14:40:20 -0500
Received: from mail3a.westend.com ([212.117.79.77]:14031 "EHLO
	mail3a1.westend.com") by vger.kernel.org with ESMTP id S261774AbTKTTkQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 14:40:16 -0500
Date: Thu, 20 Nov 2003 20:40:13 +0100
From: Christian Hammers <ch@westend.com>
To: linux-kernel@vger.kernel.org
Subject: e100.c network driver suddenly stops working
Message-ID: <20031120194013.GA2275@westend.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

This is the second time now that I've experienced a e100.c network
driver to suddenly stop forwarding packets over an interface without
giving further warnings in the syslog until I did a "ifconfig down",
"ifconfig up". The running kernel was 2.4.22 with 802.1q VLAN enabled
on the interface. There were 3 additional interfaces and normal load.

Last time this happens while using the version shipped with kernel
2.4.22, this time it was version 2.3.27 from the intel homepage.

Does anybody else had this bug? I don't like switching to the eepro100.c 
driver as it had MTU problems when using 802.1q VLANs.

bye,

-christian-

-- 
Christian Hammers             WESTEND GmbH  |  Internet-Business-Provider
Technik                       CISCO Systems Partner - Authorized Reseller
                              Lütticher Straße 10      Tel 0241/701333-11
ch@westend.com                D-52064 Aachen              Fax 0241/911879

