Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266853AbUHCW0a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266853AbUHCW0a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 18:26:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265743AbUHCW03
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 18:26:29 -0400
Received: from fep01fe.ttnet.net.tr ([212.156.4.130]:26577 "EHLO
	fep01.ttnet.net.tr") by vger.kernel.org with ESMTP id S266853AbUHCW02 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 18:26:28 -0400
Message-ID: <411010D6.5000301@ttnet.net.tr>
Date: Wed, 04 Aug 2004 01:25:26 +0300
From: "O.Sezer" <sezeroz@ttnet.net.tr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: tr, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: mikpe@csd.uu.se
Subject: Re: updated gcc-3.4 patches for 2.4.27-rc4
Content-Type: text/plain;
	charset=ISO-8859-9;
	format=flowed
Content-Transfer-Encoding: 8BIT
X-ESAFE-STATUS: Mail clean
X-ESAFE-DETAILS: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > 
http://www.csd.uu.se/~mikpe/linux/patches/2.4/patch-gcc34-misc-fixes-2.4.27-rc4

Does /drivers/usb/gadget/net2280.c line 794 not need the same
change for min() ?
FWIW: The -pac tree does a #define MIN(x,y) ((x) > (y) ? (y) : (x))
at the beginning and then changes the three instances of min() to
MIN()

Özkan Sezer
