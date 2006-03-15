Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752134AbWCOXD6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752134AbWCOXD6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 18:03:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752137AbWCOXD6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 18:03:58 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:60817 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1752134AbWCOXD5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 18:03:57 -0500
Date: Thu, 16 Mar 2006 00:03:14 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Jean Delvare <khali@linux-fr.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Etienne Lorrain <etienne_lorrain@yahoo.fr>,
       "Mark M. Hoffman" <mhoffman@lightlink.com>
Subject: Re: [ot] VIA southbridge strangeness (was: sis96x compiled in by
 error: delay of one minute at boot)
In-Reply-To: <9M1JwY7o.1142329434.1027530.khali@localhost>
Message-ID: <Pine.LNX.4.61.0603152359170.20859@yvahk01.tjqt.qr>
References: <9M1JwY7o.1142329434.1027530.khali@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>> I have this lspci:
>> (...)
>> 0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI Bridge
>> (...)
>> 0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
>
>Off-topic, but it's quite strange. Your south bridge cannot be a VT8237R
>and a VT8235 at the same time...
>

Where does it say that the southbridge is 35 and 37 at the same time? (The 
only thing that's different between the two lspci lines is the vtABCD 
number...)
Or it looks like there's another of these "strange" cases:

0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo 
MVP3/Pro133x AGP]
0000:00:07.0 ISA bridge: VIA Technologies, Inc. VT82C596 ISA [Mobile South] 
(rev 23)



Jan Engelhardt
-- 
