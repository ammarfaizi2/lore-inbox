Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262361AbTEUVHI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 17:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262362AbTEUVHI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 17:07:08 -0400
Received: from nelson.SEDSystems.ca ([192.107.131.136]:41465 "EHLO
	nelson.sedsystems.ca") by vger.kernel.org with ESMTP
	id S262361AbTEUVHG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 17:07:06 -0400
Date: Wed, 21 May 2003 15:20:02 -0600 (CST)
From: Kendrick Hamilton <hamilton@sedsystems.ca>
To: linux-kernel@vger.kernel.org
Subject: Module problems with gcc-3.2.x (please CC hamilton@sedsystems.ca)
Message-ID: <Pine.LNX.4.44.0305211512210.3274-300000@sw-55.sedsystems.ca>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1807747459-960216319-1053552002=:3289"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--1807747459-960216319-1053552002=:3289
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi,
	I have been continuing the track down problems with a module I am 
making. If I compile the kernel and module with gcc-2.95.3, the module 
installs and works correctly. If I compile the kernel and module with 
gcc-3.2.3, the module finishes installation and its interrupt service 
routine runs, then the kernel crashes. I am using linux 2.4.18 and 2.4.20. 
The computers are all pentium computers (I, II, III, celeron, xeon) with 
Redhat Linux 7.3. Any suggestions would be appreciated.

 I am assuming there is a problem with my makefiles and 
have attached them. I can tgz the entire driver and mail it to the list.

-- 
Kendrick Hamilton E.I.T.
SED Systems, a division of Calian Ltd.
18 Innovation Blvd.
PO Box 1464
Saskatoon, Saskatchewan
Canada
S7N 3R1

Hamilton@sedsystems.ca
Tel: (306) 933-1453
Fax: (306) 933-1486

--1807747459-960216319-1053552002=:3289
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=Makefile
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0305211520020.3289@sw-55.sedsystems.ca>
Content-Description: 
Content-Disposition: attachment; filename=Makefile

I05PVEU6CUNQUCByZWZlcnMgdG8gdGhlIEMgcHJlLXByb2Nlc3NvciwgQ1hY
IHJlZmVyZXMgdG8gQysrIGNvbXBpbGVyLg0KS0VSTkVMX0xPQ0FUSU9OCTo9
CS91c3Ivc3JjL2xpbnV4DQojIFN1YiBkaXJlY3RvcmllcyBjb250YWluaW5n
IGZpbGVzIHRvIG1ha2UuDQpTUkNESVIJCTo9CWRhc20gZWFoIGZpZm8gbWFp
biBwY2kgcGxsIHFkdWMgdHNwDQojIEMgc291cmNlIGZpbGVzDQpTUkMJCTo9
CXZlcnNpb24uYw0KDQpPQkpTCQk6PQkkKGZvcmVhY2ggRElSLCAkKFNSQ0RJ
UiksICQoRElSKS5vKQ0KUEtHUwkJOj0JJChmb3JlYWNoIERJUiwgJChTUkNE
SVIpLCAkKERJUikubykNCk9CSlMJCSs9CSQoU1JDWFg6LmNwcD0ubykNCk9C
SlMJCSs9CSQoU1JDOi5jPS5vKQ0KDQpUT1BESVIJCTo9CSQoc2hlbGwgL2Jp
bi9wd2QpDQpVU0VSTkFNRQk6PQkkKHNoZWxsIC91c3IvYmluL3dob2FtaSkN
CkRBVEUJCTo9CSQoc2hlbGwgL2Jpbi9kYXRlKQ0KDQpLRVJORUxfSEVBREVS
Uwk6PQkkKEtFUk5FTF9MT0NBVElPTikvaW5jbHVkZQ0KDQppbmNsdWRlICQo
S0VSTkVMX0xPQ0FUSU9OKS8uY29uZmlnDQoNCkNQUEZMQUdTCTo9CS1JJChU
T1BESVIpIC1JJChLRVJORUxfSEVBREVSUykgLURfX0tFUk5FTF9fIC1ETU9E
VUxFIFwNCgkJCS1ERVhQT1JUX1NZTVRBQiAtRFNFRF9VU0VSTkFNRT0iXCIk
KFVTRVJOQU1FKVwiIiBcDQoJCQktRFNFRF9EQVRFPSJcIiQoREFURSlcIiIg
LURfX05PX1ZFUlNJT05fXw0KaWZkZWYgQ09ORklHX1NNUA0KCUNQUEZMQUdT
ICs9IC1EX19TTVBfXyAtRFNNUA0KZW5kaWYNCg0KQ0MJCTo9CWdjYw0KTEQJ
CTo9CWxkDQpDRkxBR1MJCTo9CS1XYWxsIC1PMiAtZmlubGluZS1mdW5jdGlv
bnMgLXBpcGUNCg0KDQoNCkVYRQkJOj0Jc3BmbHNtZGQubw0KDQpleHBvcnQg
Q0MgQ1BQRkxBR1MgQ0ZMQUdTIENYWEZMQUdTIFRPUERJUiBMRA0KDQolLmQ6
ICUuYw0KCXNldCAtZTsgJChDQykgLU1NICQoQ1BQRkxBR1MpICQ8IFwNCgl8
IHNlZCAncy9cKCQqXClcLm9bIDpdKi9cMS5vICRAIDogL2cnID4gJEA7IFwN
CglbIC1zICRAIF0gfHwgcm0gLWYgJEANCg0KLlBIT05ZIDogYWxsDQphbGw6
ICQoRVhFKQ0KDQouUEhPTlkgOiBkb2MNCmRvYzogRG94eWZpbGUNCglAZWNo
byAiR2VuZXJhdGluZyBkb2N1bWVudHMgdXNpbmcgZG94eWdlbi4uLiINCglA
ZG94eWdlbiAkPA0KDQoNCkRFUEVORFMJCT0gJChTUkM6LmM9LmQpDQoNCmlm
bmVxICgkKFNSQyksICkNCmluY2x1ZGUgJChERVBFTkRTKQ0KZW5kaWYNCg0K
JChFWEUpOiAkKE9CSlMpDQoJJChMRCkgLXIgLW8gJEAgJF4NCg0KZGFzbS5v
OiBGT1JDRQ0KCSQoTUFLRSkgLUMgZGFzbQ0KDQplYWgubzogRk9SQ0UNCgkk
KE1BS0UpIC1DIGVhaA0KDQpmaWZvLm86IEZPUkNFDQoJJChNQUtFKSAtQyBm
aWZvDQoNCm1haW4ubzogRk9SQ0UNCgkkKE1BS0UpIC1DIG1haW4NCg0KcGNp
Lm86IEZPUkNFDQoJJChNQUtFKSAtQyBwY2kNCg0KcGxsLm86IEZPUkNFDQoJ
JChNQUtFKSAtQyBwbGwNCg0KcWR1Yy5vOiBGT1JDRQ0KCSQoTUFLRSkgLUMg
cWR1Yw0KDQp0c3AubzogRk9SQ0UNCgkkKE1BS0UpIC1DIHRzcA0KDQp2ZXJz
aW9uLm86IEZPUkNFDQoNCkZPUkNFOg0KDQouUEhPTlkgOiBjbGVhbg0KY2xl
YW46IG5lYXQNCglybSAtcmYgJChFWEUpICQoT0JKUykNCg0KLlBIT05ZIDog
bmVhdA0KbmVhdDoNCglybSAtZiAkKE9CSlMpICQoRVhFKQ0KCXJtIC1mICQo
REVQRU5EUykNCglybSAtZiBjb3JlDQoJQGZvciBwa2cgaW4gJChTUkNESVIp
OyBkbyBcDQoJCSQoTUFLRSkgLUMgJCRwa2cgY2xlYW47IFwNCglkb25lOw0K
CWZpbmQgKiAtdHlwZSBmIHwgZ3JlcCAnficgfCB4YXJncyBybSAtZg0KDQou
UEhPTlkgOiBkZXANCmRlcDogJChERVBFTkRTKQ0KCUBmb3IgcGtnIGluICQo
U1JDRElSKTsgZG8gXA0KCQkkKE1BS0UpIC1DICQkcGtnIGRlcDsgXA0KCWRv
bmU7DQoNCg==
--1807747459-960216319-1053552002=:3289
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=Makefile
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0305211520021.3289@sw-55.sedsystems.ca>
Content-Description: 
Content-Disposition: attachment; filename=Makefile

IyBDIFNvdXJjZSBGaWxlcw0KU1JDCQk6PQllYWhfZXJyb3IuYw0KUEFDS0FH
RQkJOj0JLi4vZWFoLm8NCg0KT0JKUwkJOj0NCk9CSlMJCSs9ICAkKFNSQzou
Yz0ubykNCg0KJS5kOiAlLmMNCglzZXQgLWU7ICQoQ0MpIC1NTSAkKENQUEZM
QUdTKSAkPCBcDQoJfCBzZWQgJ3MvXCgkKlwpXC5vWyA6XSovXDEubyAkQCA6
IC9nJyA+ICRAOyBcDQoJWyAtcyAkQCBdIHx8IHJtIC1mICRADQoNCi5QSE9O
WSA6IGFsbA0KDQphbGw6ICQoUEFDS0FHRSkNCg0KaWZuZXEgKCQoU1JDKSwg
KQ0KaW5jbHVkZSAkKFNSQzouYz0uZCkNCmVuZGlmDQpERVBFTkRTICAgICA9
ICQoU1JDOi5jPS5kKQ0KDQokKFBBQ0tBR0UpOiAkKE9CSlMpDQoJJChMRCkg
LXIgLW8gJEAgJF4NCg0KRk9SQ0U6DQoNCi5QSE9OWSA6IGNsZWFuDQpjbGVh
bjoNCglybSAtZiAkKE9CSlMpICQoREVQRU5EUykNCg0KLlBIT05ZIDogaW5z
dGFsbA0KaW5zdGFsbDoNCg0KLlBIT05ZIDogZGVwDQpkZXA6ICQoREVQRU5E
UykNCg==
--1807747459-960216319-1053552002=:3289--
