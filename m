Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129338AbQJ3S4v>; Mon, 30 Oct 2000 13:56:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129631AbQJ3S4b>; Mon, 30 Oct 2000 13:56:31 -0500
Received: from h-205-217-237-46.netscape.com ([205.217.237.46]:63425 "EHLO
	netscape.com") by vger.kernel.org with ESMTP id <S129628AbQJ3S4W>;
	Mon, 30 Oct 2000 13:56:22 -0500
Date: Mon, 30 Oct 2000 10:55:38 -0800
From: John Gardiner Myers <jgmyers@netscape.com>
Subject: Re: Readiness vs. completion (was: Re: Linux's implementation of
 poll()not scalable?)
To: dank@alumni.caltech.edu
Cc: linux-kernel@vger.kernel.org
Message-id: <39FDC42A.CD9C3D12@netscape.com>
MIME-version: 1.0
X-Mailer: Mozilla 4.74 [en] (WinNT; U)
Content-type: multipart/signed; protocol="application/x-pkcs7-signature";
 micalg=sha1; boundary=------------ms79E15C2DB0A6E0AFB635B732
X-Accept-Language: en
In-Reply-To: <39FCC2B8.DA281B4C@alumni.caltech.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms79E15C2DB0A6E0AFB635B732
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit



Dan Kegel wrote:
> IMHO you're describing a situation where a 'completion notification event'
> (as with aio) would be more appropriate than a 'readiness notification event'
> (as with poll).

I've found that I want both types of events, preferably through the same
interface.  To provide a "completion notification event" interface on
top of an existing nonblocking interface, one needs an "async poll"
mechanism with edge-triggered events with no event coalescing.

You are correct in recognizing NT completion ports from my description. 
While the NT completion port interface is ugly as sin, it gets a number
of performance issues right.

> And, come to think of it, network programmers usually can be categorized
> into the same two groups :-)  Each style of programming is an acquired taste.

I would say that the "completion notification" style is a paradigm
beyond the "readiness notification" style.  I started with the select()
model of network programming and have since learned the clear
superiority of the "completion notificatin" style.
--------------ms79E15C2DB0A6E0AFB635B732
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIIXwYJKoZIhvcNAQcCoIIIUDCCCEwCAQExCzAJBgUrDgMCGgUAMAsGCSqGSIb3DQEHAaCC
BlkwggMMMIICdaADAgECAgIeFDANBgkqhkiG9w0BAQQFADCBkzELMAkGA1UEBhMCVVMxCzAJ
BgNVBAgTAkNBMRYwFAYDVQQHEw1Nb3VudGFpbiBWaWV3MRswGQYDVQQKExJBbWVyaWNhIE9u
bGluZSBJbmMxGTAXBgNVBAsTEEFPTCBUZWNobm9sb2dpZXMxJzAlBgNVBAMTHkludHJhbmV0
IENlcnRpZmljYXRlIEF1dGhvcml0eTAeFw0wMDA2MDIxNzE1MjlaFw0wMDExMjkxNzE1Mjla
MIGCMRMwEQYKCZImiZPyLGQBGRYDY29tMRgwFgYKCZImiZPyLGQBGRYIbmV0c2NhcGUxIzAh
BgkqhkiG9w0BCQEWFGpnbXllcnNAbmV0c2NhcGUuY29tMRMwEQYDVQQDEwpKb2huIE15ZXJz
MRcwFQYKCZImiZPyLGQBARMHamdteWVyczCBnzANBgkqhkiG9w0BAQEFAAOBjQAwgYkCgYEA
0+WYWlf3g+u6vFEBJwo+4Cxz0PM5GUuqOHGVkjPFTeGjR05BUJADWm8mZDoAhUuIVuTvixCx
AB0f5JzDWmIIWbB0ea92RwOHdibSS3bT0BTwKNTgt+PQAH3ZdH+IjmGAZI6/J+5Ob3m43ZZl
o/3lfGEd4O7gAJY62Sy76MgO1O0CAwEAAaN+MHwwEQYJYIZIAYb4QgEBBAQDAgWgMA4GA1Ud
DwEB/wQEAwIEsDAfBgNVHSMEGDAWgBSiO2Uy9/cbifxVDQcBvIdIWv2QPTA2BggrBgEFBQcB
AQQqMCgwJgYIKwYBBQUHMAGGGmh0dHA6Ly9uc29jc3AubmV0c2NhcGUuY29tMA0GCSqGSIb3
DQEBBAUAA4GBAGPAOC3FZineuE0PLv+pKc52i5uz+lpHzvssmUrr5FNSSD3M+DBow7Sd3YW+
vyPVAxH+MZ5RtE+If/aDDYQhgpCtbujQb5wPVRS5ZCmKpAC0eOnP12jcUDLr1tfhyBIlIvJQ
6xGKj7ckSK6G7lNxuQ8a12v/v2yEEk2uADg51oY7MIIDRTCCAq6gAwIBAgIBJzANBgkqhkiG
9w0BAQQFADCB0TELMAkGA1UEBhMCWkExFTATBgNVBAgTDFdlc3Rlcm4gQ2FwZTESMBAGA1UE
BxMJQ2FwZSBUb3duMRowGAYDVQQKExFUaGF3dGUgQ29uc3VsdGluZzEoMCYGA1UECxMfQ2Vy
dGlmaWNhdGlvbiBTZXJ2aWNlcyBEaXZpc2lvbjEkMCIGA1UEAxMbVGhhd3RlIFBlcnNvbmFs
IEZyZWVtYWlsIENBMSswKQYJKoZIhvcNAQkBFhxwZXJzb25hbC1mcmVlbWFpbEB0aGF3dGUu
Y29tMB4XDTk5MDYwMzIyMDAzNFoXDTAxMDYwMjIyMDAzNFowgZMxCzAJBgNVBAYTAlVTMQsw
CQYDVQQIEwJDQTEWMBQGA1UEBxMNTW91bnRhaW4gVmlldzEbMBkGA1UEChMSQW1lcmljYSBP
bmxpbmUgSW5jMRkwFwYDVQQLExBBT0wgVGVjaG5vbG9naWVzMScwJQYDVQQDEx5JbnRyYW5l
dCBDZXJ0aWZpY2F0ZSBBdXRob3JpdHkwgZ8wDQYJKoZIhvcNAQEBBQADgY0AMIGJAoGBAOLv
Xyx2Q4lLGl+z5fiqb4svgU1n/71KD2MuxNyF9p4sSSYg/wAX5IiIad79g1fgoxEZEarW3Lzv
s9IVLlTGbny/2bnDRtMJBYTlU1xI7YSFmg47PRYHXPCzeauaEKW8waTReEwG5WRB/AUlYybr
7wzHblShjM5UV7YfktqyEkuNAgMBAAGjaTBnMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0l
BBYwFAYIKwYBBQUHAwQGCCsGAQUFBwMCMBEGCWCGSAGG+EIBAQQEAwIBAjAfBgNVHSMEGDAW
gBRyScJzNMZV9At2coF+d/SH58ayDjANBgkqhkiG9w0BAQQFAAOBgQC6UH38ALL/QbQHCDkM
IfRZSRcIzI7TzwxW8W/oCxppYusGgltprB2EJwY5yQ5+NRPQfsCPnFh8AzEshxDVYjtw1Q6x
ZIA0Tln6xlnmRt5OaAh1QPUdjCnWrnetyT1p5ECNRJdGb756wFiksR9qpw8pUYqBDSmOneQP
MwuPjSQ97DGCAc4wggHKAgEBMIGaMIGTMQswCQYDVQQGEwJVUzELMAkGA1UECBMCQ0ExFjAU
BgNVBAcTDU1vdW50YWluIFZpZXcxGzAZBgNVBAoTEkFtZXJpY2EgT25saW5lIEluYzEZMBcG
A1UECxMQQU9MIFRlY2hub2xvZ2llczEnMCUGA1UEAxMeSW50cmFuZXQgQ2VydGlmaWNhdGUg
QXV0aG9yaXR5AgIeFDAJBgUrDgMCGgUAoIGKMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTAwMTAzMDE4NTUzOFowIwYJKoZIhvcNAQkEMRYEFOdosWP99uRF
oWD+wzA7GSGI1Zn0MCsGCSqGSIb3DQEJDzEeMBwwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwIC
AgCAMA0GCSqGSIb3DQEBAQUABIGARxp6Omjdl+sSFlK5FHOZr8qo+P99WqpKdMkm8YGwIPnf
eNmrl7YZuYR/UpH28ETovb6VlLNzbS4wws4PzDFYpqcPE+8YqYY5C8V7IVId/EPZdU8424cM
P4CHu6HZYSpx88dW1Fo4oUvEnRwAO7852jj/V9D+hu7wlXH6NoPUDqw=
--------------ms79E15C2DB0A6E0AFB635B732--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
