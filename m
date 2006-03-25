Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751323AbWCYWiJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323AbWCYWiJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 17:38:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbWCYWiJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 17:38:09 -0500
Received: from terminus.zytor.com ([192.83.249.54]:60653 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751323AbWCYWiI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 17:38:08 -0500
Message-ID: <4425C637.1000400@zytor.com>
Date: Sat, 25 Mar 2006 14:37:43 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Alexander Viro <viro@ftp.linux.org.uk>,
       Christoph Hellwig <hch@lst.de>, pavlas@nextra.cz,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Update documentation for BLK_DEV_INITRD to match current
 usage.
Content-Type: multipart/mixed;
 boundary="------------090905070509040804050809"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090905070509040804050809
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



--------------090905070509040804050809
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="diff"

VXBkYXRlIGRvY3VtZW50YXRpb24gZm9yIEJMS19ERVZfSU5JVFJEIHRvIG1hdGNoIGN1cnJl
bnQgdXNhZ2UuCgpDYzogQWwgVmlybyA8dmlyb0BmdHAubGludXgub3JnLnVrPgpDYzogQ2hy
aXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+CkNjOiBaZGVuZWsgUGF2bGFzIDxwYXZsYXNA
bmV4dHJhLmN6PgpTaWduZWQtb2ZmLWJ5OiBILiBQZXRlciBBbnZpbiA8aHBhQHp5dG9yLmNv
bT4KCmRpZmYgLS1naXQgYS9kcml2ZXJzL2Jsb2NrL0tjb25maWcgYi9kcml2ZXJzL2Jsb2Nr
L0tjb25maWcKaW5kZXggZTU3YWM1YS4uODc1YWU3NiAxMDA2NDQKLS0tIGEvZHJpdmVycy9i
bG9jay9LY29uZmlnCisrKyBiL2RyaXZlcnMvYmxvY2svS2NvbmZpZwpAQCAtNDAwLDEzICs0
MDAsMTYgQEAgY29uZmlnIEJMS19ERVZfUkFNX1NJWkUKIAkgIDgxOTIuCiAKIGNvbmZpZyBC
TEtfREVWX0lOSVRSRAotCWJvb2wgIkluaXRpYWwgUkFNIGRpc2sgKGluaXRyZCkgc3VwcG9y
dCIKKwlib29sICJJbml0aWFsIFJBTSBmaWxlc3lzdGVtIGFuZCBSQU0gZGlzayAoaW5pdHJh
bWZzL2luaXRyZCkgc3VwcG9ydCIKIAloZWxwCi0JICBUaGUgaW5pdGlhbCBSQU0gZGlzayBp
cyBhIFJBTSBkaXNrIHRoYXQgaXMgbG9hZGVkIGJ5IHRoZSBib290IGxvYWRlcgotCSAgKGxv
YWRsaW4gb3IgbGlsbykgYW5kIHRoYXQgaXMgbW91bnRlZCBhcyByb290IGJlZm9yZSB0aGUg
bm9ybWFsIGJvb3QKLQkgIHByb2NlZHVyZS4gSXQgaXMgdHlwaWNhbGx5IHVzZWQgdG8gbG9h
ZCBtb2R1bGVzIG5lZWRlZCB0byBtb3VudCB0aGUKLQkgICJyZWFsIiByb290IGZpbGUgc3lz
dGVtLCBldGMuIFNlZSA8ZmlsZTpEb2N1bWVudGF0aW9uL2luaXRyZC50eHQ+Ci0JICBmb3Ig
ZGV0YWlscy4KKwkgIFRoZSBpbml0aWFsIFJBTSBmaWxlc3lzdGVtIGlzIGEgcmFtZnMgd2hp
Y2ggaXMgbG9hZGVkIGJ5IHRoZQorCSAgYm9vdCBsb2FkZXIgKGxvYWRsaW4gb3IgbGlsbykg
YW5kIHRoYXQgaXMgbW91bnRlZCBhcyByb290CisJICBiZWZvcmUgdGhlIG5vcm1hbCBib290
IHByb2NlZHVyZS4gSXQgaXMgdHlwaWNhbGx5IHVzZWQgdG8KKwkgIGxvYWQgbW9kdWxlcyBu
ZWVkZWQgdG8gbW91bnQgdGhlICJyZWFsIiByb290IGZpbGUgc3lzdGVtLAorCSAgZXRjLiBT
ZWUgPGZpbGU6RG9jdW1lbnRhdGlvbi9pbml0cmQudHh0PiBmb3IgZGV0YWlscy4KKworCSAg
SWYgUkFNIGRpc2sgc3VwcG9ydCAoQkxLX0RFVl9SQU0pIGlzIGFsc28gaW5jbHVkZWQsIHRo
aXMKKwkgIGFsc28gZW5hYmxlcyBpbml0aWFsIFJBTSBkaXNrIChpbml0cmQpIHN1cHBvcnQu
CiAKIAogY29uZmlnIENEUk9NX1BLVENEVkQK
--------------090905070509040804050809--
