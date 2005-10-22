Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751298AbVJVJPd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbVJVJPd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Oct 2005 05:15:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751319AbVJVJPd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Oct 2005 05:15:33 -0400
Received: from smtp05.wanadoo.nl ([194.134.35.145]:24869 "EHLO
	smtp05.wanadoo.nl") by vger.kernel.org with ESMTP id S1751298AbVJVJPc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Oct 2005 05:15:32 -0400
Message-ID: <435A032C.7070302@lazarenko.net>
Date: Sat, 22 Oct 2005 11:15:24 +0200
From: Vladimir Lazarenko <vlad@lazarenko.net>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Marc Perkel <marc@perkel.com>, linux-kernel@vger.kernel.org
Subject: Re: sata_nv + SMP = broken?
References: <4358C417.9000608@lazarenko.net> <4359144F.8090504@perkel.com> <200510212238.25614.rjw@sisk.pl>
In-Reply-To: <200510212238.25614.rjw@sisk.pl>
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms020301090606050006080102"
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "dinosaur.lazarenko.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  >>>Yesterday I've tried launching various kernels on
	Ahtlon64 Dual-core >>>X2 3800+ with MSI Neo4 Platinum SLI motherboard.
	>>> >>>The results were a total catastrophica failure. As soon as I
	enable >>>SMP in the kernel, the sata driver would randomly hang after
	a bit of >>>disk activity. >>> >>>Whenever apic is enabled, the system
	won't even be able to boot up >>>completely, and will hang VERY soon.
	Whenever I disable apic, the >>>system is able to bootup, but when the
	software mirror that I use will >>>try to resync for 2-3-10 mins, it
	will throw up a message and freeze >>>again. >>> >>>Whenever I disable
	apic AND lapic, the system is able to bootup AND >>>work, however after
	same 5-10 minutes it start spitting messages, >>>which are somewhat
	different thou and don't hang the system completely >>>but render it
	rather unusable anyway. >>> >>>As soon as I disable SMP - everything
	works like a charm. >>> >>I too am running an Athlon X2 using sata_nv.
	I have an ASUS motherboard. >>But what I noticed was that the problem
	went away if I used 2 gigs of >>ram instead of 4 gigs. When you use the
	whole 4 gigs there is some >>memory mapping going on and I thought
	perhaps the problem was related to >>the sata_nv not liking the memory
	mapped over the 4gig barrier. > > That's possible. Unfortunately I
	cannot verify this, since there are 2GB of > RAM in my box. > > I
	remeber someone having a problem with sata_nv DMAing over 2GB of RAM, >
	so there may be something wrong with it. [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 AWL                    AWL: From: address is in the auto white-list
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms020301090606050006080102
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

>>>Yesterday I've tried launching various kernels on Ahtlon64 Dual-core 
>>>X2 3800+ with MSI Neo4 Platinum SLI motherboard.
>>>
>>>The results were a total catastrophica failure. As soon as I enable 
>>>SMP in the kernel, the sata driver would randomly hang after a bit of 
>>>disk activity.
>>>
>>>Whenever apic is enabled, the system won't even be able to boot up 
>>>completely, and will hang VERY soon. Whenever I disable apic, the 
>>>system is able to bootup, but when the software mirror that I use will 
>>>try to resync for 2-3-10 mins, it will throw up a message and freeze 
>>>again.
>>>
>>>Whenever I disable apic AND lapic, the system is able to bootup AND 
>>>work, however after same 5-10 minutes it start spitting messages, 
>>>which are somewhat different thou and don't hang the system completely 
>>>but render it rather unusable anyway.
>>>
>>>As soon as I disable SMP - everything works like a charm.
>>>
>>I too am running an Athlon X2 using sata_nv. I have an ASUS motherboard. 
>>But what I noticed was that the problem went away if I used 2 gigs of 
>>ram instead of 4 gigs. When you use the whole 4 gigs there is some 
>>memory mapping going on and I thought perhaps the problem was related to 
>>the sata_nv not liking the memory mapped over the 4gig barrier.
> 
> That's possible.  Unfortunately I cannot verify this, since there are 2GB of
> RAM in my box.
> 
> I remeber someone having a problem with sata_nv DMAing over 2GB of RAM,
> so there may be something wrong with it.

On a second thought. Why would that only occur in SMP mode? Since now 
the box is with 3G ram, no SMP and it works like a charm. If I enable 
SMP - the hell breaks loose.

Anyone from the IDE drivers guru world has any ideas? :)

Regards,
Vladimir

--------------ms020301090606050006080102
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIJ2zCC
Az8wggKooAMCAQICAQ0wDQYJKoZIhvcNAQEFBQAwgdExCzAJBgNVBAYTAlpBMRUwEwYDVQQI
EwxXZXN0ZXJuIENhcGUxEjAQBgNVBAcTCUNhcGUgVG93bjEaMBgGA1UEChMRVGhhd3RlIENv
bnN1bHRpbmcxKDAmBgNVBAsTH0NlcnRpZmljYXRpb24gU2VydmljZXMgRGl2aXNpb24xJDAi
BgNVBAMTG1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBDQTErMCkGCSqGSIb3DQEJARYccGVy
c29uYWwtZnJlZW1haWxAdGhhd3RlLmNvbTAeFw0wMzA3MTcwMDAwMDBaFw0xMzA3MTYyMzU5
NTlaMGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBM
dGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQTCBnzAN
BgkqhkiG9w0BAQEFAAOBjQAwgYkCgYEAxKY8VXNV+065yplaHmjAdQRwnd/p/6Me7L3N9Vvy
Gna9fww6YfK/Uc4B1OVQCjDXAmNaLIkVcI7dyfArhVqqP3FWy688Cwfn8R+RNiQqE88r1fOC
dz0Dviv+uxg+B79AgAJk16emu59l0cUqVIUPSAR/p7bRPGEEQB5kGXJgt/sCAwEAAaOBlDCB
kTASBgNVHRMBAf8ECDAGAQH/AgEAMEMGA1UdHwQ8MDowOKA2oDSGMmh0dHA6Ly9jcmwudGhh
d3RlLmNvbS9UaGF3dGVQZXJzb25hbEZyZWVtYWlsQ0EuY3JsMAsGA1UdDwQEAwIBBjApBgNV
HREEIjAgpB4wHDEaMBgGA1UEAxMRUHJpdmF0ZUxhYmVsMi0xMzgwDQYJKoZIhvcNAQEFBQAD
gYEASIzRUIPqCy7MDaNmrGcPf6+svsIXoUOWlJ1/TCG4+DYfqi2fNi/A9BxQIJNwPP2t4WFi
w9k6GX6EsZkbAMUaC4J0niVQlGLH2ydxVyWN3amcOY6MIE9lX5Xa9/eH1sYITq726jTlEBpb
NU1341YheILcIRk13iSx0x1G/11fZU8wggNIMIICsaADAgECAgMPl0owDQYJKoZIhvcNAQEE
BQAwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0
ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBMB4XDTA1
MTAwNDE4Mjk1NloXDTA2MTAwNDE4Mjk1NlowgZgxEjAQBgNVBAQTCUxhemFyZW5rbzERMA8G
A1UEKhMIVmxhZGltaXIxGzAZBgNVBAMTElZsYWRpbWlyIExhemFyZW5rbzEhMB8GCSqGSIb3
DQEJARYSdmxhZEBsYXphcmVua28ubmV0MS8wLQYJKoZIhvcNAQkBFiB2bGFkaW1pci5sYXph
cmVua29AbG9naWNhY21nLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMhN
65wBwy12UD+rjqjhBDMm8/6sYE+YHQmJMgTb/Cxy+Sp00ISDel7/FiLvVtKAo667N43VeFzT
p+7BWKxC0OJAFddayiWFw5sZCEL28qY2lHnolrpJMbVIzUoqrSkPjgZ9GNI93Ri7AWkMCF9X
uRFW0I0Lbb2gYH2fnpdloO917DLyXVuBxOyPUpu1TeP+oHbi8whPdrhFx8Ep37sP13srk5tf
ISzaXdJzEVWOaLTyIL5tMSlCuBJibmcDm9/2qCLW+c1eAxiQwmafH4tJ5WPch2wclEXlt7tw
tGe6vK0Se2B8TvgZmOaY78wIp0DBVrP4+wsMnCbcPHtk+sY1d/8CAwEAAaNRME8wPwYDVR0R
BDgwNoESdmxhZEBsYXphcmVua28ubmV0gSB2bGFkaW1pci5sYXphcmVua29AbG9naWNhY21n
LmNvbTAMBgNVHRMBAf8EAjAAMA0GCSqGSIb3DQEBBAUAA4GBACfGbOm/RbyWFmOR+w4Vk8XY
umCjlfqb+icqbKENKvuG4DOQr6QaTtRT+/ATA3yrooYfQWuflDIEPS+SbNyjfpNyyFiYB8OS
rfclJ+B+ikvEP7LweNoL3EV1SrzeyJ3YrcqHAhoNqvB66dVQCy04RFvaRI+fC3I79Zd748gf
ESqyMIIDSDCCArGgAwIBAgIDD5dKMA0GCSqGSIb3DQEBBAUAMGIxCzAJBgNVBAYTAlpBMSUw
IwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUg
UGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQTAeFw0wNTEwMDQxODI5NTZaFw0wNjEwMDQx
ODI5NTZaMIGYMRIwEAYDVQQEEwlMYXphcmVua28xETAPBgNVBCoTCFZsYWRpbWlyMRswGQYD
VQQDExJWbGFkaW1pciBMYXphcmVua28xITAfBgkqhkiG9w0BCQEWEnZsYWRAbGF6YXJlbmtv
Lm5ldDEvMC0GCSqGSIb3DQEJARYgdmxhZGltaXIubGF6YXJlbmtvQGxvZ2ljYWNtZy5jb20w
ggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDITeucAcMtdlA/q46o4QQzJvP+rGBP
mB0JiTIE2/wscvkqdNCEg3pe/xYi71bSgKOuuzeN1Xhc06fuwVisQtDiQBXXWsolhcObGQhC
9vKmNpR56Ja6STG1SM1KKq0pD44GfRjSPd0YuwFpDAhfV7kRVtCNC229oGB9n56XZaDvdewy
8l1bgcTsj1KbtU3j/qB24vMIT3a4RcfBKd+7D9d7K5ObXyEs2l3ScxFVjmi08iC+bTEpQrgS
Ym5nA5vf9qgi1vnNXgMYkMJmnx+LSeVj3IdsHJRF5be7cLRnurytEntgfE74GZjmmO/MCKdA
wVaz+PsLDJwm3Dx7ZPrGNXf/AgMBAAGjUTBPMD8GA1UdEQQ4MDaBEnZsYWRAbGF6YXJlbmtv
Lm5ldIEgdmxhZGltaXIubGF6YXJlbmtvQGxvZ2ljYWNtZy5jb20wDAYDVR0TAQH/BAIwADAN
BgkqhkiG9w0BAQQFAAOBgQAnxmzpv0W8lhZjkfsOFZPF2Lpgo5X6m/onKmyhDSr7huAzkK+k
Gk7UU/vwEwN8q6KGH0Frn5QyBD0vkmzco36TcshYmAfDkq33JSfgfopLxD+y8HjaC9xFdUq8
3sid2K3KhwIaDarweunVUAstOERb2kSPnwtyO/WXe+PIHxEqsjGCAzswggM3AgEBMGkwYjEL
MAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAq
BgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBAgMPl0owCQYFKw4D
AhoFAKCCAacwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMDUx
MDIyMDkxNTI0WjAjBgkqhkiG9w0BCQQxFgQUwD5ZaZOWe7+S08PDFYO89tAJqbEwUgYJKoZI
hvcNAQkPMUUwQzAKBggqhkiG9w0DBzAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwICAUAw
BwYFKw4DAgcwDQYIKoZIhvcNAwICASgweAYJKwYBBAGCNxAEMWswaTBiMQswCQYDVQQGEwJa
QTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhh
d3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0ECAw+XSjB6BgsqhkiG9w0BCRACCzFr
oGkwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0
ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBAgMPl0ow
DQYJKoZIhvcNAQEBBQAEggEAeVuPHci7+nxKHAkUzeXoQQwqe1X/DQDimMwAP3mseQgkfE7g
iL72bvczzWPHyTvSScQbB1Ome2hWsYdE0dJHmlyCpEpjW9jp2NFbi6xOW9b4+ac5neTX6uZL
NtEPrmA5LVCO43fRSXmJtrxcHTqi5zNy32DfjFvKzTlVVHP45vyKT+Aw9n+rdWPuh/jvQFp3
3OKxZwwQsKGDISYzvtFwP8iQ6piZ6wB6hhOVEv3sS7bTtVEjxPvWnX0xn8Yco2Ed1XvUOtvG
xUKHjU3RUQrPBvDRp3UQ9MPBxNP7L+xWd1L6858Mh3w93gYYi8rG9in2XNHhbGmlWXsYFuoA
Ef+q1gAAAAAAAA==
--------------ms020301090606050006080102--

