Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263665AbUESDCT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263665AbUESDCT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 May 2004 23:02:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263777AbUESDCT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 May 2004 23:02:19 -0400
Received: from kendy.up.ac.za ([137.215.101.101]:45992 "EHLO kendy.up.ac.za")
	by vger.kernel.org with ESMTP id S263665AbUESDCP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 May 2004 23:02:15 -0400
Message-ID: <40A9E239.4010909@cs.up.ac.za>
Date: Tue, 18 May 2004 12:15:21 +0200
From: Jaco Kroon <jkroon@cs.up.ac.za>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040325
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: acooks@cs.up.ac.za
Subject: NFS deadlock
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms040103010408010504090703"
X-Scan-Signature: 92b4b4113af203e4aa8b96377c51404e
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms040103010408010504090703
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello there

I've once again got problems with the kernel locking up.  I'm now 
convinced that it has something to do with NFS.

Previously weve had 2 machines that locked up, plus my one at home, 
resulting in three machines.  Sometimes they would recover by themselves 
after some time, other times they could be left for 2 days or so without 
recovering.  All three of these use NFS to export files to other 
machines, it's the only thing we can find they have in common, other 
that x86 architecture, but then other machines would be dying as well.  
It should be noted that none of these runs on the newest hardware, but 
that should not matter, neither does any of our other servers.  We have 
a 3rd NFS server, which doesn't take nearly as heavy load via NFS.  I've 
been wondering why it hasn't locked up either, and this morning (right 
now in fact) it has decided that it is it's turn and is currently unusable.

If anybody else is experiencing similar problems, or have possible work 
arounds, it would be appreciated if you could share your knowledge.

Jaco

===========================================
This message and attachments are subject to a disclaimer. Please refer to www.it.up.ac.za/documentation/governance/disclaimer/ for full details.
Hierdie boodskap en aanhangsels is aan 'n vrywaringsklousule onderhewig. Volledige besonderhede is by www.it.up.ac.za/documentation/governance/disclaimer/ beskikbaar.
===========================================


--------------ms040103010408010504090703
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIII7TCC
AtEwggI6oAMCAQICAwuV3TANBgkqhkiG9w0BAQQFADBiMQswCQYDVQQGEwJaQTElMCMGA1UE
ChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNv
bmFsIEZyZWVtYWlsIElzc3VpbmcgQ0EwHhcNMDQwMTI4MTMxNTM0WhcNMDUwMTI3MTMxNTM0
WjBEMR8wHQYDVQQDExZUaGF3dGUgRnJlZW1haWwgTWVtYmVyMSEwHwYJKoZIhvcNAQkBFhJq
a3Jvb25AY3MudXAuYWMuemEwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDGM68H
Bm8eLZzRqFlPks3sjEOAQrolKEESLKGNAL6Pu+KUMRQ9wC5feaXfg5wmVBe6VLhTY9pkiVJi
mTX1VrHdJgnvqkKfjQrPn66oAqUlytHCSB6s5SmIquw1Nu4rMK5D+/LMqV73iTEyP/2p9GbK
w9h3xmqn3HytZfqgK/Zh8SKhjRzAE+PT2aVSBL43RetHgn4CRKVacERTLYK2Gfv5jhljPuSE
6ppfVOq/Jm/tduG/xn92wWlIOL8oPq4dQcy5wYjg9nrImwM7tFlD22iY0IESSqKTe2EkhcUY
rpc+M3XZEU7bz+sSTG7MbXNfkfn+4G92KN7Z9hhex1QAxBfnAgMBAAGjLzAtMB0GA1UdEQQW
MBSBEmprcm9vbkBjcy51cC5hYy56YTAMBgNVHRMBAf8EAjAAMA0GCSqGSIb3DQEBBAUAA4GB
AKItHT03yxemitMQFThOBwjiQrPwKqF5lqskzUY467RLA+6EBki+6MtGnv6yhwrOaV7H4BE3
p7gpVXtQZBlmHfZnK2l5C56OSdahZ77ti7+qsft7t1z+DyUUWCuRxA5hy4xXKgqd9cwy6mEp
uU7muCasFm9FR6H5vQbkCHH1DmjqMIIC0TCCAjqgAwIBAgIDC5XdMA0GCSqGSIb3DQEBBAUA
MGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQu
MSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQTAeFw0wNDAx
MjgxMzE1MzRaFw0wNTAxMjcxMzE1MzRaMEQxHzAdBgNVBAMTFlRoYXd0ZSBGcmVlbWFpbCBN
ZW1iZXIxITAfBgkqhkiG9w0BCQEWEmprcm9vbkBjcy51cC5hYy56YTCCASIwDQYJKoZIhvcN
AQEBBQADggEPADCCAQoCggEBAMYzrwcGbx4tnNGoWU+SzeyMQ4BCuiUoQRIsoY0Avo+74pQx
FD3ALl95pd+DnCZUF7pUuFNj2mSJUmKZNfVWsd0mCe+qQp+NCs+frqgCpSXK0cJIHqzlKYiq
7DU27iswrkP78sypXveJMTI//an0ZsrD2HfGaqfcfK1l+qAr9mHxIqGNHMAT49PZpVIEvjdF
60eCfgJEpVpwRFMtgrYZ+/mOGWM+5ITqml9U6r8mb+124b/Gf3bBaUg4vyg+rh1BzLnBiOD2
esibAzu0WUPbaJjQgRJKopN7YSSFxRiulz4zddkRTtvP6xJMbsxtc1+R+f7gb3Yo3tn2GF7H
VADEF+cCAwEAAaMvMC0wHQYDVR0RBBYwFIESamtyb29uQGNzLnVwLmFjLnphMAwGA1UdEwEB
/wQCMAAwDQYJKoZIhvcNAQEEBQADgYEAoi0dPTfLF6aK0xAVOE4HCOJCs/AqoXmWqyTNRjjr
tEsD7oQGSL7oy0ae/rKHCs5pXsfgETenuClVe1BkGWYd9mcraXkLno5J1qFnvu2Lv6qx+3u3
XP4PJRRYK5HEDmHLjFcqCp31zDLqYSm5Tua4JqwWb0VHofm9BuQIcfUOaOowggM/MIICqKAD
AgECAgENMA0GCSqGSIb3DQEBBQUAMIHRMQswCQYDVQQGEwJaQTEVMBMGA1UECBMMV2VzdGVy
biBDYXBlMRIwEAYDVQQHEwlDYXBlIFRvd24xGjAYBgNVBAoTEVRoYXd0ZSBDb25zdWx0aW5n
MSgwJgYDVQQLEx9DZXJ0aWZpY2F0aW9uIFNlcnZpY2VzIERpdmlzaW9uMSQwIgYDVQQDExtU
aGF3dGUgUGVyc29uYWwgRnJlZW1haWwgQ0ExKzApBgkqhkiG9w0BCQEWHHBlcnNvbmFsLWZy
ZWVtYWlsQHRoYXd0ZS5jb20wHhcNMDMwNzE3MDAwMDAwWhcNMTMwNzE2MjM1OTU5WjBiMQsw
CQYDVQQGEwJaQTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoG
A1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0EwgZ8wDQYJKoZIhvcN
AQEBBQADgY0AMIGJAoGBAMSmPFVzVftOucqZWh5owHUEcJ3f6f+jHuy9zfVb8hp2vX8MOmHy
v1HOAdTlUAow1wJjWiyJFXCO3cnwK4Vaqj9xVsuvPAsH5/EfkTYkKhPPK9Xzgnc9A74r/rsY
Pge/QIACZNenprufZdHFKlSFD0gEf6e20TxhBEAeZBlyYLf7AgMBAAGjgZQwgZEwEgYDVR0T
AQH/BAgwBgEB/wIBADBDBgNVHR8EPDA6MDigNqA0hjJodHRwOi8vY3JsLnRoYXd0ZS5jb20v
VGhhd3RlUGVyc29uYWxGcmVlbWFpbENBLmNybDALBgNVHQ8EBAMCAQYwKQYDVR0RBCIwIKQe
MBwxGjAYBgNVBAMTEVByaXZhdGVMYWJlbDItMTM4MA0GCSqGSIb3DQEBBQUAA4GBAEiM0VCD
6gsuzA2jZqxnD3+vrL7CF6FDlpSdf0whuPg2H6otnzYvwPQcUCCTcDz9reFhYsPZOhl+hLGZ
GwDFGguCdJ4lUJRix9sncVcljd2pnDmOjCBPZV+V2vf3h9bGCE6u9uo05RAaWzVNd+NWIXiC
3CEZNd4ksdMdRv9dX2VPMYIDOzCCAzcCAQEwaTBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMc
VGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFs
IEZyZWVtYWlsIElzc3VpbmcgQ0ECAwuV3TAJBgUrDgMCGgUAoIIBpzAYBgkqhkiG9w0BCQMx
CwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0wNDA1MTgxMDE1MjFaMCMGCSqGSIb3DQEJ
BDEWBBSCD+6gxWYXVKFqlY3pmklwnSr34zBSBgkqhkiG9w0BCQ8xRTBDMAoGCCqGSIb3DQMH
MA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAHBgUrDgMCBzANBggqhkiG9w0DAgIB
KDB4BgkrBgEEAYI3EAQxazBpMGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29u
c3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwg
SXNzdWluZyBDQQIDC5XdMHoGCyqGSIb3DQEJEAILMWugaTBiMQswCQYDVQQGEwJaQTElMCMG
A1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBl
cnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0ECAwuV3TANBgkqhkiG9w0BAQEFAASCAQCQtFHD
iOYdHiVffnsPOUVyiaXJA63obt7ZLuBsdi34b6K2jzSCwy7XXfNMSHM4dJW6ifA4DnjnoTmj
oK+IMccbGN/UDeCYc7K7I5Ru96bLsO/8dV7JA9DPVtW4wtSQOK4jiqSHZ688BOY4tpBfFd8X
j3l6Y18Ne2sKfFX1BZziTHzxkw0wjshjMN2I681qos6WdQ3/gJtrt0MXKaq7OjFtS7eIXH5G
USjJNatEVSZL7DfakkhyCbi9JOVvr/dCUnGZBcnh2B6iBMf23JKrxHcsbPeFAZHx50db80DL
rBjx+i+GAXoPUBqAHtzMA+cAJYtCn88xzFXiJdjQ0q9lPE/SAAAAAAAA
--------------ms040103010408010504090703--
