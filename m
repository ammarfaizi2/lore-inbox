Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311519AbSCXD7M>; Sat, 23 Mar 2002 22:59:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311520AbSCXD6w>; Sat, 23 Mar 2002 22:58:52 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:27652
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S311519AbSCXD6o>; Sat, 23 Mar 2002 22:58:44 -0500
Date: Sat, 23 Mar 2002 19:58:24 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
cc: linux-kernel@vger.kernel.org
Subject: Re: OOPS: ide-cd, 2.4.19-pre3-ac5
In-Reply-To: <20020324023007.GB12678@conectiva.com.br>
Message-ID: <Pine.LNX.4.10.10203231956370.2377-200000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="1430322656-557674451-1016942304=:2377"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--1430322656-557674451-1016942304=:2377
Content-Type: text/plain; charset=us-ascii


Arnaldo,

We did this last night :-/

--andre

On Sat, 23 Mar 2002, Arnaldo Carvalho de Melo wrote:

> Hi,
> 
> 	I got this while trying to mount /dev/hdc without ide-cd loaded,
> while it was auto-loading and with no CD on the CD unit.
> 
> Error (regular_file): read_system_map stat /usr/src/linux/System.map failed
> kernel BUG at ide-cd.c:790!
> invalid operand: 0000

--1430322656-557674451-1016942304=:2377
Content-Type: text/plain; charset=us-ascii; name="ide-cd-typo.patch"
Content-Transfer-Encoding: base64
Content-ID: <Pine.LNX.4.10.10203231958240.2377@master.linux-ide.org>
Content-Description: 
Content-Disposition: attachment; filename="ide-cd-typo.patch"

LS0tIGxpbnV4L2RyaXZlcnMvaWRlL2lkZS1jZC5jLm9yaWcJRnJpIE1hciAy
MiAwMToxMTo1MSAyMDAyDQorKysgbGludXgvZHJpdmVycy9pZGUvaWRlLWNk
LmMJRnJpIE1hciAyMiAwMToxMToxOCAyMDAyDQpAQCAtNzg2LDcgKzc4Niw3
IEBADQogCQkJcmV0dXJuIHN0YXJ0c3RvcDsNCiAJfQ0KIA0KLQlpZiAoSFdH
Uk9VUChkcml2ZSktPmhhbmRsZXIgPT0gTlVMTCkJLyogcGFyYW5vaWEgY2hl
Y2sgKi8NCisJaWYgKEhXR1JPVVAoZHJpdmUpLT5oYW5kbGVyICE9IE5VTEwp
CS8qIHBhcmFub2lhIGNoZWNrICovDQogCQlCVUcoKTsNCiANCiAJLyogQXJt
IHRoZSBpbnRlcnJ1cHQgaGFuZGxlci4gKi8NCg==
--1430322656-557674451-1016942304=:2377--
