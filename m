Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750989AbVLBTow@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750989AbVLBTow (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 14:44:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750984AbVLBTow
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 14:44:52 -0500
Received: from router.polyware.nl ([80.89.239.1]:14301 "EHLO
	nathan.polyware.nl") by vger.kernel.org with ESMTP id S1750983AbVLBTov
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 14:44:51 -0500
Date: Fri, 2 Dec 2005 20:37:26 +0100
From: Pauline Middelink <middelink@polyware.nl>
To: Michael Krufky <mkrufky@m1k.net>
Cc: gcoady@gmail.com, Mauro Carvalho Chehab <mchehab@brturbo.com.br>,
       Linus Torvalds <torvalds@osdl.org>,
       Eyal Lebedinsky <eyal@eyal.emu.id.au>,
       list linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.15-rc4
Message-ID: <20051202193725.GA32346@polyware.nl>
Mail-Followup-To: Pauline Middelink <middelink@polyware.nl>,
	Michael Krufky <mkrufky@m1k.net>, gcoady@gmail.com,
	Mauro Carvalho Chehab <mchehab@brturbo.com.br>,
	Linus Torvalds <torvalds@osdl.org>,
	Eyal Lebedinsky <eyal@eyal.emu.id.au>,
	list linux-kernel <linux-kernel@vger.kernel.org>
References: <1133445903.16820.1.camel@localhost> <Pine.LNX.4.64.0512010759571.3099@g5.osdl.org> <6f6293f10512011112m6e50fe0ejf0aa5ba9d09dca1e@mail.gmail.com> <Pine.LNX.4.64.0512011125280.3099@g5.osdl.org> <438F6DFF.2040603@eyal.emu.id.au> <Pine.LNX.4.64.0512011347290.3099@g5.osdl.org> <862vo198it7molqvq5ign38qmncmjk3bo5@4ax.com> <1133523910.6842.3.camel@localhost> <k611p19dv1peeb38a4krlqnib1f0pemj4b@4ax.com> <43908900.5070504@m1k.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
	micalg=sha1; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline
In-Reply-To: <43908900.5070504@m1k.net>
User-Agent: Mutt/1.5.4i
X-Polyware-MailScanner: Found to be clean
X-MailScanner-From: middelin@nathan.polyware.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 02 Dec 2005 around 12:48:48 -0500, Michael Krufky wrote:

> >I gave up on it, offered to kill it for 2.6.14-rc2-mm1, you want a=20
> >freshened removal patch?
> >=20
> >
> No, Mauro, Pauline already told us that she's working on it.....
>=20
> Poor Pauline, about once a month someone wants to nuke ZR36120.

Grumble, its a conspiracy :)

> Instead of nuking it, let's just mark it BROKEN for now...

That would be preferable.

> Pauline, what's the status?

For one, the machine I was testing with made proper use of large memory
pointers to stribble all over its memory and erase essencial parts of
its disk structures. :(

Half way I would say. During the upcoming free days I hope to find the
time to finish it up so the driver works with current i2c, v4l and
memory.


    Met vriendelijke groet,
        Pauline Middelink
--=20
GPG Key fingerprint =3D 2D5B 87A7 DDA6 0378 5DEA  BD3B 9A50 B416 E2D0 C3C2
For more details look at my website http://www.polyware.nl/~middelink

--jRHKVT23PllUwdXP
Content-Type: application/x-pkcs7-signature
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIII4AYJKoZIhvcNAQcCoIII0TCCCM0CAQExCzAJBgUrDgMCGgUAMAsGCSqGSIb3DQEHAaCC
BmQwggMdMIIChqADAgECAgMN/fkwDQYJKoZIhvcNAQEEBQAwYjELMAkGA1UEBhMCWkExJTAj
BgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQ
ZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBMB4XDTA1MDIwODE3NDA1NloXDTA2MDIwODE3
NDA1NlowgYwxEjAQBgNVBAQTCU1pZGRlbGluazEiMCAGA1UEKhMZSmVhbmV0dGUgUGF1bGlu
ZSBNaWNoZWxsZTEsMCoGA1UEAxMjSmVhbmV0dGUgUGF1bGluZSBNaWNoZWxsZSBNaWRkZWxp
bmsxJDAiBgkqhkiG9w0BCQEWFW1pZGRlbGlua0Bwb2x5d2FyZS5ubDCCASIwDQYJKoZIhvcN
AQEBBQADggEPADCCAQoCggEBAL4NQanXRfofWnd3wkQoY3k5dT0wlPRkDyUHKwKwxGz7U0ff
B3lC84Y5feIQJaaeoqt1E4JirENiO+9OdUB561h1+zDGlp1ekoKKpMjHXBWuiIxBiYbIhLdR
FxufocufSg8aP5bx5vnBY7Hh+PbYacEjK9Qa/7tsECFWUDnUjPNcsgUENrc8iPsmgWq2apql
mApRE0Mx+ORvpPGz5PMPwqlNJ3wh7XHiqxoDfvtKEdyg+KladNZlcRKthmKbBY6LX2GQxZha
iPfmkReWQJVCiqaisxoxpPBvuG3zJfcY6Y99/VlBDuIgH1nItI+3cNorfmrp4QKkHGyQ7mlR
vPfNf58CAwEAAaMyMDAwIAYDVR0RBBkwF4EVbWlkZGVsaW5rQHBvbHl3YXJlLm5sMAwGA1Ud
EwEB/wQCMAAwDQYJKoZIhvcNAQEEBQADgYEAn1tyxPPh8HNcHXVa4vvVs2+jnNLHCxocDP5w
ICbTSCiGW8+J9/bhaOLnVrPMlXlegfD2+5ukErgb8Bn5g/S4p/egaSYuale9lLPLAmfdJVOa
ugr2ywICOTxT8dAKpwHDM3TsFFLFUr7DmKNAwc7PT2xxBFp159Iy8MTpbJTUJ/kwggM/MIIC
qKADAgECAgENMA0GCSqGSIb3DQEBBQUAMIHRMQswCQYDVQQGEwJaQTEVMBMGA1UECBMMV2Vz
dGVybiBDYXBlMRIwEAYDVQQHEwlDYXBlIFRvd24xGjAYBgNVBAoTEVRoYXd0ZSBDb25zdWx0
aW5nMSgwJgYDVQQLEx9DZXJ0aWZpY2F0aW9uIFNlcnZpY2VzIERpdmlzaW9uMSQwIgYDVQQD
ExtUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgQ0ExKzApBgkqhkiG9w0BCQEWHHBlcnNvbmFs
LWZyZWVtYWlsQHRoYXd0ZS5jb20wHhcNMDMwNzE3MDAwMDAwWhcNMTMwNzE2MjM1OTU5WjBi
MQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEs
MCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0EwgZ8wDQYJKoZI
hvcNAQEBBQADgY0AMIGJAoGBAMSmPFVzVftOucqZWh5owHUEcJ3f6f+jHuy9zfVb8hp2vX8M
OmHyv1HOAdTlUAow1wJjWiyJFXCO3cnwK4Vaqj9xVsuvPAsH5/EfkTYkKhPPK9Xzgnc9A74r
/rsYPge/QIACZNenprufZdHFKlSFD0gEf6e20TxhBEAeZBlyYLf7AgMBAAGjgZQwgZEwEgYD
VR0TAQH/BAgwBgEB/wIBADBDBgNVHR8EPDA6MDigNqA0hjJodHRwOi8vY3JsLnRoYXd0ZS5j
b20vVGhhd3RlUGVyc29uYWxGcmVlbWFpbENBLmNybDALBgNVHQ8EBAMCAQYwKQYDVR0RBCIw
IKQeMBwxGjAYBgNVBAMTEVByaXZhdGVMYWJlbDItMTM4MA0GCSqGSIb3DQEBBQUAA4GBAEiM
0VCD6gsuzA2jZqxnD3+vrL7CF6FDlpSdf0whuPg2H6otnzYvwPQcUCCTcDz9reFhYsPZOhl+
hLGZGwDFGguCdJ4lUJRix9sncVcljd2pnDmOjCBPZV+V2vf3h9bGCE6u9uo05RAaWzVNd+NW
IXiC3CEZNd4ksdMdRv9dX2VPMYICRDCCAkACAQEwaTBiMQswCQYDVQQGEwJaQTElMCMGA1UE
ChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNv
bmFsIEZyZWVtYWlsIElzc3VpbmcgQ0ECAw39+TAJBgUrDgMCGgUAoIGxMBgGCSqGSIb3DQEJ
AzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTA1MTIwMjE5MzcyNVowIwYJKoZIhvcN
AQkEMRYEFBBJ9S6mVmUFR8XGyAtNj/hFr+46MFIGCSqGSIb3DQEJDzFFMEMwCgYIKoZIhvcN
AwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqGSIb3DQMC
AgEoMA0GCSqGSIb3DQEBAQUABIIBAIC5118BRvYxvbMAyJk7CFowoLllnqdjdAjNuJmNtxzk
U86kC+Vl1eTehxGpPHBUVPiOimH5edfhBUMzQyqyXosoqj5fS+LJRyNzGbJgIySiUxL4gCGj
gcaggbVAhGCJPsXfeW6HmZpg8UTA8BHkI2+XyF/2CzCNPskUVhtZc2LXw9NAZwFnlByCZuCJ
NqpNzdv1UKiOBnR36pX8eie2iOWA4ROjbzB3hNGUUmqWeY/6iGwEtPJfD5A3A9p+t0onhDFF
cGbp/YcFk8MG7KC/I2e7wSpAHNbJokx1BC6uSy9YHkMZXLxCU5lEbb8uO98tZEMf7iduEQJj
H/7mL+ics6k=

--jRHKVT23PllUwdXP--
