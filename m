Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275629AbTHOBOJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 21:14:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275630AbTHOBOJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 21:14:09 -0400
Received: from server0027.freedom2surf.net ([194.106.33.36]:24262 "EHLO
	server0027.freedom2surf.net") by vger.kernel.org with ESMTP
	id S275629AbTHOBOH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 21:14:07 -0400
Date: Fri, 15 Aug 2003 02:14:01 +0100
From: Ian Molton <spyro@f2s.com>
To: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: [BUG] ipaq USBserial driver
Message-Id: <20030815021401.792fae10.spyro@f2s.com>
Organization: The Dragon Roost
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Havent had time to track this down but the ipaq.c driver seems to have a
problem since about 2.5.57 or so.

I get repeatable stiffing of 2.6.0-test3 if I place my toshiba e750 in
the cradle while ipaq.ko is loaded. if it isnt loaded the machine is
fine. Im using uhci-hcd.

the e750 needs ipaq.c too be modified btw. (its prod id is 0x0409 not
0406 as is the toshiba e740).

-- 
Spyros lair: http://www.mnementh.co.uk/   ||||   Maintainer: arm26 linux

Do not meddle in the affairs of Dragons, for you are tasty and good with
ketchup.
