Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261665AbTCZNCg>; Wed, 26 Mar 2003 08:02:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261668AbTCZNCf>; Wed, 26 Mar 2003 08:02:35 -0500
Received: from cpmail4.asap-asp.net ([195.225.3.146]:7406 "EHLO
	cpmail-dk.asap-asp.net") by vger.kernel.org with ESMTP
	id <S261665AbTCZNCe>; Wed, 26 Mar 2003 08:02:34 -0500
Date: Wed, 26 Mar 2003 14:13:43 +0100
Message-ID: <3E7FA5E900001934@webmail-dk1.sol.no1.asap-asp.net>
From: kasper_k_jensen@sol.dk
Subject: Kernel BUG
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=========3E7FA5E900001934/indlogget.mail.sol.dk"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=========3E7FA5E900001934/indlogget.mail.sol.dk
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8bit

I think I have found a bug, I have taken a srceen dump of it.


________________________________________
Få din egen webmail på http://solmail.sol.dk - gratis og med dig overalt!
Træt af virus? Få gratis beskyttelse her: http://antivirus.sol.dk



--=========3E7FA5E900001934/indlogget.mail.sol.dk
Content-Type: application/octet-stream
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="screen.dump"

TWFyIDI2IDEzOjM4OjE1IGxvY2FsaG9zdCBrZXJuZWw6IENQVTogICAgMApNYXIgMjYgMTM6Mzg6
MTUgbG9jYWxob3N0IGtlcm5lbDogaWRlLWNkIGNkcm9tIGk4MTBfYXVkaW8gYWM5N19jb2RlYyBz
b3VuZGNvcmUgYQp1dG9mcyA4MTM5dG9vIG1paSBpcHRhYmxlX2ZpbHRlcgpNYXIgMjYgMTM6Mzg6
MTUgbG9jYWxob3N0IGtlcm5lbDogaW52YWxpZCBvcGVyYW5kOiAwMDAwCk1hciAyNiAxMzozODox
NSBsb2NhbGhvc3Qga2VybmVsOiBrZXJuZWwgQlVHIGF0IHBhZ2VfYWxsb2MuYzoxNDUhCk1hciAy
NiAxMzozODoxNSBsb2NhbGhvc3Qga2VybmVsOiAtLS0tLS0tLS0tLS1bIGN1dCBoZXJlIF0tLS0t
LS0tLS0tLS0KTWFyIDI2IDEzOjM4OjE0IGxvY2FsaG9zdCBrZXJuZWw6IHN3YXBfZnJlZTogQmFk
IHN3YXAgZmlsZSBlbnRyeSAwMzgzMzA0YwpNYXIgMjYgMTM6Mzg6MTQgbG9jYWxob3N0IGtlcm5l
bDogc3dhcF9mcmVlOiBCYWQgc3dhcCBmaWxlIGVudHJ5IDA1MGRiMDI0Ck1hciAyNiAxMzozODox
NCBsb2NhbGhvc3Qga2VybmVsOiBzd2FwX2ZyZWU6IEJhZCBzd2FwIGZpbGUgZW50cnkgMDZhMzUw
MjAKTWFyIDI2IDEzOjM4OjE0IGxvY2FsaG9zdCBrZXJuZWw6IHN3YXBfZnJlZTogQmFkIHN3YXAg
ZmlsZSBlbnRyeSAwMDAwMDAwNApNYXIgMjYgMTM6Mzg6MTQgbG9jYWxob3N0IGtlcm5lbDogc3dh
cF9mcmVlOiBCYWQgc3dhcCBmaWxlIGVudHJ5IDAwYzRlMDY0Ck1hciAyNiAxMzozODoxNCBsb2Nh
bGhvc3Qga2VybmVsOiBzd2FwX2ZyZWU6IEJhZCBzd2FwIGZpbGUgZW50cnkgMDM4MzMwNGMKTWFy
IDI2IDEzOjM4OjE0IGxvY2FsaG9zdCBrZXJuZWw6IFZNOiBraWxsaW5nIHByb2Nlc3MgbW96aWxs
YS1iaW4KTWFyIDI2IDEzOjM4OjE0IGxvY2FsaG9zdCBrZXJuZWw6IHN3YXBfZHVwOiBCYWQgc3dh
cCBmaWxlIGVudHJ5IDA3YWUxMDYyCk1hciAyNiAxMzozODoxNCBsb2NhbGhvc3Qga2VybmVsOiBz
d2FwX2R1cDogQmFkIHN3YXAgZmlsZSBlbnRyeSAwNTBkYjAyNApNYXIgMjYgMTM6Mzg6MTQgbG9j
YWxob3N0IGtlcm5lbDogc3dhcF9kdXA6IEJhZCBzd2FwIGZpbGUgZW50cnkgMDZhMzUwMjAKTWFy
IDI2IDEzOjM4OjE0IGxvY2FsaG9zdCBrZXJuZWw6IHN3YXBfZHVwOiBCYWQgc3dhcCBmaWxlIGVu
dHJ5IDAwMDAwMDA0Ck1hciAyNiAxMzozODoxNCBsb2NhbGhvc3Qga2VybmVsOiBzd2FwX2R1cDog
QmFkIHN3YXAgZmlsZSBlbnRyeSAwMGM0ZTA2NApNYXIgMjYgMTM6Mzg6MTQgbG9jYWxob3N0IGtl
cm5lbDogc3dhcF9kdXA6IEJhZCBzd2FwIGZpbGUgZW50cnkgMDM4MzMwNGMKTWFyIDI2IDEzOjA5
OjIzIGxvY2FsaG9zdCB4aW5ldGRbNzQwXTogQWN0aXZhdGluZyBzZXJ2aWNlIHNnaV9mYW0KTWFy
IDI2IDEzOjA4OjUyIGxvY2FsaG9zdCB4aW5ldGRbNzQwXTogRGVhY3RpdmF0aW5nIHNlcnZpY2Ug
c2dpX2ZhbSBkdWUgdG8gZXhjZXMKc2l2ZSBpbmNvbWluZyBjb25uZWN0aW9ucy4gIFJlc3RhcnRp
bmcgaW4gMzAgc2Vjb25kcy4KTWFyIDI2IDEzOjA4OjUyIGxvY2FsaG9zdCB4aW5ldGRbMTE2OF06
IGxpYndyYXAgcmVmdXNlZCBjb25uZWN0aW9uIHRvIHNnaV9mYW0gZnIKb20gPG5vIGFkZHJlc3M+
CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgODIwLDEgICAgICAgICAxMiUK

--=========3E7FA5E900001934/indlogget.mail.sol.dk--
