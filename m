Return-Path: <linux-kernel-owner+w=401wt.eu-S965144AbXAJWqI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965144AbXAJWqI (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 17:46:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965164AbXAJWqI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 17:46:08 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:10218 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965144AbXAJWqF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 17:46:05 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer;
        b=bSXQ8higOxGEXdRgcj36r2dVnzNvRqcc6id6ZtNXgW/oWW4J6j/YT/TkhS9eXwGjM6XNjo/I3e/z/0VBxrcQ/Y9CVPydCgF0QVjmxrG6J5sD+NlPqVj1/MkXaanEzvO/62OPZHe0TFlDTPpU0zoh7TYccZRsfpFs9kynh79idw0=
Subject: Re: D-Link DFE-580TX adapter problems
From: Anders Karlsson <trudheim@gmail.com>
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20070109230945.GA27738@electric-eye.fr.zoreil.com>
References: <1168177183.15748.4.camel@lenin>
	 <20070108201257.GA28440@electric-eye.fr.zoreil.com>
	 <1168297269.27317.7.camel@lenin>
	 <20070109230945.GA27738@electric-eye.fr.zoreil.com>
Content-Type: multipart/signed; micalg=sha1; protocol="application/x-pkcs7-signature"; boundary="=-9WMcnUuFFLzAJvziWJ99"
Date: Wed, 10 Jan 2007 22:45:59 +0000
Message-Id: <1168469159.12223.7.camel@lenin>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-9WMcnUuFFLzAJvziWJ99
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-01-10 at 00:09 +0100, Francois Romieu wrote:
> Anders Karlsson <trudheim@gmail.com> :
> [...]
> > PCI ID's in there, so this driver *should* work. In the past, it *has*
> > worked, but that was on a older kernel (2.6.8 or thereabouts).
>=20
> No datapoint beyond 2.6.12 ? It would make thinks easier (for you :o} ).

Unfortunately the adapter has been sitting idle in an antistat bag for
some time, and last time I used it was with a Debian Sarge install. I
can try some older Ubuntu LiveCD's (will take some time to download
though) and try and get a point in time where it works.

> > If there are patches or tweaks to the driver, I am willing and able to
> > test them.
>=20
> Compressed patch attached. Apply with patch -R and see if it behaves
> differently. No warranty.

Many thanks for the patch. Applied to 2.6.20-rc4, built as K7-SMP, but
unfortunately it behaves no different compared to stock 2.6.20-rc4. If
you have any other ideas, I am game for some testing. Meanwhile, I'll
grab some LiveCD's to get data-points.

Cheers!

--=20
Anders Karlsson <trudheim@gmail.com>

--=-9WMcnUuFFLzAJvziWJ99
Content-Type: application/x-pkcs7-signature; name=smime.p7s
Content-Disposition: attachment; filename=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIILeDCCBbgw
ggOgoAMCAQICAQIwDQYJKoZIhvcNAQEFBQAwgawxCzAJBgNVBAYTAkdCMRIwEAYDVQQIEwlIYW1w
c2hpcmUxFDASBgNVBAcTC0Zhcm5ib3JvdWdoMSAwHgYDVQQKExdUcnVkaGVpbSBUZWNobm9sb2d5
IEx0ZDELMAkGA1UECxMCSVQxIDAeBgNVBAMTF1RydWRoZWltIFRlY2hub2xvZ3kgTHRkMSIwIAYJ
KoZIhvcNAQkBFhNhbmRlcnNAdHJ1ZGhlaW0uY29tMB4XDTA2MDQwNjExMDUzMVoXDTA3MDQwNjEx
MDUzMVowdDELMAkGA1UEBhMCR0IxEjAQBgNVBAgTCUhhbXBzaGlyZTEUMBIGA1UEBxMLRmFybmJv
cm91Z2gxGDAWBgNVBAMTD0FuZGVycyBLYXJsc3NvbjEhMB8GCSqGSIb3DQEJARYSdHJ1ZGhlaW1A
Z21haWwuY29tMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQChDHgmRtARF5DIyIZT3vcQxedO
4UOtOlnTNqxq2k6O+YBvx1RqxtYRTmi/L9x94ypFFzjCBL86hTjz40+eNLAmpvvgVGKYlCBqMnkV
Rf+r3/Dua+gbnnc4BrerX8u5CWilpRCpnppnqpWDNb4qfex6uGoQLE3yb82QP/9MQY6INQIDAQAB
o4IBnjCCAZowCQYDVR0TBAIwADARBglghkgBhvhCAQEEBAMCBLAwKwYJYIZIAYb4QgENBB4WHFRp
bnlDQSBHZW5lcmF0ZWQgQ2VydGlmaWNhdGUwHQYDVR0OBBYEFFGFuxxc26PXYSBhdMJWIwPDKS71
MIHhBgNVHSMEgdkwgdaAFEtrXmb9x2d8erFrwERh1K+Hyd8soYGypIGvMIGsMQswCQYDVQQGEwJH
QjESMBAGA1UECBMJSGFtcHNoaXJlMRQwEgYDVQQHEwtGYXJuYm9yb3VnaDEgMB4GA1UEChMXVHJ1
ZGhlaW0gVGVjaG5vbG9neSBMdGQxCzAJBgNVBAsTAklUMSAwHgYDVQQDExdUcnVkaGVpbSBUZWNo
bm9sb2d5IEx0ZDEiMCAGCSqGSIb3DQEJARYTYW5kZXJzQHRydWRoZWltLmNvbYIJAPVcTlQVuQgv
MB4GA1UdEgQXMBWBE2FuZGVyc0B0cnVkaGVpbS5jb20wHQYDVR0RBBYwFIESdHJ1ZGhlaW1AZ21h
aWwuY29tMAsGA1UdDwQEAwIFoDANBgkqhkiG9w0BAQUFAAOCAgEAXmqI33p/M6E12bBEavfPJB7O
lj6Do1INmd6APMvOajRn4GW22GtN/ZEDO5y3r/qRmg+XI+iR7wN26zdDdXrujV9LUmajAtqT7n24
wLu6F2IOXwDg6Q/fh8yKnofMgL9MPi2l/MHEUVfV7ab2cv5pSp8ey5t34JB0kECjJozao/vpRF70
6RJuTBK7Ol0uhWEaUZbaQhkEFg4OY+a8pHEbGvwZ2Fltjd5bBL82iQjndxNUv3bHERuf5eNIPP+1
cDZlOTM/qXfeKcIlOtdcBoUOqWd1QxFtEG/n7e8pdX1IYkW7Mx0nWjUoOBtGydf5a1F09OoJBpiu
c/2tg9MTK4vBzjFRHkjdFaTSCSkavfJOYshZhI/AHQUMNRfFmBq/Infcb9MHFJ2NNgU5gcFte54B
vxJEXX3hqpg6f1ey3UDZPB38vS7+O8UI4ptDceoe7xzwbIjVvMi+GJv/DVvA1WS/radyuCFkgBoG
2y++tv3yiTLu+T4WVxvIqz4PtDRHau44rymwvHaVBM6fpWjjtTxzcvoUIM8y3kZKyhVosKh5w7WO
AXKPZStrYIA0q3oReHaa2p1H8U5faIiWp5dOW85AGXAiYomSyPNvtv6OuG75oFqKPteXQTtJ4oBX
64Bv9oynOiBShecAoqJJ48r5eq1hcf2u+D/8lHC+T5D7RA21O3wwggW4MIIDoKADAgECAgECMA0G
CSqGSIb3DQEBBQUAMIGsMQswCQYDVQQGEwJHQjESMBAGA1UECBMJSGFtcHNoaXJlMRQwEgYDVQQH
EwtGYXJuYm9yb3VnaDEgMB4GA1UEChMXVHJ1ZGhlaW0gVGVjaG5vbG9neSBMdGQxCzAJBgNVBAsT
AklUMSAwHgYDVQQDExdUcnVkaGVpbSBUZWNobm9sb2d5IEx0ZDEiMCAGCSqGSIb3DQEJARYTYW5k
ZXJzQHRydWRoZWltLmNvbTAeFw0wNjA0MDYxMTA1MzFaFw0wNzA0MDYxMTA1MzFaMHQxCzAJBgNV
BAYTAkdCMRIwEAYDVQQIEwlIYW1wc2hpcmUxFDASBgNVBAcTC0Zhcm5ib3JvdWdoMRgwFgYDVQQD
Ew9BbmRlcnMgS2FybHNzb24xITAfBgkqhkiG9w0BCQEWEnRydWRoZWltQGdtYWlsLmNvbTCBnzAN
BgkqhkiG9w0BAQEFAAOBjQAwgYkCgYEAoQx4JkbQEReQyMiGU973EMXnTuFDrTpZ0zasatpOjvmA
b8dUasbWEU5ovy/cfeMqRRc4wgS/OoU48+NPnjSwJqb74FRimJQgajJ5FUX/q9/w7mvoG553OAa3
q1/LuQlopaUQqZ6aZ6qVgzW+Kn3serhqECxN8m/NkD//TEGOiDUCAwEAAaOCAZ4wggGaMAkGA1Ud
EwQCMAAwEQYJYIZIAYb4QgEBBAQDAgSwMCsGCWCGSAGG+EIBDQQeFhxUaW55Q0EgR2VuZXJhdGVk
IENlcnRpZmljYXRlMB0GA1UdDgQWBBRRhbscXNuj12EgYXTCViMDwyku9TCB4QYDVR0jBIHZMIHW
gBRLa15m/cdnfHqxa8BEYdSvh8nfLKGBsqSBrzCBrDELMAkGA1UEBhMCR0IxEjAQBgNVBAgTCUhh
bXBzaGlyZTEUMBIGA1UEBxMLRmFybmJvcm91Z2gxIDAeBgNVBAoTF1RydWRoZWltIFRlY2hub2xv
Z3kgTHRkMQswCQYDVQQLEwJJVDEgMB4GA1UEAxMXVHJ1ZGhlaW0gVGVjaG5vbG9neSBMdGQxIjAg
BgkqhkiG9w0BCQEWE2FuZGVyc0B0cnVkaGVpbS5jb22CCQD1XE5UFbkILzAeBgNVHRIEFzAVgRNh
bmRlcnNAdHJ1ZGhlaW0uY29tMB0GA1UdEQQWMBSBEnRydWRoZWltQGdtYWlsLmNvbTALBgNVHQ8E
BAMCBaAwDQYJKoZIhvcNAQEFBQADggIBAF5qiN96fzOhNdmwRGr3zyQezpY+g6NSDZnegDzLzmo0
Z+BltthrTf2RAzuct6/6kZoPlyPoke8Ddus3Q3V67o1fS1JmowLak+59uMC7uhdiDl8A4OkP34fM
ip6HzIC/TD4tpfzBxFFX1e2m9nL+aUqfHsubd+CQdJBAoyaM2qP76URe9OkSbkwSuzpdLoVhGlGW
2kIZBBYODmPmvKRxGxr8GdhZbY3eWwS/NokI53cTVL92xxEbn+XjSDz/tXA2ZTkzP6l33inCJTrX
XAaFDqlndUMRbRBv5+3vKXV9SGJFuzMdJ1o1KDgbRsnX+WtRdPTqCQaYrnP9rYPTEyuLwc4xUR5I
3RWk0gkpGr3yTmLIWYSPwB0FDDUXxZgavyJ33G/TBxSdjTYFOYHBbXueAb8SRF194aqYOn9Xst1A
2Twd/L0u/jvFCOKbQ3HqHu8c8GyI1bzIvhib/w1bwNVkv62ncrghZIAaBtsvvrb98oky7vk+Flcb
yKs+D7Q0R2ruOK8psLx2lQTOn6Vo47U8c3L6FCDPMt5GSsoVaLCoecO1jgFyj2Ura2CANKt6EXh2
mtqdR/FOX2iIlqeXTlvOQBlwImKJksjzb7b+jrhu+aBaij7Xl0E7SeKAV+uAb/aMpzogUoXnAKKi
SePK+XqtYXH9rvg//JRwvk+Q+0QNtTt8MYIDSDCCA0QCAQEwgbIwgawxCzAJBgNVBAYTAkdCMRIw
EAYDVQQIEwlIYW1wc2hpcmUxFDASBgNVBAcTC0Zhcm5ib3JvdWdoMSAwHgYDVQQKExdUcnVkaGVp
bSBUZWNobm9sb2d5IEx0ZDELMAkGA1UECxMCSVQxIDAeBgNVBAMTF1RydWRoZWltIFRlY2hub2xv
Z3kgTHRkMSIwIAYJKoZIhvcNAQkBFhNhbmRlcnNAdHJ1ZGhlaW0uY29tAgECMAkGBSsOAwIaBQCg
ggHrMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTA3MDExMDIyNDU1
NlowIwYJKoZIhvcNAQkEMRYEFAOW0kjCC2TEHZw1BLpVLNWY9MPbMIHDBgkrBgEEAYI3EAQxgbUw
gbIwgawxCzAJBgNVBAYTAkdCMRIwEAYDVQQIEwlIYW1wc2hpcmUxFDASBgNVBAcTC0Zhcm5ib3Jv
dWdoMSAwHgYDVQQKExdUcnVkaGVpbSBUZWNobm9sb2d5IEx0ZDELMAkGA1UECxMCSVQxIDAeBgNV
BAMTF1RydWRoZWltIFRlY2hub2xvZ3kgTHRkMSIwIAYJKoZIhvcNAQkBFhNhbmRlcnNAdHJ1ZGhl
aW0uY29tAgECMIHFBgsqhkiG9w0BCRACCzGBtaCBsjCBrDELMAkGA1UEBhMCR0IxEjAQBgNVBAgT
CUhhbXBzaGlyZTEUMBIGA1UEBxMLRmFybmJvcm91Z2gxIDAeBgNVBAoTF1RydWRoZWltIFRlY2hu
b2xvZ3kgTHRkMQswCQYDVQQLEwJJVDEgMB4GA1UEAxMXVHJ1ZGhlaW0gVGVjaG5vbG9neSBMdGQx
IjAgBgkqhkiG9w0BCQEWE2FuZGVyc0B0cnVkaGVpbS5jb20CAQIwDQYJKoZIhvcNAQEBBQAEgYCf
cPDaD9eg2e1euQRrw7zsTQJSnHKyOyosGqw2h6fd0aw977UdbIVpivYqvGSHFcTgLjcP+oFQdleM
DKMB4Yu9i9pp7g3lDZMSNmhVtYdcHyAEboNeUW91NCoCsL3LPJwV20mNMaM4zf0rBLoh3F/1prpG
rPBN1lZDLRSOqbRRSAAAAAAAAA==


--=-9WMcnUuFFLzAJvziWJ99--

