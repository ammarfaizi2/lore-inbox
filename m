Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751204AbWDFMLV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbWDFMLV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 08:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750900AbWDFMLV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 08:11:21 -0400
Received: from 220-130-178-143.HINET-IP.hinet.net ([220.130.178.143]:11771
	"EHLO areca.com.tw") by vger.kernel.org with ESMTP id S1751204AbWDFMLU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 08:11:20 -0400
Message-ID: <001901c65973$0bf933b0$b100a8c0@erich2003>
From: "erich" <erich@areca.com.tw>
To: "Linux Andrew Morton" <akpm@osdl.org>
Cc: <oliver@neukum.org>, <akpm@osdl.org>, <alan@lxorguk.ukuu.org.uk>,
       <billion.wu@areca.com.tw>, <linux-kernel@vger.kernel.org>,
       <linux-scsi@vger.kernel.org>,
       "\"\"\"Christoph Hellwig\"\"\"" <hch@infradead.org>,
       "Chris Caputo" <ccaputo@alt.net>
Subject: areca-raid-linux-scsi-driver-update5.patch for 2.6.17-rc1-mm1
Date: Thu, 6 Apr 2006 20:10:05 +0800
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0016_01C659B6.18986BC0"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.3790.1830
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.1830
X-OriginalArrivalTime: 06 Apr 2006 12:06:15.0046 (UTC) FILETIME=[80E7DA60:01C65972]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0016_01C659B6.18986BC0
Content-Type: text/plain;
	format=flowed;
	charset="big5";
	reply-type=original
Content-Transfer-Encoding: 7bit

From: Erich Chen <erich@areca.com.tw>

  1- modify ARCMSR_MAX_XFER_SECTORS 4096 into 512
  2- add new SAS RAID Adapter device id

Signed-off-by: Erich Chen <erich@areca.com.tw>
---
 drivers/scsi/arcmsr/arcmsr.h     |    2 
 drivers/scsi/arcmsr/arcmsr_hba.c |   80 ++++++++---------------------
 include/linux/pci_ids.h          |    4 +
 3 files changed, 28 insertions(+), 58 deletions(-)

Best Regards
Erich Chen
------=_NextPart_000_0016_01C659B6.18986BC0
Content-Type: application/x-compressed;
	name="areca-raid-linux-scsi-driver-update5.patch.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="areca-raid-linux-scsi-driver-update5.patch.gz"

H4sICId3NUQAA2FyZWNhLXJhaWQtbGludXgtc2NzaS1kcml2ZXItdXBkYXRlNS5wYXRjaADNWP9P
o0gU/7n8FS9eLmkt08JQvti9NSJFl0TbBtDzkksIArVkKzWA6xrP//1mgFpra4fTvV0nKUOGz3vz
Po/PvGF6lM6v+2CmcTAFYxol8EdE7w/8NAr8TjC/7uR3+xwHICK4nofx5B502zh1bO9Uv/Aujkzb
c0zDHdkO9IQ9BeIkn4MsYmKBEfhhCEl0B47ugK1bA9BD/yaPUgijb3EQQRxynBNfJVGI5pMJurxn
h4IQ4iBM429RmnWzIIu7fhpcZ2nVdaZA2z/0gmEb0pteEq8FUhOgXTW0qXGEVjC7DaPuLE5uv3dv
gtiLw6yaazlhD9ocSDCJZ1EGwdRPrqKQB6wR8yxK83ieZM12iwdZIwmYReUAanGUFJSutzHrzNP4
qoEFQUFCDwkKiFIf9/qy0BEWDciwIHCESA1/L10p/Z625urgAFBP41VoF9eDAw5+C6NJnETPhXBk
m6ZhHHrDs9NG2bCmrSEHtnVOBEN+jjUaUtTOoIgPzkmMJBsgdjBl0xGlnTVrx3AszxparqUTvXnW
oJpIljm0IaTn2iyR1auiOuXatSwahZI3QF3dPjbdRQgNENUtsJOz4QIH60mhOON04I1NuwI+fzI6
cx1XHw6s4TFF1VJKqeyNapH7kvgmtZQ+X7jr4b6oblSMKEm8Am3aiQIRDWS5n8cB6dLbIAe6gMoS
QNYRVDMUAxw0HsaG5Q3Mc8swm/T23BwOivft6bZp6Dwsnz8NeiJWhNYj/3Zz9X3mWmHefqO59F5z
8T3myvtmV8rZSeoEHoRHHrq74EbpdZyQV55cQZTk6T3sdjl4/MTB6WhwdmIuvLj64YnZJHLgV1RA
ZeHl/uUsan2q9CSrPC3ToqSIfA8/k1RAimhOq20Ku5WPOJnMm5XUHCqpG904hM+wGKt2IWNOIpvP
Dmfz4CvstmA6z3K0T6+hn/sk1sZSo5+B+kD7N2QI7ZfjFJHdxXkwbT4BW/DAoUbgZ9HmZImi0CeQ
NgOyFYAJ4IHM3WhkNynZcCfNy9sJT6Yl9bSA0AJC3VBzdEG2pfHIdh2yC7t6uQ0bo6Frj05OTBt2
yFRPdgXiy8hxQR/oY5c8XofTeXf+ThYb3+9ZOcRvLvKtT8XTyzTyvxa3j9vTg9npwYz0iBILoLAA
KusNsGLArBgwKwbMjEErUsWUAV7IQPvxMmjScQWZw2NraIKVZHEYtf43bUhMbZA6uj1ppFJuBygs
D6Ta1Uq7tEi7iP9D3p0PmHalSDtiEVaeCCvbCaOaFNBWCmhJATEpqPUoqAsKmFEyfz4FLNaigKui
b16MbdNxWKUfrdfyHxgyrhcyXg2ZUaZ+QeqlejykVR6sdf8LiNRbyVh5QeTDrWdcbz1jdZXIB1zV
dLehn5kT/3aWs/aVC+T+NTZr7CMV8GdvJcuz6St/l2w8kop9GW85kr7i6oUXWe3Le5tPonuaXBxF
aV+cRZcn8NdWSUP4TjsWUC2BKhOolUBNWP7t8NrnCwVKNYBiCRQZQKX0qDA9KqVH0nGwSmd5CHSw
NYKVRizUUH6NPsV7f1rD53hZlUTuX8n0lLF1FAAA

------=_NextPart_000_0016_01C659B6.18986BC0--

