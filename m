Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751085AbVK2Jvl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751085AbVK2Jvl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 04:51:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751043AbVK2Jvl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 04:51:41 -0500
Received: from shoshil.marvell.com ([199.203.130.250]:61057 "EHLO
	il.marvell.com") by vger.kernel.org with ESMTP id S1751040AbVK2Jvk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 04:51:40 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: ocf-linux-20051110 - Asynchronous Crypto support for linux
Date: Tue, 29 Nov 2005 11:51:18 +0200
Message-ID: <B9FFC3F97441D04093A504CEA31B7C4168581E@msilexch01.marvell.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: ocf-linux-20051110 - Asynchronous Crypto support for linux
Thread-Index: AcXl9AY+aoogr3WTSH6VbHxVRX7wDgO1Hh8w
From: "Ronen Shitrit" <rshitrit@marvell.com>
To: "David McCullough" <davidm@snapgear.com>, <linux-crypto@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I want to use the OCF OpenSwan KLIPS,
I can see that the openswan patch is very big,
What exactly does this patch support:
 Which encryption Alg does it support??
 Which Authentication Alg does it support??
 I saw that part of the patch is for the kernel and part for the user??
 Is there any readme describing this patch??
 

Is there any working going on, for porting the OCF to the kernel IPsec??

Regards
Ronen Shitrit


-----Original Message-----
From: linux-crypto-owner@vger.kernel.org
[mailto:linux-crypto-owner@vger.kernel.org] On Behalf Of David
McCullough
Sent: Thursday, November 10, 2005 2:37 PM
To: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: ocf-linux-20051110 - Asynchronous Crypto support for linux


Hi all,

A new release of the ocf-linux package is up:

	http://ocf-linux.sourceforge.net/

Mostly Openswan updates/cleanups and fixes in this release.

* Patch for the latest OpenSwan to utilise OCF for full IPSEC
  ESP and AH processing.
* Well tested on 2.4.31 and 2.6.14 with OpenSwan.
* Simple single patch to add OCF to 2.4 or 2.6 kernels.
* Fixed broken openssl speed test (Ronen Shitrit)

Cheers,
Davidm

-- 
David McCullough, davidm@cyberguard.com.au, Custom Embedded Solutions +
Security
Ph:+61 734352815 Fx:+61 738913630 http://www.uCdot.org
http://www.cyberguard.com
-
To unsubscribe from this list: send the line "unsubscribe linux-crypto"
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
