Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1161054AbWGMX4F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161054AbWGMX4F (ORCPT <rfc822;akpm@zip.com.au>);
	Thu, 13 Jul 2006 19:56:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161053AbWGMX4F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 19:56:05 -0400
Received: from smtp1.netcabo.pt ([212.113.174.28]:37522 "EHLO
	exch01smtp10.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S1161054AbWGMX4E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 19:56:04 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AXoUABB6tkSBTIc3
X-Antivirus-bastov-Mail-From: sergio@sergiomb.no-ip.org via bastov.localdomain
X-Antivirus-bastov: 1.25-st-qms (Clear:RC:0(213.22.17.20):SA:1(8.7/5.0):. Processed in 4.989168 secs Process 6629)
Subject: uhci_hcd 0000:00:10.1: host controller process error, something
	bad happened!
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Reply-To: sergio@sergiomb.no-ip.org
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=sha1; protocol="application/x-pkcs7-signature"; boundary="=-Lh3uc20i69zY6NGJIgVz"
Date: Fri, 14 Jul 2006 00:55:55 +0100
Message-Id: <1152834955.7064.14.camel@localhost.portugal>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
X-OriginalArrivalTime: 13 Jul 2006 23:56:02.0825 (UTC) FILETIME=[E5AEB790:01C6A6D7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Lh3uc20i69zY6NGJIgVz
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi  here it is the results with kernel 2.6.18-rc1-gitx,
Its better, don't oops.=20
My system is described on
http://bugme.osdl.org/show_bug.cgi?id=3D6419
I will upload dmesg there .

I experience this, just making a little stress (with bittorrent) on my
usb cable modem, which works by default, and _not_ loading nvidia and
via_rhine Ethernet kernel modules.

Any suggestions or patch that I can try ?=20

Thanks=20

Jul 14 00:39:40 localhost kernel: eth1: unregister 'cdc_ether' usb-0000:00:=
10.1-2, CDC Ethernet Device
Jul 14 00:39:40 localhost dhclient: receive_packet failed on eth1: Network =
is down
Jul 14 00:39:51 localhost kernel: uhci_hcd 0000:00:10.3: remove, state 1
Jul 14 00:39:51 localhost kernel: usb usb4: USB disconnect, address 1
Jul 14 00:39:51 localhost kernel: uhci_hcd 0000:00:10.3: USB bus 4 deregist=
ered
Jul 14 00:39:51 localhost kernel: uhci_hcd 0000:00:10.2: remove, state 1
Jul 14 00:39:51 localhost kernel: usb usb3: USB disconnect, address 1
Jul 14 00:39:51 localhost kernel: uhci_hcd 0000:00:10.2: USB bus 3 deregist=
ered
Jul 14 00:39:51 localhost kernel: uhci_hcd 0000:00:10.1: remove, state 0
Jul 14 00:39:51 localhost kernel: usb usb2: USB disconnect, address 1
Jul 14 00:39:51 localhost kernel: uhci_hcd 0000:00:10.1: USB bus 2 deregist=
ered
Jul 14 00:39:51 localhost kernel: uhci_hcd 0000:00:10.0: remove, state 1
Jul 14 00:39:51 localhost kernel: usb usb1: USB disconnect, address 1
Jul 14 00:39:51 localhost kernel: uhci_hcd 0000:00:10.0: USB bus 1 deregist=
ered
Jul 14 00:39:51 localhost noip2[2630]: Can't get status for eth1. (19)
Jul 14 00:39:57 localhost kernel: USB Universal Host Controller Interface d=
river v3.0
Jul 14 00:39:57 localhost kernel: ACPI: PCI Interrupt 0000:00:10.0[A] -> GS=
I 21 (level, low) -> IRQ 201
Jul 14 00:39:57 localhost kernel: uhci_hcd 0000:00:10.0: UHCI Host Controll=
er
Jul 14 00:39:57 localhost kernel: uhci_hcd 0000:00:10.0: new USB bus regist=
ered, assigned bus number 1
Jul 14 00:39:57 localhost kernel: uhci_hcd 0000:00:10.0: irq 201, io base 0=
x0000dc00
Jul 14 00:39:57 localhost kernel: usb usb1: configuration #1 chosen from 1 =
choice
Jul 14 00:39:57 localhost kernel: hub 1-0:1.0: USB hub found
Jul 14 00:39:57 localhost kernel: hub 1-0:1.0: 2 ports detected
Jul 14 00:39:57 localhost kernel: ACPI: PCI Interrupt 0000:00:10.1[A] -> GS=
I 21 (level, low) -> IRQ 201
Jul 14 00:39:57 localhost kernel: uhci_hcd 0000:00:10.1: UHCI Host Controll=
er
Jul 14 00:39:57 localhost kernel: uhci_hcd 0000:00:10.1: new USB bus regist=
ered, assigned bus number 2
Jul 14 00:39:57 localhost kernel: uhci_hcd 0000:00:10.1: irq 201, io base 0=
x0000d080
Jul 14 00:39:57 localhost kernel: usb usb2: configuration #1 chosen from 1 =
choice
Jul 14 00:39:57 localhost kernel: hub 2-0:1.0: USB hub found
Jul 14 00:39:57 localhost kernel: hub 2-0:1.0: 2 ports detected
Jul 14 00:39:57 localhost kernel: ACPI: PCI Interrupt 0000:00:10.2[B] -> GS=
I 21 (level, low) -> IRQ 201
Jul 14 00:39:57 localhost kernel: uhci_hcd 0000:00:10.2: UHCI Host Controll=
er
Jul 14 00:39:57 localhost kernel: uhci_hcd 0000:00:10.2: new USB bus regist=
ered, assigned bus number 3
Jul 14 00:39:57 localhost kernel: uhci_hcd 0000:00:10.2: irq 201, io base 0=
x0000d000
Jul 14 00:39:57 localhost kernel: usb usb3: configuration #1 chosen from 1 =
choice
Jul 14 00:39:57 localhost kernel: hub 3-0:1.0: USB hub found
Jul 14 00:39:57 localhost kernel: hub 3-0:1.0: 2 ports detected
Jul 14 00:39:57 localhost kernel: ACPI: PCI Interrupt 0000:00:10.3[B] -> GS=
I 21 (level, low) -> IRQ 201
Jul 14 00:39:57 localhost kernel: uhci_hcd 0000:00:10.3: UHCI Host Controll=
er
Jul 14 00:39:57 localhost kernel: uhci_hcd 0000:00:10.3: new USB bus regist=
ered, assigned bus number 4
Jul 14 00:39:57 localhost kernel: uhci_hcd 0000:00:10.3: irq 201, io base 0=
x0000ef00
Jul 14 00:39:57 localhost kernel: usb usb4: configuration #1 chosen from 1 =
choice
Jul 14 00:39:57 localhost kernel: hub 4-0:1.0: USB hub found
Jul 14 00:39:57 localhost kernel: hub 4-0:1.0: 2 ports detected
Jul 14 00:39:57 localhost kernel: usb 2-2: new full speed USB device using =
uhci_hcd and address 2
Jul 14 00:39:58 localhost kernel: usb 2-2: configuration #1 chosen from 1 c=
hoice
Jul 14 00:39:58 localhost kernel: eth0: register 'cdc_ether' at usb-0000:00=
:10.1-2, CDC Ethernet Device, 00:90:64:fc:ce:2b
Jul 14 00:39:58 localhost kernel: uhci_hcd 0000:00:10.1: host controller pr=
ocess error, something bad happened!
Jul 14 00:39:58 localhost kernel: uhci_hcd 0000:00:10.1: host controller ha=
lted, very bad!
Jul 14 00:39:58 localhost kernel: uhci_hcd 0000:00:10.1: HC died; cleaning =
up

--=-Lh3uc20i69zY6NGJIgVz
Content-Type: application/x-pkcs7-signature; name=smime.p7s
Content-Disposition: attachment; filename=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIGSTCCAwIw
ggJroAMCAQICAw/vkjANBgkqhkiG9w0BAQQFADBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhh
d3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVt
YWlsIElzc3VpbmcgQ0EwHhcNMDUxMTI4MjIyODU2WhcNMDYxMTI4MjIyODU2WjBLMR8wHQYDVQQD
ExZUaGF3dGUgRnJlZW1haWwgTWVtYmVyMSgwJgYJKoZIhvcNAQkBFhlzZXJnaW9Ac2VyZ2lvbWIu
bm8taXAub3JnMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEApCNuKD3pz8GRKd1q+36r
m0z7z+TBsbTrVa45UQsEeh9OQGZIASJMH5erC0u6KbKJ+km97RLOdsgSlKG6+5xuzsk+aqU7A0Gp
kMjzIJT7UH/bbPnIFMQNnWJxluuYq1u+v8iIbfezQy1+SXyAyBv+OC7LnCOiOar/L9AD9zDy2fPX
EqEDlbO3CJsoaR4Va8sgtoV0NmKnAt7DA0iZ2dmlsw6Qh+4euI+FgZ2WHPBQnfJ7PfSH5GIWl/Nx
eUqnYpDaJafk/l94nX71UifdPXDMxJJlEOGqV9l4omhNlPmsZ/zrGXgLdBv9JuPjJ9mxhgwZsZbz
VBc8emB0i3A7E6D6rwIDAQABo1kwVzAOBgNVHQ8BAf8EBAMCBJAwEQYJYIZIAYb4QgEBBAQDAgUg
MCQGA1UdEQQdMBuBGXNlcmdpb0BzZXJnaW9tYi5uby1pcC5vcmcwDAYDVR0TAQH/BAIwADANBgkq
hkiG9w0BAQQFAAOBgQBIVheRn3oHTU5rgIFHcBRxkIhOYPQHKk/oX4KakCrDCxp33XAqTG3aIG/v
dsUT/OuFm5w0GlrUTrPaKYYxxfQ00+3d8y87aX22sUdj8oXJRYiPgQiE6lqu9no8axH6UXCCbKTi
8383JcxReoXyuP000eUggq3tWr6fE/QmONUARzCCAz8wggKooAMCAQICAQ0wDQYJKoZIhvcNAQEF
BQAwgdExCzAJBgNVBAYTAlpBMRUwEwYDVQQIEwxXZXN0ZXJuIENhcGUxEjAQBgNVBAcTCUNhcGUg
VG93bjEaMBgGA1UEChMRVGhhd3RlIENvbnN1bHRpbmcxKDAmBgNVBAsTH0NlcnRpZmljYXRpb24g
U2VydmljZXMgRGl2aXNpb24xJDAiBgNVBAMTG1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBDQTEr
MCkGCSqGSIb3DQEJARYccGVyc29uYWwtZnJlZW1haWxAdGhhd3RlLmNvbTAeFw0wMzA3MTcwMDAw
MDBaFw0xMzA3MTYyMzU5NTlaMGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3Vs
dGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWlu
ZyBDQTCBnzANBgkqhkiG9w0BAQEFAAOBjQAwgYkCgYEAxKY8VXNV+065yplaHmjAdQRwnd/p/6Me
7L3N9VvyGna9fww6YfK/Uc4B1OVQCjDXAmNaLIkVcI7dyfArhVqqP3FWy688Cwfn8R+RNiQqE88r
1fOCdz0Dviv+uxg+B79AgAJk16emu59l0cUqVIUPSAR/p7bRPGEEQB5kGXJgt/sCAwEAAaOBlDCB
kTASBgNVHRMBAf8ECDAGAQH/AgEAMEMGA1UdHwQ8MDowOKA2oDSGMmh0dHA6Ly9jcmwudGhhd3Rl
LmNvbS9UaGF3dGVQZXJzb25hbEZyZWVtYWlsQ0EuY3JsMAsGA1UdDwQEAwIBBjApBgNVHREEIjAg
pB4wHDEaMBgGA1UEAxMRUHJpdmF0ZUxhYmVsMi0xMzgwDQYJKoZIhvcNAQEFBQADgYEASIzRUIPq
Cy7MDaNmrGcPf6+svsIXoUOWlJ1/TCG4+DYfqi2fNi/A9BxQIJNwPP2t4WFiw9k6GX6EsZkbAMUa
C4J0niVQlGLH2ydxVyWN3amcOY6MIE9lX5Xa9/eH1sYITq726jTlEBpbNU1341YheILcIRk13iSx
0x1G/11fZU8xggHvMIIB6wIBATBpMGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29u
c3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNz
dWluZyBDQQIDD++SMAkGBSsOAwIaBQCgXTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqG
SIb3DQEJBTEPFw0wNjA3MTMyMzU1NTFaMCMGCSqGSIb3DQEJBDEWBBRN64IGTUW9GYhmupHraLGj
Z7XqkTANBgkqhkiG9w0BAQEFAASCAQCCCsnCdMA2az0dix1MeyzJxchxdy0z60QF5v1e0+OWOk00
Q1htb3fn+d/Ya4kZ4BxskR/1pHCSg1ApeX1PjbIHhGDTsd6vT0YVLWh6PFId5wmObZf0nVzUDWdQ
ar6x7+qWEDvnDXfkplsnZuzCi+0lj7gETYPZ/SFsx0MTMmQC7ta17SxKYcuIL0nwtZWqjOO2UCVg
/gfux873PKL719yi2Gn4Id82Q69s7atTMYC6E6q1xwhrGcARi6IUmOOAhkodph1bOAHT4wn21X/u
VNOMpbAQrLWbL7mDkd5UXaj+GGz5ClIqZjJ9+Uwbb6cNRgH5JZfTnYCD4HtIFEIXXFxhAAAAAAAA



--=-Lh3uc20i69zY6NGJIgVz--
