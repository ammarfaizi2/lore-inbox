Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261685AbUGEWU7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261685AbUGEWU7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 18:20:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261763AbUGEWU6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 18:20:58 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:33172 "EHLO
	fmmailgate03.web.de") by vger.kernel.org with ESMTP id S261685AbUGEWU4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 18:20:56 -0400
Date: Tue, 06 Jul 2004 00:20:51 +0200
Message-Id: <971519831@web.de>
MIME-Version: 1.0
From: "Michael Thonke" <TK-SHOCKWAVE@web.de>
To: linux-kernel@vger.kernel.org
Subject: Disabled SATA (ICH5R) support cause hard seeks to disks and APIC errors on i875P chipset
Organization: http://freemail.web.de/
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="---SKER1089066055--";
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is MIME

-----SKER1089066055--
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

So a nother question accodring APIC and SATA on a Pentium 4 HT enabled and Intel 875P Chipset

Maybe Jeff Garzik or Andrew can answer it..

Since 2.6.4-mm* I get wired problemes when I disable the SATA Drive for the Intel ICH5R Controller on a Abit-IC7 Mainboard. I want to use the normal Intel IDE driver. But when I diasbled it in kernel + recompile and reboot the machine my harddrives make hard seeks and fancy noises also I get APIC error on CPU0 without any hints or oops and few minutes later after using the machine it freezes the harddisk (maybe power off,I noticed it on reset that the disks power on with SATA support it does not appear). If the SATA driver under SCSI is turned on no problems.
________________________________________________________________
Verschicken Sie romantische, coole und witzige Bilder per SMS!
Jetzt neu bei WEB.DE FreeMail: http://freemail.web.de/?mc=021193
-----SKER1089066055--
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIFnAYJKoZIhvcNAQcCoIIFjTCCBYkCAQExCzAJBgUrDgMCGgUAMAsGCSqGSIb3
DQEHAaCCA/gwggP0MIIC3KADAgECAgQCWmg9MA0GCSqGSIb3DQEBBAUAMIGgMQsw
CQYDVQQGEwJERTESMBAGA1UEChMJV0VCLkRFIEFHMRUwEwYDVQQLEwxUcnVzdCBD
ZW50ZXIxGjAYBgNVBAcTEUQtNzYyMjcgS2FybHNydWhlMS0wKwYDVQQDEyRXRUIu
REUgVHJ1c3RDZW50ZXIgRU1haWwtWmVydGlmaWthdGUxGzAZBgkqhkiG9w0BCQEW
DHRydXN0QHdlYi5kZTAeFw0wNDAzMjUyMDA4MTdaFw0wNTAzMjUyMDA4MTdaMHgx
CzAJBgNVBAYTAkRFMRQwEgYDVQQIEwtEZXV0c2NobGFuZDEWMBQGA1UEBxMNMzc1
NzQgRWluYmVjazEXMBUGA1UEAxMOTWljaGFlbCBUaG9ua2UxIjAgBgkqhkiG9w0B
CQEWE3RrLXNob2Nrd2F2ZUB3ZWIuZGUwgZ8wDQYJKoZIhvcNAQEBBQADgY0AMIGJ
AoGBAMg4IXsINDZoD1rOvKsOxlh5+HOv+TwvVRclmVermVUViuP4JBJIXhk3G+6n
/Zo9gCG0McI/oOxWNCDTQ++b6Nl0orJKhTj18CE1aa2wSdAupw8lwnpIPiP3yyhL
A8567M33Y+sMD1RiO25ayqRX+qekYgDZ75Zut1VDurkEyFYZAgMBAAGjgeAwgd0w
LAYJYIZIAYb4QgEEBB8WHWh0dHBzOi8vdHJ1c3Qud2ViLmRlL3J2Q0EvP3M9MCMG
CWCGSAGG+EIBAgQWFhRodHRwczovL3RydXN0LndlYi5kZTAWBglghkgBhvhCAQME
CRYHL3J2Lz9zPTAWBglghkgBhvhCAQcECRYHL3JuLz9zPTAaBglghkgBhvhCAQgE
DRYLL0hpbGZlL0FHQi8wKQYJYIZIAYb4QgENBBwWGkZyZWVtYWlsIEVtYWlsIGNl
cnRpZmljYXRlMBEGCWCGSAGG+EIBAQQEAwIAsDANBgkqhkiG9w0BAQQFAAOCAQEA
qKB0cBp4MDMrBWKqEZ+xHq406LxR5tJxkDIHpIJ1PFVreFeO0HjN+MWLgW+XS/BJ
se07Db39h6egmAALvcrDZnJVs93ynAkBZCNU3zxACgViPGTO1ajxXqaLte0FbOfV
EOJH3f9BX931HqbbngXMd7PXhhUo9yUR5/knus4QYbMkBRPjb/Mb1XL++doqM9qg
Mh8goWSZfXwH0OZhVGqS4zjtkZpGR9Okg8wontgnuaCJeW0j8Tu5hNeHxg0NYe1f
hvH6mmx/HNhfufsZjMM/y9XKias0/Gincc/JLUYs5r9U+B4xbMShQT3FIpukN/5b
PcDcX74ocMSqgzQBKCdZvzGCAWwwggFoAgEBMIGpMIGgMQswCQYDVQQGEwJERTES
MBAGA1UEChMJV0VCLkRFIEFHMRUwEwYDVQQLEwxUcnVzdCBDZW50ZXIxGjAYBgNV
BAcTEUQtNzYyMjcgS2FybHNydWhlMS0wKwYDVQQDEyRXRUIuREUgVHJ1c3RDZW50
ZXIgRU1haWwtWmVydGlmaWthdGUxGzAZBgkqhkiG9w0BCQEWDHRydXN0QHdlYi5k
ZQIEAlpoPTAJBgUrDgMCGgUAMA0GCSqGSIb3DQEBAQUABIGAhkPDKtpM8o3u4PiS
ymIpfty9vWk4ThsVjsdFINEkiiN5/FvnfcYdXcfyXqO1nJTOdHB/iC+g/cQxMHS2
KFkjMmhNnkyzQ7tcTNUuYv1yY3+mphsj+PE//DOJSJxZVaFR3+X5FHdFhneazjFW
tx9yo/VTGXh0Ik/3G1lvqXoqlBahGjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
-----SKER1089066055----

