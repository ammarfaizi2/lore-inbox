Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262750AbTLSMGw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 07:06:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262765AbTLSMGv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 07:06:51 -0500
Received: from [164.164.56.19] ([164.164.56.19]:60626 "EHLO mail1.sasken.com")
	by vger.kernel.org with ESMTP id S262750AbTLSMGt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 07:06:49 -0500
Date: Fri, 19 Dec 2003 17:43:17 +0530 (IST)
From: Madhavi <madhavis@sasken.com>
To: <linux-kernel@vger.kernel.org>
Subject: VLAN switching in linux kernel...
Message-ID: <Pine.LNX.4.33.0312191736510.17109-100000@pcz-madhavis.sasken.com>
MIME-Version: 1.0
Content-type: multipart/mixed; boundary="=_IS_MIME_Boundary"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=_IS_MIME_Boundary
Content-Type: TEXT/PLAIN; charset=US-ASCII


Hi,

I have a doubt regarding the VLAN operation of the Standard Linux kernel
(linux-2.4.20).

My network setup is something like this:

---+---------------+------ VLAN ID 200
   |eth0.200       |eth0.200
+------+       +------+
|  HA  |       |Router|
+------+       +------+
                   |eth1.300
-----------+-------------- VLAN ID 300
           |eth0.300
        +------+
        |  HB  |
        +------+

When I send ping packets from HA to HB over the interface eth0.200, is
possible for the Router (using linux-2.4.20 with CONFIG_8021Q option) to
switch packets from VLAN 200 to VLAN 300?

Is this VLAN switching functionality supported by the standard linux kernel?
Is there some extra configuration, some patches or sources that can support
this feature for linux?

I would be a great help to me if someone could answer this or give some
pointers to this?

Thanks & Regards
Madhavi.

Madhavi Suram
Senior Software Engineer
Customer Delivery / Networks
Sasken Communication Technologies Limited
139/25, Ring Road, Domlur
Bangalore - 560071 India
Email: madhavis@sasken.com
Tel: + 91 80 5355501 Extn: 8062
Fax: + 91 80 5351133
URL: www.sasken.com


--=_IS_MIME_Boundary
Content-Type: text/plain;charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

***********************************************************************

SASKEN BUSINESS DISCLAIMER

This message may contain confidential, proprietary or legally Privileged information. In case you are not the original intended Recipient of the message, you must not, directly or indirectly, use, Disclose, distribute, print, or copy any part of this message and you are requested to delete it and inform the sender. Any views expressed in this message are those of the individual sender unless otherwise stated. Nothing contained in this message shall be construed as an offer or acceptance of any offer by Sasken Communication Technologies Limited ("Sasken") unless sent with that express intent and with due authority of Sasken. Sasken has taken enough precautions to prevent the spread of viruses. However the company accepts no liability for any damage caused by any virus transmitted by this email.

***********************************************************************

--=_IS_MIME_Boundary--
