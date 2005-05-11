Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261214AbVEKN0E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261214AbVEKN0E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 09:26:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261220AbVEKN0E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 09:26:04 -0400
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:4500
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S261214AbVEKNZ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 09:25:58 -0400
Reply-To: <abonilla@linuxwireless.org>
From: "Alejandro Bonilla" <abonilla@linuxwireless.org>
To: "'Rodrigo Ramos'" <rodrigo.ramos@triforsec.com.br>,
       <linux-kernel@vger.kernel.org>
Subject: RE: 802.1x support
Date: Wed, 11 May 2005 07:25:48 -0600
Message-ID: <003001c5562c$f247aae0$9f0cc60a@amer.sykes.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <1115813583.4959.240.camel@ZeroOne>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


|Hi All,
|
|
|Does the kernel has support to 802.1x?
|
|
|Best regards,
|--
|Rodrigo Ramos
|

The kernel has the support of Crypto used, I don't know if you are talking
about wired or wireless.

It has what is needed with AES, TKIP and so on for WPA, I think 1x is
transparent to the kernel and what you really need is the supplicant
software for the authentication. Take a look at wpa_supplicant and
xsupplicant.

You can use EAP, PEAP, LEAP and so on... I believe this is most based on the
driver of the NIC you use, and not that much maybe with the kernel (maybe
some interaction) but so the answer for your question would be. It has
whatever 1x needs.

.Alejandro

