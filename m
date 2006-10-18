Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945909AbWJRXpc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945909AbWJRXpc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 19:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945910AbWJRXpc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 19:45:32 -0400
Received: from smtp4.netcabo.pt ([212.113.174.31]:16842 "EHLO
	exch01smtp11.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S1945909AbWJRXpb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 19:45:31 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AY8CAKZYNkWBSokpgTIB
X-Antivirus-bastov-Mail-From: sergio@sergiomb.no-ip.org via bastov.localdomain
X-Antivirus-bastov: 1.25-st-qms (Clear:RC:0(83.132.129.239):SA:0(-1.3/5.0):. Processed in 2.696384 secs Process 25333)
Subject: Re: SMP broken on pre-ACPI machine.
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Reply-To: sergio@sergiomb.no-ip.org
To: Dave Jones <davej@redhat.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       acpi-devel@lists.sourceforge.net
In-Reply-To: <20061018222433.GA4770@redhat.com>
References: <20061018222433.GA4770@redhat.com>
Content-Type: multipart/signed; micalg=sha1; protocol="application/x-pkcs7-signature"; boundary="=-1zSvty/nPmUmHh/Vlfv+"
Date: Thu, 19 Oct 2006 00:45:21 +0100
Message-Id: <1161215121.17601.4.camel@localhost.portugal>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
X-OriginalArrivalTime: 18 Oct 2006 23:45:27.0895 (UTC) FILETIME=[7D4DD670:01C6F30F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-1zSvty/nPmUmHh/Vlfv+
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-10-18 at 18:24 -0400, Dave Jones wrote:
> I've been chasing a bug that got filed against the Fedora kernel
> a while back:  https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=3D199=
052
> This is a dual pentium pro from an era before we had ACPI, and
> it seems to be falling foul of this test in smpboot.c  ..
>=20
>     if (!smp_found_config && !acpi_lapic) {
>         printk(KERN_NOTICE "SMP motherboard not detected.\n");
>         smpboot_clear_io_apic_irqs();
>         phys_cpu_present_map =3D physid_mask_of_physid(0);
>         if (APIC_init_uniprocessor())
>             printk(KERN_NOTICE "Local APIC not detected."
>                        " Using dummy APIC emulation.\n");
>         map_cpu_to_logical_apicid();
>         cpu_set(0, cpu_sibling_map[0]);
>         cpu_set(0, cpu_core_map[0]);
>         return;
>     }
>=20
>=20
> My initial reaction is that the !acpi_lapic test should be conditional
> on some variable that gets set if the ACPI parsing actually succeeded.
>=20
> Thoughts?
>=20
> 	Dave
>=20

acpi=3Doff ? this machine should work with APM. BTW, so time ago, this
machine would enter in ACPI blacklist (by the year of bios) and ACPI was
turned off automatically.=20

--=20
S=E9rgio M.B.

--=-1zSvty/nPmUmHh/Vlfv+
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
SIb3DQEJBTEPFw0wNjEwMTgyMzQ1MTdaMCMGCSqGSIb3DQEJBDEWBBROMhev0ss/LB3qg2j0hIEh
ifzU/TANBgkqhkiG9w0BAQEFAASCAQAkyxrrnRmkGiA/KOCzK9lbNOskHxTXaE9mYDMyBYjBZiBw
RmrHyLMpD6oKCWtnZN/SEThPb3WtIIbdB1Kis7hegpWsyB8vOrfNeLfeS14fSCqsSk+kiK6449Gu
ukp00O5SGm9SQy7QpBsKbpuqYqFp7/+4ZZpMLHcjxBI1Vg5j/jLiaabGSeGL2Iv7TtfyYvvMLWpU
k9+jerYWaqYdZU1Yl5qlBWln/8PeAf7E9e6fH0XkZhFOJf9KhrzJRa5I3Ks3yevZ/DirTvNq+y5s
yNt7NwvuRxUqKI01gUnZVbZWtbduNwxndRPdgxz8IrsQ972uncERKIsnM1cdqfhm553tAAAAAAAA



--=-1zSvty/nPmUmHh/Vlfv+--
