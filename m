Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262755AbVENMtz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262755AbVENMtz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 08:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262761AbVENMtI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 08:49:08 -0400
Received: from plato.arts.usyd.edu.au ([129.78.16.1]:11233 "EHLO
	plato.arts.usyd.edu.au") by vger.kernel.org with ESMTP
	id S262755AbVENMrB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 08:47:01 -0400
Message-ID: <4285F337.7010301@arts.usyd.edu.au>
Date: Sat, 14 May 2005 22:46:47 +1000
From: Matthew Geier <matthew@arts.usyd.edu.au>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Y2K-like bug to hit Linux computers! - Info of the day
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms050406070300030905090501"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms050406070300030905090501
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On Sat, May 14, 2005 at 10:09:04AM +0100, christos gentsis wrote:

 > BTW is there anyone that plan to use his embedded devise until 2038????
 > i would happy to see that :P any way embedded devises are there so they
 > will have sort life cycle... how long are you going to use them 6
 > months???? maximum 1-2 years....
 > so there is no any problem....

  I assume you are thinking of 'consumer' devices here, ADSL routers, 
Satelite 'Set top boxes' and the like that have short lives.

  Embeded computing is much bigger than that. I've got a 20 year old 
embedded processor controlled microwave oven. (It still knows how to 
cook better than I do :-).

  All sorts of Industrial machinery have embeded CPUs. I'm a train nut. 
In just this field, railways - equipment is expected to have a 30 year 
operational life span, and much of it is now driven by embeded 
computers, from traffic control signaling systems that have to be 
absolutely safe from 'wrong side failures', 'fly by wire' traction power 
control to regulate the trains speed, to monitoring the temprature of 
the air-conditioning. A train being built right at this very moment, 
with a 'train operating system' computer controlling every aspect of 
it's operation will probably still be in service in 2038.

  With any luck however, the people writing the software for these 
things are aware of this issue and are not blindly using signed 32 bit 
absolute time values from 1970.

  BTW, the machine i'm typing this on WONT have this problem. (Doubt 
that it will be still around in 2038 anyway). It's a 64bit platform and 
time_t is 64 bit.

  It isn't just a linux problem either, it's a generic Unix/C library 
problem. Any software system that uses a signed 32bit number from 1970 
to represent time. I have a vague recolection that there was another 
popular system around that also used signed 32bit time, only it's epoch 
is 1980. Those systems will go belly up 10 years after all the ancient 
Unix systems. :-)


--------------ms050406070300030905090501
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIJmzCC
AygwggKRoAMCAQICAw55LjANBgkqhkiG9w0BAQQFADBiMQswCQYDVQQGEwJaQTElMCMGA1UE
ChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNv
bmFsIEZyZWVtYWlsIElzc3VpbmcgQ0EwHhcNMDUwNDEzMTkzMDIwWhcNMDYwNDEzMTkzMDIw
WjB3MR8wHQYDVQQDExZUaGF3dGUgRnJlZW1haWwgTWVtYmVyMScwJQYJKoZIhvcNAQkBFhht
YXR0aGV3QGFydHMudXN5ZC5lZHUuYXUxKzApBgkqhkiG9w0BCQEWHG1hdHRoZXdAc2xlZXBl
ci5hcGFuYS5vcmcuYXUwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDXkCTIaYZN
CnrMwBhEoQSyjebUbVD4S1s2iJYrcAVGCJNiyu8Fw2f7FAWWAUQ5eNENQiNIOGOmx1Zf4HEu
coIemGRlAXw0sAQgSACm6czK+lgqUGEPhYS8JictipFdr1BJoAkoqEY0excbi3T4q/4qLEfl
tBwP2s5L/SNuLGPrvMq0jp8KuD1tGpY21/hYUpgYrMX+IiQUfAlg+3VZxO3tt9b8TvNo0g4l
gBUrqpuqPt3ZLV/6wEsMGTtd0kR+qnlXWdKHU9VTTSonJbjemQQiTq1KmoW6AGtSyPRqoIGB
ha3RhkcujyQCFKnAs7tE+gHFCGe2Xc59O3nVP760XwKPAgMBAAGjUzBRMEEGA1UdEQQ6MDiB
GG1hdHRoZXdAYXJ0cy51c3lkLmVkdS5hdYEcbWF0dGhld0BzbGVlcGVyLmFwYW5hLm9yZy5h
dTAMBgNVHRMBAf8EAjAAMA0GCSqGSIb3DQEBBAUAA4GBABoavSh8uOJsULhbTSlF0vlmPGTd
r82KhGkRc0LnHAZ/VWscd4+pUXYxoh6uq4JCB+69tPrdDiSeAMvenLURsv9D/fBLh3E1fKVR
na78r2adw0Xja3/pf7AimdN6Gbl79hRwzyVe8YJtImC1+0/L8B7i4KmBa43oO9u8yz41/f3I
MIIDKDCCApGgAwIBAgIDDnkuMA0GCSqGSIb3DQEBBAUAMGIxCzAJBgNVBAYTAlpBMSUwIwYD
VQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVy
c29uYWwgRnJlZW1haWwgSXNzdWluZyBDQTAeFw0wNTA0MTMxOTMwMjBaFw0wNjA0MTMxOTMw
MjBaMHcxHzAdBgNVBAMTFlRoYXd0ZSBGcmVlbWFpbCBNZW1iZXIxJzAlBgkqhkiG9w0BCQEW
GG1hdHRoZXdAYXJ0cy51c3lkLmVkdS5hdTErMCkGCSqGSIb3DQEJARYcbWF0dGhld0BzbGVl
cGVyLmFwYW5hLm9yZy5hdTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBANeQJMhp
hk0KeszAGEShBLKN5tRtUPhLWzaIlitwBUYIk2LK7wXDZ/sUBZYBRDl40Q1CI0g4Y6bHVl/g
cS5ygh6YZGUBfDSwBCBIAKbpzMr6WCpQYQ+FhLwmJy2KkV2vUEmgCSioRjR7FxuLdPir/ios
R+W0HA/azkv9I24sY+u8yrSOnwq4PW0aljbX+FhSmBisxf4iJBR8CWD7dVnE7e231vxO82jS
DiWAFSuqm6o+3dktX/rASwwZO13SRH6qeVdZ0odT1VNNKicluN6ZBCJOrUqahboAa1LI9Gqg
gYGFrdGGRy6PJAIUqcCzu0T6AcUIZ7Zdzn07edU/vrRfAo8CAwEAAaNTMFEwQQYDVR0RBDow
OIEYbWF0dGhld0BhcnRzLnVzeWQuZWR1LmF1gRxtYXR0aGV3QHNsZWVwZXIuYXBhbmEub3Jn
LmF1MAwGA1UdEwEB/wQCMAAwDQYJKoZIhvcNAQEEBQADgYEAGhq9KHy44mxQuFtNKUXS+WY8
ZN2vzYqEaRFzQuccBn9Vaxx3j6lRdjGiHq6rgkIH7r20+t0OJJ4Ay96ctRGy/0P98EuHcTV8
pVGdrvyvZp3DReNrf+l/sCKZ03oZuXv2FHDPJV7xgm0iYLX7T8vwHuLgqYFrjeg727zLPjX9
/cgwggM/MIICqKADAgECAgENMA0GCSqGSIb3DQEBBQUAMIHRMQswCQYDVQQGEwJaQTEVMBMG
A1UECBMMV2VzdGVybiBDYXBlMRIwEAYDVQQHEwlDYXBlIFRvd24xGjAYBgNVBAoTEVRoYXd0
ZSBDb25zdWx0aW5nMSgwJgYDVQQLEx9DZXJ0aWZpY2F0aW9uIFNlcnZpY2VzIERpdmlzaW9u
MSQwIgYDVQQDExtUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgQ0ExKzApBgkqhkiG9w0BCQEW
HHBlcnNvbmFsLWZyZWVtYWlsQHRoYXd0ZS5jb20wHhcNMDMwNzE3MDAwMDAwWhcNMTMwNzE2
MjM1OTU5WjBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0
eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0Ew
gZ8wDQYJKoZIhvcNAQEBBQADgY0AMIGJAoGBAMSmPFVzVftOucqZWh5owHUEcJ3f6f+jHuy9
zfVb8hp2vX8MOmHyv1HOAdTlUAow1wJjWiyJFXCO3cnwK4Vaqj9xVsuvPAsH5/EfkTYkKhPP
K9Xzgnc9A74r/rsYPge/QIACZNenprufZdHFKlSFD0gEf6e20TxhBEAeZBlyYLf7AgMBAAGj
gZQwgZEwEgYDVR0TAQH/BAgwBgEB/wIBADBDBgNVHR8EPDA6MDigNqA0hjJodHRwOi8vY3Js
LnRoYXd0ZS5jb20vVGhhd3RlUGVyc29uYWxGcmVlbWFpbENBLmNybDALBgNVHQ8EBAMCAQYw
KQYDVR0RBCIwIKQeMBwxGjAYBgNVBAMTEVByaXZhdGVMYWJlbDItMTM4MA0GCSqGSIb3DQEB
BQUAA4GBAEiM0VCD6gsuzA2jZqxnD3+vrL7CF6FDlpSdf0whuPg2H6otnzYvwPQcUCCTcDz9
reFhYsPZOhl+hLGZGwDFGguCdJ4lUJRix9sncVcljd2pnDmOjCBPZV+V2vf3h9bGCE6u9uo0
5RAaWzVNd+NWIXiC3CEZNd4ksdMdRv9dX2VPMYIDOzCCAzcCAQEwaTBiMQswCQYDVQQGEwJa
QTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhh
d3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0ECAw55LjAJBgUrDgMCGgUAoIIBpzAY
BgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0wNTA1MTQxMjQ2NDda
MCMGCSqGSIb3DQEJBDEWBBTwUy0Bpn9O8GygJpaN55Rv6b+cVzBSBgkqhkiG9w0BCQ8xRTBD
MAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAHBgUrDgMCBzAN
BggqhkiG9w0DAgIBKDB4BgkrBgEEAYI3EAQxazBpMGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQK
ExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29u
YWwgRnJlZW1haWwgSXNzdWluZyBDQQIDDnkuMHoGCyqGSIb3DQEJEAILMWugaTBiMQswCQYD
VQQGEwJaQTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UE
AxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0ECAw55LjANBgkqhkiG9w0B
AQEFAASCAQDH40aBLaBP+JPHIAVznz9lvbcxhUFdAlOZGTpbSsfaYkME1EF27XiYzmEOjkcS
WtfhJ6n7KmjeaLDue0cTmLt5GhzezWJ+j55tTVi8cP16nirgDTcZtMq+zxsiNmerR67uZXop
NgTo2wk/tbJ137qrA4/rN3nZ1PolnNXnoHxNphkSRnrcx5EFyuD6sGqykPUdWQyvpnpjmISl
4OiNpfF0AJn+Gn0lvvsIOCyyGiBxoZMGfPqrs8dHbXugF9brctpHRBzGQGisTs/2R00lomvl
Vxc42tfUpwlVurjWrrjLfZbM81jiRh9oi8Sah8ltxui9FJXwj4Ed9USK6oVUM/4sAAAAAAAA

--------------ms050406070300030905090501--
