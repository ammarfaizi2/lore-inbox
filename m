Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751327AbWBJTuP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751327AbWBJTuP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 14:50:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbWBJTuP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 14:50:15 -0500
Received: from wproxy.gmail.com ([64.233.184.205]:6537 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751327AbWBJTuO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 14:50:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=AVfRFBBxxzsWmhH6qZFRozeG85ddZS8P6DYlR9IvclMe9GQl+DL7xh6SB58eTL5jURwaWPgKe76D8uPkmC0fkPGgnzGaYcThE6kTzRwTzT/xn6Vztr6EcxJCXxaqUNLA7936kqAc+kk5D088A/Nn+Push3QP6isoY3CiJrJbcfA=
Message-ID: <b5def3a40602101150w52bc1c66v6307d45a00a15c36@mail.gmail.com>
Date: Fri, 10 Feb 2006 14:50:10 -0500
From: Ivan Matveich <ivan.matveich@gmail.com>
To: linux-kernel@vger.kernel.org, adaplas@pol.net, torvalds@osdl.org
Subject: [patch/trivial] nvidiafb: detect GeForce4 MX 4000 AGP 8x
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_373_5343997.1139601010693"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_373_5343997.1139601010693
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Content-Disposition: inline

VGhpcyBwYXRjaCBtYWtlcyBudmlkaWFmYiBkZXRlY3QgbXkgdmlkZW8gY2FyZDsgaXQgc2VlbXMg
dG8gd29yayBmaW5lLgoKbHNwY2kgZm9yIHRoZSBjYXJkOgoKMDAwMDowMTowMC4wIFZHQSBjb21w
YXRpYmxlIGNvbnRyb2xsZXI6IG5WaWRpYSBDb3Jwb3JhdGlvbiBOVjE4CltHZUZvcmNlNCBNWCA0
MDAwIEFHUCA4eF0gKHJldiBjMSkgKHByb2ctaWYgMDAgW1ZHQV0pCiAgICAgICAgQ29udHJvbDog
SS9PKyBNZW0rIEJ1c01hc3RlcisgU3BlY0N5Y2xlLSBNZW1XSU5WLSBWR0FTbm9vcC0KUGFyRXJy
LSBTdGVwcGluZy0gU0VSUi0gRmFzdEIyQi0KICAgICAgICBTdGF0dXM6IENhcCsgNjZNSHorIFVE
Ri0gRmFzdEIyQisgUGFyRXJyLSBERVZTRUw9bWVkaXVtCj5UQWJvcnQtIDxUQWJvcnQtIDxNQWJv
cnQtID5TRVJSLSA8UEVSUi0KICAgICAgICBMYXRlbmN5OiAzMiAoMTI1MG5zIG1pbiwgMjUwbnMg
bWF4KQogICAgICAgIEludGVycnVwdDogcGluIEEgcm91dGVkIHRvIElSUSAyMjUKICAgICAgICBS
ZWdpb24gMDogTWVtb3J5IGF0IGZkMDAwMDAwICgzMi1iaXQsIG5vbi1wcmVmZXRjaGFibGUpIFtz
aXplPTE2TV0KICAgICAgICBSZWdpb24gMTogTWVtb3J5IGF0IGUwMDAwMDAwICgzMi1iaXQsIHBy
ZWZldGNoYWJsZSkgW3NpemU9MTI4TV0KICAgICAgICBFeHBhbnNpb24gUk9NIGF0IGZlOWUwMDAw
IFtkaXNhYmxlZF0gW3NpemU9MTI4S10KICAgICAgICBDYXBhYmlsaXRpZXM6IFs2MF0gUG93ZXIg
TWFuYWdlbWVudCB2ZXJzaW9uIDIKICAgICAgICAgICAgICAgIEZsYWdzOiBQTUVDbGstIERTSS0g
RDEtIEQyLSBBdXhDdXJyZW50PTBtQQpQTUUoRDAtLEQxLSxEMi0sRDNob3QtLEQzY29sZC0pCiAg
ICAgICAgICAgICAgICBTdGF0dXM6IEQwIFBNRS1FbmFibGUtIERTZWw9MCBEU2NhbGU9MCBQTUUt
CiAgICAgICAgQ2FwYWJpbGl0aWVzOiBbNDRdIEFHUCB2ZXJzaW9uIDMuMAogICAgICAgICAgICAg
ICAgU3RhdHVzOiBSUT0zMiBJc28tIEFycVN6PTAgQ2FsPTMgU0JBKyBJVEFDb2gtIEdBUlQ2NC0K
SFRyYW5zLSA2NGJpdC0gRlcrIEFHUDMrIFJhdGU9eDQseDgKICAgICAgICAgICAgICAgIENvbW1h
bmQ6IFJRPTEgQXJxU3o9MCBDYWw9MCBTQkEtIEFHUC0gR0FSVDY0LSA2NGJpdC0KRlctIFJhdGU9
PG5vbmU+CgpkbWVzZyBvdXRwdXQ6CgpudmlkaWFmYjogUENJIGlkIC0gMTBkZTAxODUKbnZpZGlh
ZmI6IEFjdHVhbCBpZCAtIDEwZGUwMTg1Cm52aWRpYWZiOiBuVmlkaWEgZGV2aWNlL2NoaXBzZXQg
MTBERTAxODUKbnZpZGlhZmI6IENSVEMwIGFuYWxvZyBub3QgZm91bmQKbnZpZGlhZmI6IENSVEMx
IGFuYWxvZyBub3QgZm91bmQKbnZpZGlhZmI6IEVESUQgZm91bmQgZnJvbSBCVVMyCiAgICAgIERp
c3BsYXkgaXMgR1RGIGNhcGFibGUKbnZpZGlhZmI6IENSVEMgMCBpcyBjdXJyZW50bHkgcHJvZ3Jh
bW1lZCBmb3IgREZQCm52aWRpYWZiOiBVc2luZyBERlAgb24gQ1JUQyAwClBhbmVsIHNpemUgaXMg
MTI4MCB4IDEwMjQKbnZpZGlhZmI6IE1UUlIgc2V0IHRvIE9OCm52aWRpYWZiOiBGbGF0IHBhbmVs
IGRpdGhlcmluZyBkaXNhYmxlZApDb25zb2xlOiBzd2l0Y2hpbmcgdG8gY29sb3VyIGZyYW1lIGJ1
ZmZlciBkZXZpY2UgMTYweDY0Cm52aWRpYWZiOiBQQ0kgblZpZGlhIE5WMTggZnJhbWVidWZmZXIg
KDY0TUIgQCAweEUwMDAwMDAwKQo=
------=_Part_373_5343997.1139601010693
Content-Type: text/plain; name=patch.txt; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_ejiwqp46
Content-Disposition: attachment; filename="patch.txt"

diff --git a/drivers/video/nvidia/nvidia.c b/drivers/video/nvidia/nvidia.c
index dbcb896..a7c4e5e 100644
--- a/drivers/video/nvidia/nvidia.c
+++ b/drivers/video/nvidia/nvidia.c
@@ -138,6 +138,8 @@ static struct pci_device_id nvidiafb_pci
 	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE4_MX_420_8X,
 	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE4_MX_4000,
+	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE4_448_GO,
 	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE4_488_GO,
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 7a61ccd..82b83da 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -1087,6 +1087,7 @@
 #define PCI_DEVICE_ID_NVIDIA_GEFORCE4_MX_440_8X 0x0181
 #define PCI_DEVICE_ID_NVIDIA_GEFORCE4_MX_440SE_8X 0x0182
 #define PCI_DEVICE_ID_NVIDIA_GEFORCE4_MX_420_8X 0x0183
+#define PCI_DEVICE_ID_NVIDIA_GEFORCE4_MX_4000   0x0185
 #define PCI_DEVICE_ID_NVIDIA_GEFORCE4_448_GO    0x0186
 #define PCI_DEVICE_ID_NVIDIA_GEFORCE4_488_GO    0x0187
 #define PCI_DEVICE_ID_NVIDIA_QUADRO4_580_XGL    0x0188


------=_Part_373_5343997.1139601010693--
