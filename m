Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262017AbTEUKrI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 06:47:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262029AbTEUKrI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 06:47:08 -0400
Received: from [195.71.209.2] ([195.71.209.2]:23302 "HELO ns2.ontika.net")
	by vger.kernel.org with SMTP id S262017AbTEUKrG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 06:47:06 -0400
Message-ID: <3ECB5C6B.6020600@ontika.net>
Date: Wed, 21 May 2003 13:00:59 +0200
From: Kai Bankett <chaosman@ontika.net>
Organization: AOL Germany
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: haveblue@us.ibm.com, mbligh@aracnet.com, wli@holomorphy.com,
       arjanv@redhat.com, pbadari@us.ibm.com, linux-kernel@vger.kernel.org,
       gh@us.ibm.com, johnstul@us.ibm.com, jamesclv@us.ibm.com, akpm@digeo.com,
       mannthey@us.ibm.com
Subject: Re: userspace irq balancer
References: <88560000.1053409990@[10.10.2.4]>	<20030519.231319.91314647.davem@redhat.com>	<1053412583.13289.322.camel@nighthawk> <20030519.234055.35511478.davem@redhat.com>
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms080104030103030300020301"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms080104030103030300020301
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

David S. Miller wrote:

>   From: Dave Hansen <haveblue@us.ibm.com>
>   Date: 19 May 2003 23:36:23 -0700
>   
>   I don't even think we can do that.  That code was being integrated
>   around the same time that our Specweb setup decided to go south on us
>   and start physically frying itself.
>
>This gets more amusing by the second.  Let's kill this code
>already.  People who like the current algorithms can push
>them into the userspace solution.
>
>  
>
That´s also my feeling.
After having more and more performance loss (at least for my 
system/usage) and no real good solution in view to fix the problems at 
this location in the kernel, I would prefer to get this thing ripped of 
as soon as possible.
By now I do not see any gain with that piece of code (relative to 
process/interrupt distribution). And please don´t show me benchmarks - I 
know what I feel.
Userland would be first of all the right place to do any further testing.
And please - don´t tell me it´s that complicated to remove this piece of 
code from source tree.

Kai.


--------------ms080104030103030300020301
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIJQDCC
Av4wggJnoAMCAQICAwngETANBgkqhkiG9w0BAQQFADCBkjELMAkGA1UEBhMCWkExFTATBgNV
BAgTDFdlc3Rlcm4gQ2FwZTESMBAGA1UEBxMJQ2FwZSBUb3duMQ8wDQYDVQQKEwZUaGF3dGUx
HTAbBgNVBAsTFENlcnRpZmljYXRlIFNlcnZpY2VzMSgwJgYDVQQDEx9QZXJzb25hbCBGcmVl
bWFpbCBSU0EgMjAwMC44LjMwMB4XDTAzMDUwNTE0NTAyM1oXDTA0MDUwNDE0NTAyM1owQjEf
MB0GA1UEAxMWVGhhd3RlIEZyZWVtYWlsIE1lbWJlcjEfMB0GCSqGSIb3DQEJARYQa2Jhbmtl
dHRAYW9sLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBALMFsOrR2jINM/04
7ut/y2rXUEFIPEfP3WezS5wyz1WXi3LVta3oGZ5VYGstJyCX9BJJob5GhP0MLTyTdthpX+Kf
gEbfuew52WzXY2xgOwoAiEigTyRBIOlTG2xx2y9oT4o3WVnw58MbMTNDWizCiR0TlAZw9V0p
nDqdGOHz6sFCMk3CSsTJOAhvtUjdeFT5D0R8TD5VnLYg4Skpj1qce1RntAgaAzN+8OKB6vf+
xGfmGym/RUhhGXl9b+WR4p1tQbhH/VKhgE4FapXJ/nb5Cxsbf1zBfSh2pTCOHba/Tcqg9+uA
crY1D0mWwhuqPl1umE7kE6XDpmrnR0lMRDz1PKsCAwEAAaMtMCswGwYDVR0RBBQwEoEQa2Jh
bmtldHRAYW9sLmNvbTAMBgNVHRMBAf8EAjAAMA0GCSqGSIb3DQEBBAUAA4GBALBWhbhz5ltx
Rgc3sutBBL+tFB78zt5yR1D4XFRLUKC2amC/znS2cpMYPhidL4zp2QKCStbiVFHfclnhJiVQ
FOZ7qOaAYnQG5jMmryVyrriNW+Xhvowar2Huhh1vxlGP4abrLqC6pw3xZglr/v8R9HRtxYMk
eeG1Pg2D4ghk0ZAKMIIC/jCCAmegAwIBAgIDCeARMA0GCSqGSIb3DQEBBAUAMIGSMQswCQYD
VQQGEwJaQTEVMBMGA1UECBMMV2VzdGVybiBDYXBlMRIwEAYDVQQHEwlDYXBlIFRvd24xDzAN
BgNVBAoTBlRoYXd0ZTEdMBsGA1UECxMUQ2VydGlmaWNhdGUgU2VydmljZXMxKDAmBgNVBAMT
H1BlcnNvbmFsIEZyZWVtYWlsIFJTQSAyMDAwLjguMzAwHhcNMDMwNTA1MTQ1MDIzWhcNMDQw
NTA0MTQ1MDIzWjBCMR8wHQYDVQQDExZUaGF3dGUgRnJlZW1haWwgTWVtYmVyMR8wHQYJKoZI
hvcNAQkBFhBrYmFua2V0dEBhb2wuY29tMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKC
AQEAswWw6tHaMg0z/Tju63/LatdQQUg8R8/dZ7NLnDLPVZeLctW1regZnlVgay0nIJf0Ekmh
vkaE/QwtPJN22Glf4p+ARt+57DnZbNdjbGA7CgCISKBPJEEg6VMbbHHbL2hPijdZWfDnwxsx
M0NaLMKJHROUBnD1XSmcOp0Y4fPqwUIyTcJKxMk4CG+1SN14VPkPRHxMPlWctiDhKSmPWpx7
VGe0CBoDM37w4oHq9/7EZ+YbKb9FSGEZeX1v5ZHinW1BuEf9UqGATgVqlcn+dvkLGxt/XMF9
KHalMI4dtr9NyqD364BytjUPSZbCG6o+XW6YTuQTpcOmaudHSUxEPPU8qwIDAQABoy0wKzAb
BgNVHREEFDASgRBrYmFua2V0dEBhb2wuY29tMAwGA1UdEwEB/wQCMAAwDQYJKoZIhvcNAQEE
BQADgYEAsFaFuHPmW3FGBzey60EEv60UHvzO3nJHUPhcVEtQoLZqYL/OdLZykxg+GJ0vjOnZ
AoJK1uJUUd9yWeEmJVAU5nuo5oBidAbmMyavJXKuuI1b5eG+jBqvYe6GHW/GUY/hpusuoLqn
DfFmCWv+/xH0dG3FgyR54bU+DYPiCGTRkAowggM4MIICoaADAgECAhBmRXK3zHT1z2N2RYTQ
LpEBMA0GCSqGSIb3DQEBBAUAMIHRMQswCQYDVQQGEwJaQTEVMBMGA1UECBMMV2VzdGVybiBD
YXBlMRIwEAYDVQQHEwlDYXBlIFRvd24xGjAYBgNVBAoTEVRoYXd0ZSBDb25zdWx0aW5nMSgw
JgYDVQQLEx9DZXJ0aWZpY2F0aW9uIFNlcnZpY2VzIERpdmlzaW9uMSQwIgYDVQQDExtUaGF3
dGUgUGVyc29uYWwgRnJlZW1haWwgQ0ExKzApBgkqhkiG9w0BCQEWHHBlcnNvbmFsLWZyZWVt
YWlsQHRoYXd0ZS5jb20wHhcNMDAwODMwMDAwMDAwWhcNMDQwODI3MjM1OTU5WjCBkjELMAkG
A1UEBhMCWkExFTATBgNVBAgTDFdlc3Rlcm4gQ2FwZTESMBAGA1UEBxMJQ2FwZSBUb3duMQ8w
DQYDVQQKEwZUaGF3dGUxHTAbBgNVBAsTFENlcnRpZmljYXRlIFNlcnZpY2VzMSgwJgYDVQQD
Ex9QZXJzb25hbCBGcmVlbWFpbCBSU0EgMjAwMC44LjMwMIGfMA0GCSqGSIb3DQEBAQUAA4GN
ADCBiQKBgQDeMzKmY8cJJUU+0m54J2eBxdqIGYKXDuNEKYpjNSptcDz63K737nRvMLwzkH/5
NHGgo22Y8cNPomXbDfpL8dbdYaX5hc1VmjUanZJ1qCeu2HL5ugL217CR3hzpq+AYA6h8Q0JQ
UYeDPPA5tJtUihOH/7ObnUlmAC0JieyUa+mhaQIDAQABo04wTDApBgNVHREEIjAgpB4wHDEa
MBgGA1UEAxMRUHJpdmF0ZUxhYmVsMS0yOTcwEgYDVR0TAQH/BAgwBgEB/wIBADALBgNVHQ8E
BAMCAQYwDQYJKoZIhvcNAQEEBQADgYEAMbFLR135AXHl9VNsXXnWPZjAJhNigSKnEvgilegb
SbcnewQ5uvzm8iTrkfq97A0qOPdQVahs9w2tTBu8A/S166JHn2yiDFiNMUIJEWywGmnRKxKy
QF1q+XnQ6i4l3Yrk/NsNH50C81rbyjz2ROomaYd/SJ7OpZ/nhNjJYmKtBcYxggMnMIIDIwIB
ATCBmjCBkjELMAkGA1UEBhMCWkExFTATBgNVBAgTDFdlc3Rlcm4gQ2FwZTESMBAGA1UEBxMJ
Q2FwZSBUb3duMQ8wDQYDVQQKEwZUaGF3dGUxHTAbBgNVBAsTFENlcnRpZmljYXRlIFNlcnZp
Y2VzMSgwJgYDVQQDEx9QZXJzb25hbCBGcmVlbWFpbCBSU0EgMjAwMC44LjMwAgMJ4BEwCQYF
Kw4DAhoFAKCCAWEwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcN
MDMwNTIxMTEwMDU5WjAjBgkqhkiG9w0BCQQxFgQUgG53K8e09282HkXdMBOc8A2ao8YwUgYJ
KoZIhvcNAQkPMUUwQzAKBggqhkiG9w0DBzAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwIC
AUAwBwYFKw4DAgcwDQYIKoZIhvcNAwICASgwga0GCyqGSIb3DQEJEAILMYGdoIGaMIGSMQsw
CQYDVQQGEwJaQTEVMBMGA1UECBMMV2VzdGVybiBDYXBlMRIwEAYDVQQHEwlDYXBlIFRvd24x
DzANBgNVBAoTBlRoYXd0ZTEdMBsGA1UECxMUQ2VydGlmaWNhdGUgU2VydmljZXMxKDAmBgNV
BAMTH1BlcnNvbmFsIEZyZWVtYWlsIFJTQSAyMDAwLjguMzACAwngETANBgkqhkiG9w0BAQEF
AASCAQCqn1F0ZU+MyU9gA0pl5ByUrXSdsEm8wjzA/3ORwBgBxJ//mW7V2TG0XmCKqpcE5FJ3
AHb4Vvk0CEapMJHgrSW7FEVPvVJK5EFDtsj4Tu8275/BR8QbQgVKlsSJg2TgiZO7ws00OdLa
QIZam0hu3d70rH446jBO1jPP4BkqM5UTq85OkrtPIIYqJJFcl0O/GOQr6nZbqEZZNYQyqfks
aBiDmYDXTRocjuqfNFZX2ZaFAqL5opUNsscxiNd3balTC0rT12TTeLgiBencfjnJfSTk/hQV
GZUak+38ilIp4oYUGtCRV0a9zYX5JvoN+Nl6EV+7jsOXL+DLlOGCzisMwFZmAAAAAAAA
--------------ms080104030103030300020301--

