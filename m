Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267313AbUJTVPp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267313AbUJTVPp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 17:15:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270334AbUJTVKn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 17:10:43 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:54746 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S267313AbUJTVGH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 17:06:07 -0400
Date: Wed, 20 Oct 2004 23:03:50 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: netdev@oss.sgi.com
Cc: linux-kernel@vger.kernel.org
Subject: [mini-RFT] r8169 and amd64
Message-ID: <20041020210350.GA12577@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Could someone with an amd64 system test the r8169 driver in Jeff's -netdev
with PCI DAC enabled and send me the values of the command and status
registers which are displayed when the PCI error happen ?

One just need to give an "use_dac=1" option to the r8169 module.

Apparently the 8169 does not hesitate to issue harmless PCI error. They could
be identified and thus ignored.


Alternate location for the relevant patch against 2.6.9:
http://www.fr.zoreil.com/people/francois/misc/20041020-2.6.9-r8169.c-test.patch 

Thank you for your attention.

--
Ueimor
