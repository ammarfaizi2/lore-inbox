Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292231AbSDPKEo>; Tue, 16 Apr 2002 06:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292857AbSDPKEn>; Tue, 16 Apr 2002 06:04:43 -0400
Received: from [24.84.50.235] ([24.84.50.235]:8965 "HELO
	mail.orbis-terrarum.net") by vger.kernel.org with SMTP
	id <S292231AbSDPKEm>; Tue, 16 Apr 2002 06:04:42 -0400
Date: Tue, 16 Apr 2002 03:04:44 -0700 (PDT)
From: Robin Johnson <robbat2@fermi.orbis-terrarum.net>
To: linux-kernel@vger.kernel.org
Subject: Incremental Patch Building Script
Message-ID: <Pine.LNX.4.43.0204160302250.3657-200000@fermi.orbis-terrarum.net>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1276696670-153051145-1018951484=:3657"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--1276696670-153051145-1018951484=:3657
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi,

I have written a script to build incremental patches, as found on
bzimage.org previously. I have written this so that other people will find
it easier to roll their own incremental patches to use.

Comments/Suggestions on improvement welcome

Please CC me, as I am not subscribed to the list.

Thanks.

-- 
Robin Hugh Johnson
E-Mail     : robbat2@orbis-terrarum.net
Home Page  : http://www.orbis-terrarum.net/?l=people.robbat2
ICQ#       : 30269588 or 41961639

--1276696670-153051145-1018951484=:3657
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=interpatch
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.43.0204160304430.3657@fermi.orbis-terrarum.net>
Content-Description: 
Content-Disposition: attachment; filename=interpatch

IyEvYmluL2Jhc2gNCiMNCiMgSW5jcmVtZW50YWwgS2VybmVsIFBhdGNoIEJ1
aWxkZXINCiMgUm9iaW4gSm9obnNvbg0KIyByb2JiYXQyQG9yYmlzLXRlcnJh
cnVtLm5ldA0KIw0KIyBCdWlsZCBhbiBpbmNyZW1lbnRhbCBkaWZmIGJldHdl
ZW4gdHdvIGtlcm5lbCBwYXRjaGVzDQojIHJ1biBhcyAiLi9pbnRlcnBhdGNo
IDIuNC4xMyBhYzcgYWM4IiB0byBidWlsZCBwYXRjaC0yLjQuMTMtYWM3LWFj
OC5iejINCiMgdGhpcyB3b3VsZCByZXF1aXJlIHRoZSBmb2xsb3cgZmlsZXMg
aW4gdGhlIGN1cnJlbnQgZGlyZWN0b3J5Og0KIyBsaW51eC0yLjQuMTMudGFy
LmJ6Mg0KIyBwYXRjaC0yLjQuMTMtYWM3LmJ6Mg0KIyBwYXRjaC0yLjQuMTMt
YWM4LmJ6Mg0KIw0KIyBSRVFVSVJFUyB0bXBmcyBhbmQgbG90cyBvZiBSQU0g
Zm9yIHNwZWVkIHJlYXNvbnMNCiMNCiMNCg0KVEFSX0NNRD0idGFyIHgiDQpD
T01QUkVTU19DTUQ9ImJ6aXAyIC05YyINClVOQ09NUFJFU1NfQ01EPSJiemlw
MiAtZGMiDQpQQVRDSF9DTUQ9InBhdGNoIC1zIC1wMSINCkRJRkZfQ01EPSJk
aWZmIC1IdXJkTiIgI3RoZSBIdXJkIGtlcm5lbCA/IA0KTU9VTlRDTUQ9Im1v
dW50IC10IHRtcGZzIC9kZXYvcmFtOCINCk1PVU5UT1BUPSIgLW8gc2l6ZT01
MTJNIiANCg0KIyAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLQ0KIyBOTyBVU0VSIENPTkZJR1VSQVRJT04gQkVZT05EIFRISVMh
DQojIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
DQoNCktFUk5FTFZFUlNJT049JDENClBBVENITEVWRUwxPSQyDQpQQVRDSExF
VkVMMj0kMw0KDQpTUkM9ImxpbnV4LSR7S0VSTkVMVkVSU0lPTn0udGFyLmJ6
MiINCk9MRFZFUlNJT049IiR7S0VSTkVMVkVSU0lPTn0tJHtQQVRDSExFVkVM
MX0iDQpORVdWRVJTSU9OPSIke0tFUk5FTFZFUlNJT059LSR7UEFUQ0hMRVZF
TDJ9Ig0KT0xERElSPSJsaW51eC0ke09MRFZFUlNJT059Ig0KTkVXRElSPSJs
aW51eC0ke05FV1ZFUlNJT059Ig0KUEFUQ0gxPSJwYXRjaC0ke09MRFZFUlNJ
T059LmJ6MiINClBBVENIMj0icGF0Y2gtJHtORVdWRVJTSU9OfS5iejIiDQpU
QVJHRVQ9InBhdGNoLSR7S0VSTkVMVkVSU0lPTn0tJHtQQVRDSExFVkVMMX0t
JHtQQVRDSExFVkVMMn0iDQoNClNSQ0RJUj1gcHdkYA0KVE1QRElSPWBta3Rl
bXAgLXEgLWQga2VybnBhdGNoLlhYWFhYWGANCg0KDQplY2hvICJTZXR0aW5n
IHVwIHNwYWNlLi4uIg0KJHtNT1VOVENNRH0gJHtUTVBESVJ9ICR7TU9VTlRP
UFR9DQoNCmNkICR7VE1QRElSfQ0KDQplY2hvICJFeHRyYWN0aW5nLi4uIiAN
CiR7VU5DT01QUkVTU19DTUR9ICR7U1JDRElSfS8ke1NSQ30gfCAke1RBUl9D
TUR9DQoNCmVjaG8gIkNvcHlpbmcuLi4iIA0KbXYgbGludXggJE9MRERJUg0K
Y3AgLXIgJE9MRERJUiAkTkVXRElSDQoNCmVjaG8gIlBhdGNoaW5nICMxLi4u
Ig0KJHtVTkNPTVBSRVNTX0NNRH0gJHtTUkNESVJ9LyR7UEFUQ0gxfSB8ICR7
UEFUQ0hfQ01EfSAtZCAkT0xERElSDQplY2hvICJQYXRjaGluZyAjMi4uLiIN
CiR7VU5DT01QUkVTU19DTUR9ICR7U1JDRElSfS8ke1BBVENIMn0gfCAke1BB
VENIX0NNRH0gLWQgJE5FV0RJUg0KZWNobyAiQnVpbGRpbmcgZGlmZi4uLiIN
CiR7RElGRl9DTUR9ICRPTERESVIgJE5FV0RJUiA+ICR7VEFSR0VUfQ0KDQpl
Y2hvICJDb21wcmVzc2luZyBkaWZmLi4uIg0KJHtDT01QUkVTU19DTUR9ICR7
VEFSR0VUfSA+ICR7U1JDRElSfS8ke1RBUkdFVH0uYnoyDQoNCmNkICR7U1JD
RElSfQ0KDQplY2hvICJDbGVhbmluZyB1cC4uLiINCnJtIC1yZiAke1RNUERJ
Un0vKg0KdW1vdW50ICR7VE1QRElSfQ0Kcm0gLXJmICR7VE1QRElSfQ0KDQo=
--1276696670-153051145-1018951484=:3657--
