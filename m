Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933163AbWKMXWP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933163AbWKMXWP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 18:22:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933165AbWKMXWO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 18:22:14 -0500
Received: from dxa00.wellsfargo.com ([151.151.65.115]:29067 "EHLO
	dxa00.wellsfargo.com") by vger.kernel.org with ESMTP
	id S933163AbWKMXWN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 18:22:13 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C7077A.8A5EA244"
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
Subject: [PATCH 1/1] drivers/block/Kconfig text update.  Try #2
Date: Mon, 13 Nov 2006 17:22:09 -0600
Message-ID: <E8C008223DD5F64485DFBDF6D4B7F71D02235904@msgswbmnmsp25.wellsfargo.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 1/1] drivers/block/Kconfig text update.  Try #2
Thread-Index: AccHdIN6zJRKMTFHSzu8DW+J08S7fAABbOGg
From: <Greg.Chandler@wellsfargo.com>
To: <randy.dunlap@oracle.com>
Cc: <linux-kernel@vger.kernel.org>, <torvalds@osdl.org>
X-OriginalArrivalTime: 13 Nov 2006 23:22:09.0596 (UTC) FILETIME=[8A97D7C0:01C7077A]
X-WFMX: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C7077A.8A5EA244
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

=20
Sorry...
I've attached the new one.

>=20
> The second line of the drivers/block/cciss.c file says:
>=20
> " *    Disk Array driver for HP SA 5xxx and 6xxx Controllers"
>=20
> I couldn't find the 6 series anywhere in the menu, and I ended up=20
> finding it in the code...

Please read/observe Documentation/SubmittingPatches:
the --- & +++ lines should begin with linux/drivers/... or a/drivers/...
so that the patch can be applied with "patch -p1".

> --- drivers/block/Kconfig.old   2006-11-13 14:20:12.000000000 -0800
> +++ drivers/block/Kconfig       2006-11-13 14:20:32.000000000 -0800
> @@ -155,10 +155,10 @@
>           this driver.
>=20
>  config BLK_CPQ_CISS_DA
> -       tristate "Compaq Smart Array 5xxx support"
> +       tristate "Compaq Smart Array 5xxx/6xxx support"
>         depends on PCI
>         help
> -         This is the driver for Compaq Smart Array 5xxx controllers.
> +         This is the driver for Compaq Smart Array 5xxx/6xxx
> controllers.

Patch is line-wrapped on the line above.

>           Everyone using these boards should say Y here.
>           See <file:Documentation/cciss.txt> for the current list of
>           boards supported by this driver, and for further information

---
~Randy
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in the body of a message to majordomo@vger.kernel.org More majordomo
info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/



------_=_NextPart_001_01C7077A.8A5EA244
Content-Type: application/octet-stream;
	name="block_cciss_menu_update.diff"
Content-Transfer-Encoding: base64
Content-Description: block_cciss_menu_update.diff
Content-Disposition: attachment;
	filename="block_cciss_menu_update.diff"

LS0tIGxpbnV4LTIuNi4xOC4yL2RyaXZlcnMvYmxvY2svS2NvbmZpZy5vbGQgICAgMjAwNi0xMS0x
MyAxNDoyMDoxMi4wMDAwMDAwMDAgLTA4MDANCisrKyBsaW51eC0yLjYuMTguMi9kcml2ZXJzL2Js
b2NrL0tjb25maWcgICAgICAgIDIwMDYtMTEtMTMgMTQ6MjA6MzIuMDAwMDAwMDAwIC0wODAwDQpA
QCAtMTU1LDEwICsxNTUsMTAgQEAgY29uZmlnIEJMS19DUFFfREENCiAgICAgICAgICB0aGlzIGRy
aXZlci4NCg0KIGNvbmZpZyBCTEtfQ1BRX0NJU1NfREENCi0gICAgICAgdHJpc3RhdGUgIkNvbXBh
cSBTbWFydCBBcnJheSA1eHh4IHN1cHBvcnQiDQorICAgICAgIHRyaXN0YXRlICJDb21wYXEgU21h
cnQgQXJyYXkgNXh4eC82eHh4IHN1cHBvcnQiDQogICAgICAgIGRlcGVuZHMgb24gUENJDQogICAg
ICAgIGhlbHANCi0gICAgICAgICBUaGlzIGlzIHRoZSBkcml2ZXIgZm9yIENvbXBhcSBTbWFydCBB
cnJheSA1eHh4IGNvbnRyb2xsZXJzLg0KKyAgICAgICAgIFRoaXMgaXMgdGhlIGRyaXZlciBmb3Ig
Q29tcGFxIFNtYXJ0IEFycmF5IDV4eHgvNnh4eCBjb250cm9sbGVycy4NCiAgICAgICAgICBFdmVy
eW9uZSB1c2luZyB0aGVzZSBib2FyZHMgc2hvdWxkIHNheSBZIGhlcmUuDQogICAgICAgICAgU2Vl
IDxmaWxlOkRvY3VtZW50YXRpb24vY2Npc3MudHh0PiBmb3IgdGhlIGN1cnJlbnQgbGlzdCBvZg0K
ICAgICAgICAgIGJvYXJkcyBzdXBwb3J0ZWQgYnkgdGhpcyBkcml2ZXIsIGFuZCBmb3IgZnVydGhl
ciBpbmZvcm1hdGlvbg0K

------_=_NextPart_001_01C7077A.8A5EA244--
