Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262873AbUDALlp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 06:41:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262876AbUDALlp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 06:41:45 -0500
Received: from kendy.up.ac.za ([137.215.101.101]:27064 "EHLO kendy.up.ac.za")
	by vger.kernel.org with ESMTP id S262873AbUDALlj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 06:41:39 -0500
Message-ID: <406BFFBA.2030502@cs.up.ac.za>
Date: Thu, 01 Apr 2004 13:40:42 +0200
From: Jaco Kroon <jkroon@cs.up.ac.za>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040325
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Balazs Ree <ree@ree.hu>
CC: linux-kernel@vger.kernel.org
Subject: Re: HPT370 locks up (2.4/2.6)
References: <pan.2004.03.30.12.36.03.326699@ree.hu> <200403311054.01626.vda@port.imtp.ilyichevsk.odessa.ua> <pan.2004.04.01.10.32.57.982363@ree.hu>
In-Reply-To: <pan.2004.04.01.10.32.57.982363@ree.hu>
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms010202040707060907040108"
X-Scan-Signature: 1a610210a8497254153b13ea82efdee4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms010202040707060907040108
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Weird question, but do you perhaps have the APIC enabled?

Balazs Ree wrote:

>On Wed, 31 Mar 2004 10:54:01 +0200, Denis Vlasenko wrote:
>  
>
>>You may need to serialize channel usage in driver code if it indeed
>>happens when both channels are working at the same time.
>>    
>>
>
>Thank you, this tip was really useful.
>
>Setting #define HPT_SERIALIZE_IO in hpt366.h solves the lockups on my
>machine (ABIT KT7-RAID). There seems to be a small (10-20%) performance
>penalty involved according to the benchmarks on my RAID1 setup, but that's
>acceptable.
>
>If this solves the "hdd led stays on" freezups for others with HPT370
>(rev. 3) on motherboards with possibly buggy IRQ handling, then maybe this
>option could even be made settable through kernel config, together with an
>appropriate explanation.
>
>  
>

-- 
Cohen's Law:
	There is no bottom to worse.
===========================================
This message and attachments are subject to a disclaimer. Please refer to www.it.up.ac.za/documentation/governance/disclaimer/ for full details.
Hierdie boodskap en aanhangsels is aan 'n vrywaringsklousule onderhewig. Volledige besonderhede is by www.it.up.ac.za/documentation/governance/disclaimer/ beskikbaar.
===========================================


--------------ms010202040707060907040108
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
CwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0wNDA0MDExMTQwNDJaMCMGCSqGSIb3DQEJ
BDEWBBQBJuGn0rS16RtEk+SutGdAsbqxXjBSBgkqhkiG9w0BCQ8xRTBDMAoGCCqGSIb3DQMH
MA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAHBgUrDgMCBzANBggqhkiG9w0DAgIB
KDB4BgkrBgEEAYI3EAQxazBpMGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29u
c3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwg
SXNzdWluZyBDQQIDC5XdMHoGCyqGSIb3DQEJEAILMWugaTBiMQswCQYDVQQGEwJaQTElMCMG
A1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBl
cnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0ECAwuV3TANBgkqhkiG9w0BAQEFAASCAQCdeH9M
mF8SoAJ/H9WLKu+iWUj0vOFHOarJaaboikRO78ey901fCsHf0Cc7tTIThQY3QH7iVGDwscGH
e67YdTN/uhgPQ87KffaLR6xIMx1DnJ0RrjdSpGOJ0t89Iqojo199rMqXBUJ99PzKlWZ6D/YO
wDyBB0HOvzVyhfz/MaAnY/bMorTo/35EXoLdJBHVYLwfORaZOu1xk5yk43ocxX1jzkUffVhk
YYRsRA/RFUNS4dTTLU1ak9q7kmtJvJKzgzv31ad/qgWADy0SDpVyzvbAa67TkRR/GqjsnMfr
azHQKrjbZ8vQbcc/4U7kme5LrHMVGJ+m9jLLc6E1aiE/WJBqAAAAAAAA
--------------ms010202040707060907040108--
