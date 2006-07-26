Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1161011AbWGZWOS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161011AbWGZWOS (ORCPT <rfc822;akpm@zip.com.au>);
	Wed, 26 Jul 2006 18:14:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161009AbWGZWOS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 18:14:18 -0400
Received: from smtp2.netcabo.pt ([212.113.174.29]:60108 "EHLO
	exch01smtp09.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S1161006AbWGZWOP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 18:14:15 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Aa4HACqEx0SBT4dHgTIB
X-Antivirus-bastov-Mail-From: sergio@sergiomb.no-ip.org via bastov.localdomain
X-Antivirus-bastov: 1.25-st-qms (Clear:RC:0(213.22.17.217):SA:1(10.3/5.0):. Processed in 6.105845 secs Process 789)
Subject: Re: [PATCH] Add SATA device to VIA IRQ quirk fixup list
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Reply-To: sergio@sergiomb.no-ip.org
To: Daniel Drake <dsd@gentoo.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
        Chris Wedgwood <cw@f00f.org>, greg@kroah.com, jeff@garzik.org,
        harmon@ksu.edu, linux-kernel@vger.kernel.org
In-Reply-To: <44C77CA6.2050807@gentoo.org>
References: <20060714095233.5678A8B6253@zog.reactivated.net>
	 <44B77B1A.6060502@garzik.org> <44B78294.1070308@gentoo.org>
	 <44B78538.6030909@garzik.org> <20060714074305.1248b98e.akpm@osdl.org>
	 <44BA48A0.2060008@gentoo.org> <20060716183126.GB4483@kroah.com>
	 <20060717003418.GA27166@tuatara.stupidest.org>
	 <20060724214046.1c1b646e.akpm@osdl.org>
	 <1153874577.7559.36.camel@localhost>
	 <1153917954.29975.22.camel@bastov.localdomain>
	 <44C77544.1050205@gentoo.org>
	 <1153922774.4486.7.camel@localhost.localdomain>
	 <44C77CA6.2050807@gentoo.org>
Content-Type: multipart/signed; micalg=sha1; protocol="application/x-pkcs7-signature"; boundary="=-ge8HLGZw5W7AcQYCfhge"
Date: Wed, 26 Jul 2006 23:14:03 +0100
Message-Id: <1153952043.6103.6.camel@localhost.portugal>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
X-OriginalArrivalTime: 26 Jul 2006 22:14:14.0131 (UTC) FILETIME=[D3FCBC30:01C6B100]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ge8HLGZw5W7AcQYCfhge
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-07-26 at 15:31 +0100, Daniel Drake wrote:
> >> http://bugs.gentoo.org/138036
> >> http://bugs.gentoo.org/141082
>=20

http://files.haeckser.net/bugs.gentoo.org/dmesg/dmesg-2.6.16-gentoo-r6.txt
you got "No local APIC present or hardware disabled" and no more
messages about lapic or IO-APIC.
http://files.haeckser.net/bugs.gentoo.org/dmesg/dmesg-acpi-off.txt
you got "No local APIC present or hardware disabled"

so you got yours system is in XT-PIC mode, and therefore you need quirk
VIA PCI s , my rule still correct.=20
--=20
S=E9rgio M. B.

--=-ge8HLGZw5W7AcQYCfhge
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
SIb3DQEJBTEPFw0wNjA3MjYyMjEzNTlaMCMGCSqGSIb3DQEJBDEWBBRqGhEbG7qcdp5Qz3ju+vBH
jFZrVzANBgkqhkiG9w0BAQEFAASCAQADD3U470a1Y/zxGA3+9bKGNwDZCcrM4AmnHNYQ1faLjmEh
XYFtVfjFI4varFrU1li4504EnAT9tKyxXG3TcItWj+aLiZZLkYzeIyFHOUY0jHt9iJwpwNNGhtC5
2yZMrZCL+RG47M88Q5KtKEBoaNjXnqvIrL0b8nYECCEJQAYMJsOVbDHOqB7HHnSje1EvWwp9GMt8
5e+66uYtxdessqNA1dNXIcpNzqmKP6E3PHlK9nkzWDouEEzEqUuJAajyvkq+PCw4D1hJN01blZXN
dvvUfZJ/JIs3zFEUWtHZStQZcpJgQJY8y7laaMcqjBJWYRimvnD+4V6f7woGkjVQ+d+LAAAAAAAA



--=-ge8HLGZw5W7AcQYCfhge--
