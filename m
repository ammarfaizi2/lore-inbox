Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264457AbTK0Ipg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 03:45:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264459AbTK0Ipg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 03:45:36 -0500
Received: from siaar1aa.compuserve.com ([149.174.40.9]:32464 "EHLO
	siaar1aa.compuserve.com") by vger.kernel.org with ESMTP
	id S264457AbTK0Ipc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 03:45:32 -0500
Message-ID: <3FC5BA42.9090707@aol.com>
Date: Thu, 27 Nov 2003 09:48:02 +0100
From: Kai Bankett <kbankett@aol.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jamie Lokier <jamie@shareable.org>
CC: Kai Bankett <kbankett@aol.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] irq_balance does not make sense with HT but single physical
 CPU
References: <3FC4B5C8.6020405@aol.com> <20031126184031.GC14383@mail.shareable.org>
In-Reply-To: <20031126184031.GC14383@mail.shareable.org>
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms050905050405060201080706"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms050905050405060201080706
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

> 
> If you had two tasks both running continuously, one per sibling, then
> not IRQ balancing will penalise the task on the sibling which is
> getting most interrupts.
> 

Yes - did some more reading on HT and how the cpu looks like in that 
case ... I was thinking that interrupt lines - while in HT mode - aren´t 
available independently to both "parts" of the cpu. That was my fault - 
of course.

So just dismiss the patch - sorry.

Thanks,

Kai

--------------ms050905050405060201080706
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
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
uz0XAAAAAAAA
--------------ms050905050405060201080706--

