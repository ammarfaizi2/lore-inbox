Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263874AbTEOGFr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 02:05:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263875AbTEOGFq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 02:05:46 -0400
Received: from [195.228.112.1] ([195.228.112.1]:53027 "HELO goliat.otp-bank.hu")
	by vger.kernel.org with SMTP id S263874AbTEOGFm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 02:05:42 -0400
Message-ID: <3EC330D7.8060503@dell633.otpefo.com>
Date: Thu, 15 May 2003 08:16:55 +0200
From: Nagy Tibor <nagyt@otpbank.hu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en, hu
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.20 Ooops on Dell 6600
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms050400060509070100080908"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms050400060509070100080908
Content-Type: multipart/mixed;
 boundary="------------010200010302080208090207"

This is a multi-part message in MIME format.
--------------010200010302080208090207
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

we have a Dell PowerEdge 6600 server (4x1400 MHz multithread Xeon, 4GB 
RAM, SuSe Linux 8.0, 2.4.20 Linux kernel). We have got the attached 
'Ooops'. What does it mean?

Thanks for any replay in advance.

------------------------------------------------------------------------
Tibor Nagy
National Savings and Commercial Bank Ltd (OTP Bank)
E-mail: nagyt@otpbank.hu
------------------------------------------------------------------------

--------------010200010302080208090207
Content-Type: text/plain;
 name="Oops.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Oops.txt"

Oops 0000
CPU 	6
EIP	0010:[<c0246400>] Not tained
EFLAGS: 00010246
eax:030ac90a   ebx:f8806000  ecx:000003fe edx:01f0c90a
esi:00000001 edi:1f92fc04 ebp:f8806010 esp:ea8bdcec
ds:0018   es:0018   ss:0018

Process rsh (pid: 27741, stackpage=ea8bd000)

Stack:  ea8bc000 ea8bdd64 f704df00 ea8bddf8 00002000 1f92fc04 01f0c90a 030ac90a
	f8806000 000003fe fe03f800 1f92fc04 01f0c90a 030ac90a c0246467 ea8bdd64
	00000000 ea86dd60 ea8bdd64 c0247028 ea8bdd64 00000000 ea8bdde8 c038a6f8

Call Trace:  [<c0246467>] [<c0247028>] [<c0220600>] [<c021fe03>] [<c02456c0>]
[<c0220600>] [<c021523c>] [<c0220600>] [<c0220600>] [<c021558f>] [<c0220600>]
[<c021fa29>] [<c0220600>] [<c0234116>] [<c022ef2e>] [<c022efe9>] [<c020af0e>]
[<c022f2ee>] [<c622511f>] [<c02410a6>] [<c0207905>] [<c020761e>] [<c0135fe7>]
[<c0106f23>]

Code: 8b 6d 8b ea 44 24 2c 03 44 24 24 31 d2 f7 74 24 10 8b 4c 24
<0>  Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing

--------------010200010302080208090207--

--------------ms050400060509070100080908
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIIODCC
AnowggHjoAMCAQICAwefrDANBgkqhkiG9w0BAQQFADCBkjELMAkGA1UEBhMCWkExFTATBgNV
BAgTDFdlc3Rlcm4gQ2FwZTESMBAGA1UEBxMJQ2FwZSBUb3duMQ8wDQYDVQQKEwZUaGF3dGUx
HTAbBgNVBAsTFENlcnRpZmljYXRlIFNlcnZpY2VzMSgwJgYDVQQDEx9QZXJzb25hbCBGcmVl
bWFpbCBSU0EgMjAwMC44LjMwMB4XDTAyMDYwNTExMTUzMloXDTAzMDYwNTExMTUzMlowQjEf
MB0GA1UEAxMWVGhhd3RlIEZyZWVtYWlsIE1lbWJlcjEfMB0GCSqGSIb3DQEJARYQbmFneXRA
b3RwYmFuay5odTCBnzANBgkqhkiG9w0BAQEFAAOBjQAwgYkCgYEAzMDU8ewvf7ETTp3bensG
UIklhLKLW+x9h5WYHh2xz85KD/LhbGo4gsyH7fDFDfkU2zbcCOdh9GWOEY22hKbmNF6KgTX1
1QobUUJXRPVExhMTy1dHO31jM4CvaShaD/5arG3/RCL1+XU+2CtiWJLlwLSQFE0P1htrJsES
gU0+tJkCAwEAAaMtMCswGwYDVR0RBBQwEoEQbmFneXRAb3RwYmFuay5odTAMBgNVHRMBAf8E
AjAAMA0GCSqGSIb3DQEBBAUAA4GBAElTGssxkjYwtj1GchcUzvuScNcR3PKd5JrTinp6DDmv
phLMcqebax45urkSQOTm8PqfRlFlpnNuEy77VAcgna/cVQw2pvftmtE6PMmq0utw4cGRWvmQ
1uVyjZUlSjPMYmC4tyVyTNNSyBdYB6WrYSM3hNGglV3AynUt3pio5bdXMIICejCCAeOgAwIB
AgIDB5+sMA0GCSqGSIb3DQEBBAUAMIGSMQswCQYDVQQGEwJaQTEVMBMGA1UECBMMV2VzdGVy
biBDYXBlMRIwEAYDVQQHEwlDYXBlIFRvd24xDzANBgNVBAoTBlRoYXd0ZTEdMBsGA1UECxMU
Q2VydGlmaWNhdGUgU2VydmljZXMxKDAmBgNVBAMTH1BlcnNvbmFsIEZyZWVtYWlsIFJTQSAy
MDAwLjguMzAwHhcNMDIwNjA1MTExNTMyWhcNMDMwNjA1MTExNTMyWjBCMR8wHQYDVQQDExZU
aGF3dGUgRnJlZW1haWwgTWVtYmVyMR8wHQYJKoZIhvcNAQkBFhBuYWd5dEBvdHBiYW5rLmh1
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDMwNTx7C9/sRNOndt6ewZQiSWEsotb7H2H
lZgeHbHPzkoP8uFsajiCzIft8MUN+RTbNtwI52H0ZY4RjbaEpuY0XoqBNfXVChtRQldE9UTG
ExPLV0c7fWMzgK9pKFoP/lqsbf9EIvX5dT7YK2JYkuXAtJAUTQ/WG2smwRKBTT60mQIDAQAB
oy0wKzAbBgNVHREEFDASgRBuYWd5dEBvdHBiYW5rLmh1MAwGA1UdEwEB/wQCMAAwDQYJKoZI
hvcNAQEEBQADgYEASVMayzGSNjC2PUZyFxTO+5Jw1xHc8p3kmtOKenoMOa+mEsxyp5trHjm6
uRJA5Obw+p9GUWWmc24TLvtUByCdr9xVDDam9+2a0To8yarS63DhwZFa+ZDW5XKNlSVKM8xi
YLi3JXJM01LIF1gHpathIzeE0aCVXcDKdS3emKjlt1cwggM4MIICoaADAgECAhBmRXK3zHT1
z2N2RYTQLpEBMA0GCSqGSIb3DQEBBAUAMIHRMQswCQYDVQQGEwJaQTEVMBMGA1UECBMMV2Vz
dGVybiBDYXBlMRIwEAYDVQQHEwlDYXBlIFRvd24xGjAYBgNVBAoTEVRoYXd0ZSBDb25zdWx0
aW5nMSgwJgYDVQQLEx9DZXJ0aWZpY2F0aW9uIFNlcnZpY2VzIERpdmlzaW9uMSQwIgYDVQQD
ExtUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgQ0ExKzApBgkqhkiG9w0BCQEWHHBlcnNvbmFs
LWZyZWVtYWlsQHRoYXd0ZS5jb20wHhcNMDAwODMwMDAwMDAwWhcNMDQwODI3MjM1OTU5WjCB
kjELMAkGA1UEBhMCWkExFTATBgNVBAgTDFdlc3Rlcm4gQ2FwZTESMBAGA1UEBxMJQ2FwZSBU
b3duMQ8wDQYDVQQKEwZUaGF3dGUxHTAbBgNVBAsTFENlcnRpZmljYXRlIFNlcnZpY2VzMSgw
JgYDVQQDEx9QZXJzb25hbCBGcmVlbWFpbCBSU0EgMjAwMC44LjMwMIGfMA0GCSqGSIb3DQEB
AQUAA4GNADCBiQKBgQDeMzKmY8cJJUU+0m54J2eBxdqIGYKXDuNEKYpjNSptcDz63K737nRv
MLwzkH/5NHGgo22Y8cNPomXbDfpL8dbdYaX5hc1VmjUanZJ1qCeu2HL5ugL217CR3hzpq+AY
A6h8Q0JQUYeDPPA5tJtUihOH/7ObnUlmAC0JieyUa+mhaQIDAQABo04wTDApBgNVHREEIjAg
pB4wHDEaMBgGA1UEAxMRUHJpdmF0ZUxhYmVsMS0yOTcwEgYDVR0TAQH/BAgwBgEB/wIBADAL
BgNVHQ8EBAMCAQYwDQYJKoZIhvcNAQEEBQADgYEAMbFLR135AXHl9VNsXXnWPZjAJhNigSKn
EvgilegbSbcnewQ5uvzm8iTrkfq97A0qOPdQVahs9w2tTBu8A/S166JHn2yiDFiNMUIJEWyw
GmnRKxKyQF1q+XnQ6i4l3Yrk/NsNH50C81rbyjz2ROomaYd/SJ7OpZ/nhNjJYmKtBcYxggNU
MIIDUAIBATCBmjCBkjELMAkGA1UEBhMCWkExFTATBgNVBAgTDFdlc3Rlcm4gQ2FwZTESMBAG
A1UEBxMJQ2FwZSBUb3duMQ8wDQYDVQQKEwZUaGF3dGUxHTAbBgNVBAsTFENlcnRpZmljYXRl
IFNlcnZpY2VzMSgwJgYDVQQDEx9QZXJzb25hbCBGcmVlbWFpbCBSU0EgMjAwMC44LjMwAgMH
n6wwCQYFKw4DAhoFAKCCAg8wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0B
CQUxDxcNMDMwNTE1MDYxNjU1WjAjBgkqhkiG9w0BCQQxFgQUhZ7PLOR2B/zBPmTaqUpzVHHp
SjcwUgYJKoZIhvcNAQkPMUUwQzAKBggqhkiG9w0DBzAOBggqhkiG9w0DAgICAIAwDQYIKoZI
hvcNAwICAUAwBwYFKw4DAgcwDQYIKoZIhvcNAwICASgwgasGCSsGAQQBgjcQBDGBnTCBmjCB
kjELMAkGA1UEBhMCWkExFTATBgNVBAgTDFdlc3Rlcm4gQ2FwZTESMBAGA1UEBxMJQ2FwZSBU
b3duMQ8wDQYDVQQKEwZUaGF3dGUxHTAbBgNVBAsTFENlcnRpZmljYXRlIFNlcnZpY2VzMSgw
JgYDVQQDEx9QZXJzb25hbCBGcmVlbWFpbCBSU0EgMjAwMC44LjMwAgMHn6wwga0GCyqGSIb3
DQEJEAILMYGdoIGaMIGSMQswCQYDVQQGEwJaQTEVMBMGA1UECBMMV2VzdGVybiBDYXBlMRIw
EAYDVQQHEwlDYXBlIFRvd24xDzANBgNVBAoTBlRoYXd0ZTEdMBsGA1UECxMUQ2VydGlmaWNh
dGUgU2VydmljZXMxKDAmBgNVBAMTH1BlcnNvbmFsIEZyZWVtYWlsIFJTQSAyMDAwLjguMzAC
AwefrDANBgkqhkiG9w0BAQEFAASBgHrOl0n1HjE8mnE3o/Y104Iq95EjLFHlaZga+wEClqGg
pt/k9uDP2LkpiuyU1fU6C5+8hE/XdknvVIONyn+jEAIIf2yHjwZD8Hg6PbJv9dpPHwIeyiuJ
epQHaze/eDtKiTz6R0PoccWkflGWEjTWJBFvYnutlIasqhoYvrppL0DSAAAAAAAA
--------------ms050400060509070100080908--

