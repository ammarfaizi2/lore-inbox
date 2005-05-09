Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263056AbVEIGM1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263056AbVEIGM1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 02:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263058AbVEIGM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 02:12:27 -0400
Received: from brmea-mail-3.Sun.COM ([192.18.98.34]:65203 "EHLO
	brmea-mail-3.sun.com") by vger.kernel.org with ESMTP
	id S263056AbVEIGMS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 02:12:18 -0400
Date: Mon, 09 May 2005 10:12:12 +0400
From: Mitch <Mitch@0Bits.COM>
Subject: Re: [RFT/PATCH] KVMS, mouse losing sync and going crazy
To: dtor_core@ameritech.net, linux-kernel@vger.kernel.org
Message-id: <427EFF3C.1040706@0Bits.COM>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_6BIBSR3OAprzuGGLZg5hvA)"
User-Agent: Mail/News Client 1.0+ (X11/20050427)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Boundary_(ID_6BIBSR3OAprzuGGLZg5hvA)
Content-type: text/plain; charset=ISO-8859-15; format=flowed
Content-transfer-encoding: 7BIT

Log file as requested...

Cheers
Mitch

-------- Original Message --------
Subject: Re: [RFT/PATCH] KVMS, mouse losing sync and going crazy
Date: Mon, 9 May 2005 01:02:33 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Mitch <Mitch@0Bits.COM>
CC: linux-kernel@vger.kernel.org
References: <427EF9D5.2010606@0Bits.COM>

On Monday 09 May 2005 00:49, Mitch wrote:
> I applied your v4 patch, and that fixes it somewhat insomuch as it it 
> working, but it keeps resetting itself if i stop using it for a few 
> milliseconds, so the mouse appears sluggish as it performs a reset 
> whenever i use it. Here are the messages i see (100's of them).
> 
> ALPS Touchpad (Dualpoint) detected
>    Disabling hardware tapping
> input: AlpsPS/2 ALPS TouchPad on isa0060/serio1
> psmouse.c: resync failed, issuing reconnect request
> psmouse.c: resync failed, issuing reconnect request
> ALPS Touchpad (Dualpoint) detected
>    Disabling hardware tapping
> input: AlpsPS/2 ALPS TouchPad on isa0060/serio1
> psmouse.c: resync failed, issuing reconnect request
> ALPS Touchpad (Dualpoint) detected
>    Disabling hardware tapping
> input: AlpsPS/2 ALPS TouchPad on isa0060/serio1
>

Could you please do the following:

1. Reboot with the patch applied
2. "echo 1 > /sys/modules/i8042/parameters/debug"
3. Wait 5-10 seconds
4. Touch your touchpad briefly
5. "echo 0 > /sys/modules/i8042/parameters/debug"
6. send me dmesg

Thanks!

-- 
Dmitry

--Boundary_(ID_6BIBSR3OAprzuGGLZg5hvA)
Content-type: application/gzip; name=log.gz
Content-transfer-encoding: BASE64
Content-disposition: inline; filename=log.gz

H4sICO7+fkIAA2xvZwC9nEGO2zgQRfc5hZYZIJkmKZIijWBukBMEs1DL9IyRbrtj
2YPk9qMECJK4nHIJ/MVdOov/8D+LZImi/H780nW5s2Zj0saH7uk4jU//Hudz97Gc
DuVp073Mz8fLXP6cNt2pzF8OU7cb909l+6bbz/Nlf/hn+e/peDiU6bz869OlzOdX
73+o5o3pb6huT/v/yml+2B9eLueHuZz2x4d9Mt595eSpe/e2+/Zn93p/OJfT6fJy
ftN9fFyo9o/ugx0G70z/968gm9eCdrvboPHyeQG5b6RsfPbVpK3v3v71nTQdn5/H
wxYovzM/yb+Mp/G5LGaQgFGWVNZNql6+PLJJ1QNkSQVTPyYmyUihnmRkpKEZSbXO
QqiPrIxMnSEAwjoLoqSqF3lw/oB5ntj8m83zmFQrFSBvuL0DARAmNdTPCS4pgHyJ
XFIAgDCpZFSTAsjzSQEA0qR0awogfyepZjWVrWpSAPmSuaQAAGlSzfqpDFncBaRo
6mdk9DKS06wzhDzbOSAAsjqLuj0uQp7tHBAAYVJWtcdCyJeBSwoAECbldGcfQJ5P
CgCQJlX/LMsmVS9/J6l6gDCpXrVzQMiznQMCIE0qVpOck5EAi7uM5OtnpJV1Dl61
l0fI8zMSABDWWVB9PkTI80kBANKkVE/2EfJ3kmp1sh+jbk0B5HeBSwoBECalWlND
BCwjXFIU4IxOUsNwvfOuJ3FJAeT5pBAAYVLX3Rw4qXr5O0kBALKk0vXswyYFkGe7
UQRAmBQ5MVtPclZGun5Tv55khKT6tcsI09OdkQB5fkYiAKKkEnnTDU0KIc8mBQHI
krKq+yFCnk8KARAmdX1iBk6qXv5OUgCALClXvyJySQHkd55LCgGQJdVfn2RgkwLI
s7e8IABhUtenS+Ck6uXZt6oIgDApf33ih00KIM8nBQAIkwr1PSKXFECeTwoAECZF
TjKwSQHk+b0PARAmpdqjZ4A8e0sQAZAllXVPYhDyu55LqtlJTB5UV3SEfOT6KQRA
mFTSrSmAPHvTAwGQJqW7TgHkDTv7AABhUuRLBmxSAHm2S0AApEmp9ugIefa5DwKQ
JGWNISuiXT3ov7ll99MHS9nFnjz0rwb533zy8SvIkw5Lx9GNQ8TVoEniKJH7ic5p
OOoN3R5Xg/yjCETqW8dRSORYQMdRoLuAjqNoG41RtI3GKJLPgbQchVZjBCgGmaPU
aIwGR7ZuHUcDubmn5Sg0mkcD+dpKyxFtr5Qc0Y1Px1FyjcYouUZjlOj1EiVH9PRk
9YfoMkeZjNFqkMhRpl2QjqNMLqpqOaItsZIj8nGeliN600XFkb/x2KLiaAGRlUHJ
kSert5Ij32qM6NOEkiP6NKHjyNpGY2RtozGygGKQOfKtxig1qjpLe28dR4723jqO
HO29lRzR3lvJUWizw3pHe28lR7T31nHU095bx1HvGo1RH8lLaiVHsT46maNGvfcC
arTW+Ua99wJqNI/80Ghl8K1679Cq96a/c6TlqFXvHeiNIiVHrXrv0Kr3DoC1bhI5
omud13C0VDd5Kl8N8lsRiKwMOo4crbrVoEniyNGqWw0yRQAa+voxSiIQLe9bP0fJ
OxKU91LdxNFqUBKAoqGvdVaD7P2fwsyx//pU/j/34mYDylMAAA==

--Boundary_(ID_6BIBSR3OAprzuGGLZg5hvA)--
