Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751850AbWG0BfV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751850AbWG0BfV (ORCPT <rfc822;akpm@zip.com.au>);
	Wed, 26 Jul 2006 21:35:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750867AbWG0BfV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 21:35:21 -0400
Received: from smtp1.netcabo.pt ([212.113.174.28]:35454 "EHLO
	exch01smtp10.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S1750773AbWG0BfU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 21:35:20 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Aa4HAO+0x0SBT4dHgTEB
X-Antivirus-bastov-Mail-From: sergio@sergiomb.no-ip.org via bastov.localdomain
X-Antivirus-bastov: 1.25-st-qms (Clear:RC:0(213.22.17.217):SA:1(10.3/5.0):. Processed in 1.735574 secs Process 3636)
Subject: Re: VIA x86-64 bootlogs needed
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Reply-To: sergio@sergiomb.no-ip.org
To: Andi Kleen <ak@suse.de>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200607270333.38873.ak@suse.de>
References: <200607251824.30504.ak@suse.de>
	 <1153916787.29975.12.camel@bastov.localdomain>
	 <200607270333.38873.ak@suse.de>
Content-Type: multipart/signed; micalg=sha1; protocol="application/x-pkcs7-signature"; boundary="=-4VNATUaS7a3rfU8vy+nL"
Date: Thu, 27 Jul 2006 02:35:16 +0100
Message-Id: <1153964116.2865.15.camel@localhost.portugal>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
X-OriginalArrivalTime: 27 Jul 2006 01:35:19.0618 (UTC) FILETIME=[EB93F220:01C6B11C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-4VNATUaS7a3rfU8vy+nL
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

dmesg | grep -i lost
Bootdata ok (command line is ro root=3DLABEL=3D/1 report_lost_ticks notsc
apic=3Dverbose)
Kernel command line: ro root=3DLABEL=3D/1 report_lost_ticks notsc
apic=3Dverbose
time.c: Lost 576 timer tick(s)! rip console_init+0x0/0x2e)
time.c: Lost 2 timer tick(s)! rip release_console_sem+0x185/0x201)
time.c: Lost 9 timer tick(s)! rip setup_boot_APIC_clock+0x11f/0x121)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x48/0xca)



On Thu, 2006-07-27 at 03:33 +0200, Andi Kleen wrote:
> On Wednesday 26 July 2006 14:26, Sergio Monteiro Basto wrote:
> > This APIC rework have the goal of resolve problem with lost tickets ?
>=20
> What is a lost ticket?=20
>=20
> But unlikely. In fact it only cleans up some code.
>=20
> -Andi

--=-4VNATUaS7a3rfU8vy+nL
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
SIb3DQEJBTEPFw0wNjA3MjcwMTM1MTZaMCMGCSqGSIb3DQEJBDEWBBRAZaJgNVcQ0w3ZFTZKYBEY
FC+8/jANBgkqhkiG9w0BAQEFAASCAQA+Ynu9Vem0ymnQRcfGtAvXWtx0WmxJY/GqTzp/DyNtWg3C
ZfVgWf1AJE3Z7ey9k1j3ADMQAwSYPyhwL9uVT3qXSBzTgnprB4N64qTbwgUXv9FFoZWVe3GT2FEB
NivU3Aczmy2c+LWcAV9XCyz/j4Y6oYcCBjAFanMW94h7szx7DJKhWIqXqa1fR8DqxQQgfHHezqNF
olAAFyK5pwUBbvl9b/a8mllWfEvFrxVe288BLdBpwJ6Hv3/IVhRhmrh5JtnD34fcyQJuniHSEqsC
2amLnKfoxap6XrrM3B2xLIPdVUAiMOrXL8dMpg3zWKCJY4veJdTrIspEttO7tjbMw/XYAAAAAAAA



--=-4VNATUaS7a3rfU8vy+nL--
