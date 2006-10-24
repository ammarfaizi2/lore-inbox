Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964925AbWJXB2U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964925AbWJXB2U (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 21:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964939AbWJXB2U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 21:28:20 -0400
Received: from smtp4.netcabo.pt ([212.113.174.31]:47013 "EHLO
	exch01smtp11.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S964925AbWJXB2T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 21:28:19 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ao8CAIYIPUVThFhodGdsb2JhbACBTIpl
X-Antivirus-bastov-Mail-From: sergio@sergiomb.no-ip.org via bastov.localdomain
X-Antivirus-bastov: 1.25-st-qms (Clear:RC:0(83.132.129.202):SA:0(0.6/5.0):. Processed in 17.855539 secs Process 20501)
Subject: Re: -rt7 announcement? (was Re: 2.6.18-rt6) and more info about a
	compile error
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Reply-To: sergio@sergiomb.no-ip.org
To: Lee Revell <rlrevell@joe-job.com>
Cc: tglx@linutronix.de, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, John Stultz <johnstul@us.ibm.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>, Mike Galbraith <efault@gmx.de>,
       Daniel Walker <dwalker@mvista.com>,
       Manish Lachwani <mlachwani@mvista.com>, bastien.dugue@bull.net
In-Reply-To: <1161636049.3982.18.camel@mindpipe>
References: <20061018083921.GA10993@elte.hu>
	 <1161356444.15860.327.camel@mindpipe>  <1161621286.2835.3.camel@mindpipe>
	 <1161628539.22373.36.camel@localhost.localdomain>
	 <1161635161.2948.12.camel@localhost.portugal>
	 <1161636049.3982.18.camel@mindpipe>
Content-Type: multipart/signed; micalg=sha1; protocol="application/x-pkcs7-signature"; boundary="=-bnjqOrytiddCrT4O8ycV"
Date: Tue, 24 Oct 2006 02:26:46 +0100
Message-Id: <1161653206.2996.17.camel@localhost.portugal>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
X-OriginalArrivalTime: 24 Oct 2006 01:28:17.0645 (UTC) FILETIME=[AED3B9D0:01C6F70B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-bnjqOrytiddCrT4O8ycV
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On Mon, 2006-10-23 at 16:40 -0400, Lee Revell wrote:
> On Mon, 2006-10-23 at 21:26 +0100, Sergio Monteiro Basto wrote:
> > rt7 should be to be applied on 2.6.18.1=20
> > still for 2.6.18=20
> >=20
>=20
> The -rt patch has always been against the most recent base kernel.  It
> could be rebased against -stable but that would be more work for the
> maintainers...
=20
For me the most recent stable kernel is 2.6.18.1.=20
Normally change for .1 are very small but in this case I got 1, just 1,
reject which I don't know to fix and prefer don't try it. My luck is the
rej in a sparc arch and I can ignore it.

I got this compile error if I don't use CONFIG_PREEMPT_BKL in .config

kernel/rtmutex.c:938:48: error: macro "rt_release_bkl" passed 2
arguments, but takes just 1
kernel/rtmutex.c: In function 'rt_mutex_slowlock':
kernel/rtmutex.c:938: error: 'rt_release_bkl' undeclared (first use in
this function)
kernel/rtmutex.c:938: error: (Each undeclared identifier is reported
only once
kernel/rtmutex.c:938: error: for each function it appears in.)


Thanks,=20
> Lee
>=20
--=20
S=E9rgio M.B.

--=-bnjqOrytiddCrT4O8ycV
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
SIb3DQEJBTEPFw0wNjEwMjQwMTI2NDFaMCMGCSqGSIb3DQEJBDEWBBQ7CCFpkglY8rscSFXhpOOg
FVvxVTANBgkqhkiG9w0BAQEFAASCAQB3MvYXqu1PHtOF8cBsZKTtvketgzgTKYP28YAUB4pnUVLL
NlBysIp9Uev8TuNGOLuXnyEHZqtrP141kEHwuQGuFlwOxXs83BFwfyLukKhpa6RSdUCu2+cj27zX
Zi6ecXO8oM0doGQmMukboH3iyWruiO0HjcSzPoM7ro/u06s5pa+BcE9jEUqgBQNMFZOhuR/FU4nR
xC7HJwTLknY3n3hxQaJEBT4vUv7DdiHa9RDlCAWfhocdRbW7qPCamFMCnK2M+VSFfywXw2N5XTYa
epqAdd39Qs3uNmHQkHVlmmH5rHkd0hv5uCfFtBmMCPbKFljw3rBTzsjw/lreDsVzQjAJAAAAAAAA



--=-bnjqOrytiddCrT4O8ycV--
