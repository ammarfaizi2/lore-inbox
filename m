Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130913AbQKRH5a>; Sat, 18 Nov 2000 02:57:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131350AbQKRH5U>; Sat, 18 Nov 2000 02:57:20 -0500
Received: from site3.talontech.com ([208.179.68.88]:17231 "EHLO
	site3.talontech.com") by vger.kernel.org with ESMTP
	id <S130913AbQKRH5E>; Sat, 18 Nov 2000 02:57:04 -0500
Message-ID: <3A162EFE.A980A941@talontech.com>
Date: Fri, 17 Nov 2000 23:25:50 -0800
From: Ben Ford <bford@talontech.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Greg KH <greg@wirex.com>
CC: David Ford <david@linux.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: test11-pre6 still very broken
In-Reply-To: <Pine.LNX.4.21.0011171935560.1796-100000@saturn.homenet> <8v4306$sga$1@cesium.transmeta.com> <3A161337.6A1BE826@linux.com> <20001117223137.A26341@wirex.com>
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms51016ADCEAC1C80A53E0C31E"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms51016ADCEAC1C80A53E0C31E
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Here is lspci output from the laptop in question.  Is this not UHCI?

[ben@Juanita ben]$ /sbin/lspci
00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge (rev 03)
00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge (rev 03)
00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 03)
00:09.0 Communication controller: Lucent Microelectronics 56k WinModem (rev 01)
00:0a.0 CardBus bridge: Texas Instruments: Unknown device ac50 (rev 01)
00:11.0 Multimedia audio controller: ESS Technology ES1969 Solo-1 Audiodrive (rev
02)
00:12.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 08)
01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage P/M Mobility AGP
2x (rev 64)

The machine hangs on warm reboot almost every time.  On cold boot, it never has
the problem.

-b



Greg KH wrote:

> On Fri, Nov 17, 2000 at 09:27:19PM -0800, David Ford wrote:
> >
> > The second issue is usb.  I now have two machines that lockup on boot in USB.
> > One is the above workstation, the second is a Compaq laptop.  Unfortunately
> > I have no way of unplugging the USB hardware inside the laptop :P
>
> Can't you not compile in the UHCI driver?  Actually, it seems odd that a
> Compaq laptop would have a uhci driver, as Compaq was one of the OHCI
> creators...
>
> greg k-h
>
> --
> greg@(kroah|wirex).com
> http://immunix.org/~greg
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

--------------ms51016ADCEAC1C80A53E0C31E
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIKNAYJKoZIhvcNAQcCoIIKJTCCCiECAQExCzAJBgUrDgMCGgUAMAsGCSqGSIb3DQEHAaCC
B8AwggSKMIID86ADAgECAhBKZM7P0GbD5FAYmBQMmrtPMA0GCSqGSIb3DQEBBAUAMIHMMRcw
FQYDVQQKEw5WZXJpU2lnbiwgSW5jLjEfMB0GA1UECxMWVmVyaVNpZ24gVHJ1c3QgTmV0d29y
azFGMEQGA1UECxM9d3d3LnZlcmlzaWduLmNvbS9yZXBvc2l0b3J5L1JQQSBJbmNvcnAuIEJ5
IFJlZi4sTElBQi5MVEQoYyk5ODFIMEYGA1UEAxM/VmVyaVNpZ24gQ2xhc3MgMSBDQSBJbmRp
dmlkdWFsIFN1YnNjcmliZXItUGVyc29uYSBOb3QgVmFsaWRhdGVkMB4XDTAwMDcyNTAwMDAw
MFoXDTAxMDcyNTIzNTk1OVowggEOMRcwFQYDVQQKEw5WZXJpU2lnbiwgSW5jLjEfMB0GA1UE
CxMWVmVyaVNpZ24gVHJ1c3QgTmV0d29yazFGMEQGA1UECxM9d3d3LnZlcmlzaWduLmNvbS9y
ZXBvc2l0b3J5L1JQQSBJbmNvcnAuIGJ5IFJlZi4sTElBQi5MVEQoYyk5ODEeMBwGA1UECxMV
UGVyc29uYSBOb3QgVmFsaWRhdGVkMTMwMQYDVQQLEypEaWdpdGFsIElEIENsYXNzIDEgLSBO
ZXRzY2FwZSBGdWxsIFNlcnZpY2UxETAPBgNVBAMUCEJlbiBGb3JkMSIwIAYJKoZIhvcNAQkB
FhNiZm9yZEB0YWxvbnRlY2guY29tMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDB6vi3
0ExuXwUdcORfjBSBNbbkN9T4PHvwDiKhrFofDSjN9HkSCdIRZtje4876/9M7dRaL66v48yxx
/ntmF1ppsZNGfcgNPAE8SZ5bp5KHUXcv44PKq6fVs5L2v90zUDPMuk0vkOrt1RNcWzZzHH2j
QXH0rui9gjShPlRKqzkYKwIDAQABo4IBJjCCASIwCQYDVR0TBAIwADBEBgNVHSAEPTA7MDkG
C2CGSAGG+EUBBwEIMCowKAYIKwYBBQUHAgEWHGh0dHBzOi8vd3d3LnZlcmlzaWduLmNvbS9y
cGEwEQYJYIZIAYb4QgEBBAQDAgeAMIGGBgpghkgBhvhFAQYDBHgWdmQ0NjUyYmQ2M2YyMDQ3
MDI5Mjk4NzYzYzlkMmYyNzUwNjljNzM1OWJlZDFiMDU5ZGE3NWJjNGJjOTcwMTc0N2RhNWQz
ZjIxNDFiZWFkYjJiZDJlODkyMWZhZjZjZjFkMzExNDk5N2EzYmU0NWZiZjNlYTQ1NmIwMwYD
VR0fBCwwKjAooCagJIYiaHR0cDovL2NybC52ZXJpc2lnbi5jb20vY2xhc3MxLmNybDANBgkq
hkiG9w0BAQQFAAOBgQCz2fOFUVKhdibMfpsSDUy1zB8tk699wGStLGZVqXy8dViOugjbySoK
oCrehJ5xIRTzNzThGa1DAxoOCnNAqu78f7Dj/o/ImmqVtQpL9q6FM0JcEI+/SvclDRUMcY1u
QHb1WEffOjW5W95lSpBTNOPzba8fAMa1ULfic1qN5NLUqTCCAy4wggKXoAMCAQICEQDSdi6N
FAw9fbKoJV2v7g11MA0GCSqGSIb3DQEBAgUAMF8xCzAJBgNVBAYTAlVTMRcwFQYDVQQKEw5W
ZXJpU2lnbiwgSW5jLjE3MDUGA1UECxMuQ2xhc3MgMSBQdWJsaWMgUHJpbWFyeSBDZXJ0aWZp
Y2F0aW9uIEF1dGhvcml0eTAeFw05ODA1MTIwMDAwMDBaFw0wODA1MTIyMzU5NTlaMIHMMRcw
FQYDVQQKEw5WZXJpU2lnbiwgSW5jLjEfMB0GA1UECxMWVmVyaVNpZ24gVHJ1c3QgTmV0d29y
azFGMEQGA1UECxM9d3d3LnZlcmlzaWduLmNvbS9yZXBvc2l0b3J5L1JQQSBJbmNvcnAuIEJ5
IFJlZi4sTElBQi5MVEQoYyk5ODFIMEYGA1UEAxM/VmVyaVNpZ24gQ2xhc3MgMSBDQSBJbmRp
dmlkdWFsIFN1YnNjcmliZXItUGVyc29uYSBOb3QgVmFsaWRhdGVkMIGfMA0GCSqGSIb3DQEB
AQUAA4GNADCBiQKBgQC7WkSKBBa7Vf0DeootlE8VeDa4DUqyb5xUv7zodyqdufBou5XZMUFw
eoFLuUgTVi3HCOGEQqvAopKrRFyqQvCCDgLpL/vCO7u+yScKXbawNkIztW5UiE+HSr8Z2vkV
6A+HthzjzMaajn9qJJLj/OBluqexfu/J2zdqyErICQbkmQIDAQABo3wwejARBglghkgBhvhC
AQEEBAMCAQYwRwYDVR0gBEAwPjA8BgtghkgBhvhFAQcBATAtMCsGCCsGAQUFBwIBFh93d3cu
dmVyaXNpZ24uY29tL3JlcG9zaXRvcnkvUlBBMA8GA1UdEwQIMAYBAf8CAQAwCwYDVR0PBAQD
AgEGMA0GCSqGSIb3DQEBAgUAA4GBAIi4Nzvd2pQ3AK2qn+GBAXEekmptL/bxndPKZDjcG5gM
B4ZbhRVqD7lJhaSV8Rd9Z7R/LSzdmkKewz60jqrlCwbe8lYq+jPHvhnXU0zDvcjjF7WkSUJj
7MKmFw9dWBpJPJBcVaNlIAD9GCDlX4KmsaiSxVhqwY0DPOvDzQWikK5uMYICPDCCAjgCAQEw
geEwgcwxFzAVBgNVBAoTDlZlcmlTaWduLCBJbmMuMR8wHQYDVQQLExZWZXJpU2lnbiBUcnVz
dCBOZXR3b3JrMUYwRAYDVQQLEz13d3cudmVyaXNpZ24uY29tL3JlcG9zaXRvcnkvUlBBIElu
Y29ycC4gQnkgUmVmLixMSUFCLkxURChjKTk4MUgwRgYDVQQDEz9WZXJpU2lnbiBDbGFzcyAx
IENBIEluZGl2aWR1YWwgU3Vic2NyaWJlci1QZXJzb25hIE5vdCBWYWxpZGF0ZWQCEEpkzs/Q
ZsPkUBiYFAyau08wCQYFKw4DAhoFAKCBsTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0wMDExMTgwNzI1NTBaMCMGCSqGSIb3DQEJBDEWBBRq0EJO2tupn+C8
LWTBylnljOBN3jBSBgkqhkiG9w0BCQ8xRTBDMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIA
gDAHBgUrDgMCBzANBggqhkiG9w0DAgIBQDANBggqhkiG9w0DAgIBKDANBgkqhkiG9w0BAQEF
AASBgID+wLUMPC23Jq5Jj+lX6XcvQwxY8/qh/qeGtP34GDCycWwMnKGvwgwTDp7HnGWN2n7f
Hi/az9MqwX+gH4FOjoP3R50gSngjiFFN/XWP41R4gdRhqnVVkNeSwTW/C/gjfpGqERBEmkhT
cD7q5llBPctEBy5No2M0C3slVZHbHe4y
--------------ms51016ADCEAC1C80A53E0C31E--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
