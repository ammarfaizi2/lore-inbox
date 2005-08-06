Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262024AbVHFIEo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262024AbVHFIEo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 04:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261259AbVHFIEn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 04:04:43 -0400
Received: from ctb-mesg5.saix.net ([196.25.240.85]:43428 "EHLO
	ctb-mesg5.saix.net") by vger.kernel.org with ESMTP id S262024AbVHFIBz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 04:01:55 -0400
Message-ID: <42F46E64.90502@cs.up.ac.za>
Date: Sat, 06 Aug 2005 10:01:40 +0200
From: Jaco Kroon <jkroon@cs.up.ac.za>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.10) Gecko/20050804
X-Accept-Language: en, af, en-gb, en-us
MIME-Version: 1.0
To: Mike Galbraith <efault@gmx.de>
Cc: linux-kernel@vger.kernel.org, techteam@cs.up.ac.za
Subject: Re: sporadic "freezes" on amd64 (GA K8NF)
References: <5.2.1.1.2.20050806081410.00bf46b8@pop.gmx.net>
In-Reply-To: <5.2.1.1.2.20050806081410.00bf46b8@pop.gmx.net>
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms050900010702070904060306"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms050900010702070904060306
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Mike Galbraith wrote:
> At 10:33 PM 8/5/2005 +0200, you wrote:
> 
>> Hello all,
>>
>> I'm absolutely stumped with this one.  We are still having problems
>> deciding whether this is a software problem or a hardware problem.
> 
> Given the number of kernels it freezes under, I'd say hardware.

That is what we thought too, initially.  I'm still tending towards this
option but we just don't know any more.  Considering that Windows runs
just fine.  Even under heavy workload.  Although - compiling tends to be
some of the most rigurous hardware chowing work there is (Used to use
compiling glibc as a test on how stable my old pentium 90 was - usually
had to cross-compile it in the end).  Anyway, we're unable to get
Windows to compile for extended periods of time, mostly because we
simply do not have any projects available to us that is big enough.  Can
always try installing cygwin and using one or another opensource project
(MySQL for example).

>>   This
>> particular box (specs lower down) just freezes up sporadically when in
>> Linux.
> 
> You failed to describe the workload.

Of course I did.  Compiling the kernel.  It's probably the most reliable
way of crashing it.  make mrproper && make allyesconfig && make - give
it about 2 to 5 minutes and it's dead.  We also got in a couple of times
to die within about 10 seconds, as in KSYM was the only thing that
remained that still had to pass, so we would type make, it would do a
couple of checks (CHK I assume is for check) and the KSYM, at which
point it would just die.

>> Normally it just stops responding entirely.  As in one moment it's still
>> outputting and the next there is nothing.  Then once, (twice actually),
>> we actually got a kernel panic, I've taken a picture which can be found
>> at http://www.kroon.co.za/images/kernel_panic_amd64.jpg (Apologies for
>> the quality - phones aren't good at taking them).
> 
> Try a serial console for capture.

I never did manage to get that right.  I've still got the cable from my
previous attempts, guess I'll be trying again.

>>   From this panic (and
>> the other which I had no way of capturing at the time) it looks like a
>> bug somewhere when accessing the hard drive.  The one here was on
>> reiserfs the other was on ext3.
> 
> 
> The first thing than comes to mind is cooling.  The next thing I'd
> suspect is the power supply.  After verifying that these are in fact not
> the problem, I'd try a different disk controller.

I doubt it's cooling - after resetting the BIOS claims <40 degree
celcius temperatures so I'll try another power supply.  Although, I
suspect it already is a 400W in there.

Jaco

--------------ms050900010702070904060306
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIII7TCC
AtEwggI6oAMCAQICAw3p3jANBgkqhkiG9w0BAQQFADBiMQswCQYDVQQGEwJaQTElMCMGA1UE
ChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNv
bmFsIEZyZWVtYWlsIElzc3VpbmcgQ0EwHhcNMDUwMTI4MjExODIyWhcNMDYwMTI4MjExODIy
WjBEMR8wHQYDVQQDExZUaGF3dGUgRnJlZW1haWwgTWVtYmVyMSEwHwYJKoZIhvcNAQkBFhJq
a3Jvb25AY3MudXAuYWMuemEwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCtr2Ta
AszjX/i0k6VWrGUJXaw6xOSXHSt6bYm7w+KrkbROimvs3Lb2FqeTWH2SufIsNhysZBC0LScn
oTN+phyNg2FTLeZXC0PfWlAtoLbti53UG5YX2TAqtUJxuoCNfReHkmq+V2ZnYabk2GYMYR+X
uXBQxXPVI0Kc5d5lLW+Vs7L2eRbUinzM860ZnG75t2kfWsGYIA1YtuFmzNDMCgZZEszm63+V
Z/lDz2Mv26fRPI2Y/ynUWh3w4+maEOFx4bBgvqC6wWa20xxxX4plsL9r7qB5y/VArVnwOa+x
04cDLdeXqi5SKefQaPgsGHnL4nj3G7X/yM65VPOztsY6icxbAgMBAAGjLzAtMB0GA1UdEQQW
MBSBEmprcm9vbkBjcy51cC5hYy56YTAMBgNVHRMBAf8EAjAAMA0GCSqGSIb3DQEBBAUAA4GB
AICJNcVMqOobQZ4/TZUDbhDm47MOm37bUR0JsTPPmSzFhT1FBIVCknH5eV/+cZg49czmqykB
7Kb2fNICyoNXTB4QeRtmf8yRLHX6rxXk7cb3olbdJ34GwCj8aer8OIrJ+xpFgagtPWy0uFEj
5AsDCeXzxs9ULLRYhyGpUFpxA3b7MIIC0TCCAjqgAwIBAgIDDeneMA0GCSqGSIb3DQEBBAUA
MGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQu
MSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQTAeFw0wNTAx
MjgyMTE4MjJaFw0wNjAxMjgyMTE4MjJaMEQxHzAdBgNVBAMTFlRoYXd0ZSBGcmVlbWFpbCBN
ZW1iZXIxITAfBgkqhkiG9w0BCQEWEmprcm9vbkBjcy51cC5hYy56YTCCASIwDQYJKoZIhvcN
AQEBBQADggEPADCCAQoCggEBAK2vZNoCzONf+LSTpVasZQldrDrE5JcdK3ptibvD4quRtE6K
a+zctvYWp5NYfZK58iw2HKxkELQtJyehM36mHI2DYVMt5lcLQ99aUC2gtu2LndQblhfZMCq1
QnG6gI19F4eSar5XZmdhpuTYZgxhH5e5cFDFc9UjQpzl3mUtb5WzsvZ5FtSKfMzzrRmcbvm3
aR9awZggDVi24WbM0MwKBlkSzObrf5Vn+UPPYy/bp9E8jZj/KdRaHfDj6ZoQ4XHhsGC+oLrB
ZrbTHHFfimWwv2vuoHnL9UCtWfA5r7HThwMt15eqLlIp59Bo+CwYecviePcbtf/IzrlU87O2
xjqJzFsCAwEAAaMvMC0wHQYDVR0RBBYwFIESamtyb29uQGNzLnVwLmFjLnphMAwGA1UdEwEB
/wQCMAAwDQYJKoZIhvcNAQEEBQADgYEAgIk1xUyo6htBnj9NlQNuEObjsw6bfttRHQmxM8+Z
LMWFPUUEhUKScfl5X/5xmDj1zOarKQHspvZ80gLKg1dMHhB5G2Z/zJEsdfqvFeTtxveiVt0n
fgbAKPxp6vw4isn7GkWBqC09bLS4USPkCwMJ5fPGz1QstFiHIalQWnEDdvswggM/MIICqKAD
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
IEZyZWVtYWlsIElzc3VpbmcgQ0ECAw3p3jAJBgUrDgMCGgUAoIIBpzAYBgkqhkiG9w0BCQMx
CwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0wNTA4MDYwODAxNDBaMCMGCSqGSIb3DQEJ
BDEWBBS39AeGITeEPq2M7ULSM8SrJniIUzBSBgkqhkiG9w0BCQ8xRTBDMAoGCCqGSIb3DQMH
MA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAHBgUrDgMCBzANBggqhkiG9w0DAgIB
KDB4BgkrBgEEAYI3EAQxazBpMGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29u
c3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwg
SXNzdWluZyBDQQIDDeneMHoGCyqGSIb3DQEJEAILMWugaTBiMQswCQYDVQQGEwJaQTElMCMG
A1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBl
cnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0ECAw3p3jANBgkqhkiG9w0BAQEFAASCAQBkFSXs
6qa2a04t7gk53sk3ZDhXp6Ljl/KUUrOIy69ZWnmNzC9av5jl8Ash0X0w91V43wecmDGimO8M
+1X8pRjEtcJXjfs0J9WU1mjM3gq4w2CVhYEWaTp3aGD2A2g55XVfAukxsAXG8IdE2PfA2DTz
78kyjpdwPEZqDKFsLIIPsdpPYBSL3Ni7SFLDGg+OS8sqTs4nt71O0/60SEk5hCp987xxj9H6
fpmDFpA19K7+GtjlbVVCsB6h/sbUUq3PKe/nolvxsTAiqrNPyWRoCpMyeTPsI2mrKQRr5BP6
bUcAzw77fJ6E6peh7itgVqumaTbkQPzbinepCrOA2ztTzzvfAAAAAAAA
--------------ms050900010702070904060306--
