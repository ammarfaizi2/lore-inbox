Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946264AbWKABq6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946264AbWKABq6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 20:46:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946001AbWKABq6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 20:46:58 -0500
Received: from smtp3.netcabo.pt ([212.113.174.30]:49954 "EHLO
	exch01smtp12.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S1946005AbWKABq4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 20:46:56 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgAAAK6KR0VThFhofmdsb2JhbACMSQEB
X-IronPort-AV: i="4.09,377,1157324400"; 
   d="p7s'?scan'208"; a="131848116:sNHT23011821"
X-Antivirus-bastov-Mail-From: sergio@sergiomb.no-ip.org via bastov.localdomain
X-Antivirus-bastov: 1.25-st-qms (Clear:RC:0(83.132.128.48):SA:0(-1.3/5.0):. Processed in 3.899548 secs Process 11236)
Subject: Re: AMD X2 unsynced TSC fix?
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Reply-To: sergio@sergiomb.no-ip.org
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: Andi Kleen <ak@suse.de>, Lee Revell <rlrevell@joe-job.com>,
       Chris Friesen <cfriesen@nortel.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       john stultz <johnstul@us.ibm.com>
In-Reply-To: <20061030184155.A3790@unix-os.sc.intel.com>
References: <1161969308.27225.120.camel@mindpipe>
	 <1162009373.26022.22.camel@localhost.localdomain>
	 <1162177848.2914.13.camel@localhost.portugal>
	 <200610301623.14535.ak@suse.de>
	 <1162253008.2999.9.camel@localhost.portugal>
	 <20061030184155.A3790@unix-os.sc.intel.com>
Content-Type: multipart/signed; micalg=sha1; protocol="application/x-pkcs7-signature"; boundary="=-XQehr3lTlb7pUXFw3Iz0"
Date: Wed, 01 Nov 2006 01:46:48 +0000
Message-Id: <1162345608.2961.7.camel@localhost.portugal>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
X-OriginalArrivalTime: 01 Nov 2006 01:46:55.0313 (UTC) FILETIME=[9C505410:01C6FD57]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-XQehr3lTlb7pUXFw3Iz0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On Mon, 2006-10-30 at 18:41 -0800, Siddha, Suresh B wrote:
> On Tue, Oct 31, 2006 at 12:03:28AM +0000, Sergio Monteiro Basto wrote:
> > time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
> > time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
> > time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
> > time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
>=20
> Is this the reason why you are saying your system has unsynchronized TSC?
> Some where in this thread, you mentioned that Lost ticks happen even
> when you use  "notsc"
>=20
> This sounds to me as a different problem. Can you send us the output
> of /proc/interrupts?

/proc/interrupts on kernel 2.6.18
http://bugzilla.kernel.org/attachment.cgi?id=3D9384&action=3Dview
dmesg w/o notsc kernel 2.6.19-rc4
http://bugzilla.kernel.org/attachment.cgi?id=3D9385&action=3Dview
/proc/interrupts kernel 2.6.19-rc4=20
http://bugzilla.kernel.org/attachment.cgi?id=3D9386&action=3Dview
dmesg w/ notsc kernel 2.6.19-rc4=20
http://bugzilla.kernel.org/attachment.cgi?id=3D9387&action=3Dview
/proc/interrupts kernel 2.6.19-rc4
http://bugzilla.kernel.org/attachment.cgi?id=3D9388&action=3Dview
list of interrupts give by windows XP
http://bugzilla.kernel.org/attachment.cgi?id=3D9389&action=3Dview

Let me know, if I can help on something.
Thanks, =20
--=20
S=E9rgio M.B.

--=-XQehr3lTlb7pUXFw3Iz0
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
SIb3DQEJBTEPFw0wNjExMDEwMTQ2NDRaMCMGCSqGSIb3DQEJBDEWBBTNpZOncyIHvfs0rztts5lJ
Z1UN+jANBgkqhkiG9w0BAQEFAASCAQBUOgbxzJWgmBXQ6atJF9vJjaQf0J4PewesmvlC0b8IFGM6
vq/gqOizfPEYYTkcDgrIHbHhW7x8kDe01wj1Gf3mZKUYrONP6U4byIz+snGqrJJMsyGl9XGbyKjl
xmrEuvvMk+yuNr8hVisY3OybjMnYDROHpLxRhOCO3mE+mH1OjWfO+rOhSbdSzzBGz5waKv26bgME
clVZaKZUFnZuO+MjkOvJ9LCReQhiVjsbUqXOL42E50tuHJJjvqY9mF9FiL9wbUGwKVbgzSzaUJzk
nfRcl08SaWTF7cUDJnqgss/cFCbRLWm/Jwemtf1sIstJgYSAFCfFWAVbl+LiPC5epdFjAAAAAAAA



--=-XQehr3lTlb7pUXFw3Iz0--
