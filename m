Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284088AbRL2Pzq>; Sat, 29 Dec 2001 10:55:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284111AbRL2Pzg>; Sat, 29 Dec 2001 10:55:36 -0500
Received: from t2.redhat.com ([199.183.24.243]:59132 "HELO mail.redhat.de")
	by vger.kernel.org with SMTP id <S284088AbRL2PzY>;
	Sat, 29 Dec 2001 10:55:24 -0500
Date: Sat, 29 Dec 2001 16:55:23 +0100 (CET)
From: Bernhard Rosenkraenzer <bero@redhat.de>
X-X-Sender: brosenkr@bochum.stuttgart.redhat.com
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Workaround for NFS breakage in 2.5.2pre3
Message-ID: <Pine.LNX.4.42.0112291626430.23274-200000@bochum.stuttgart.redhat.com>
X-Spam-From: abuse@localhost
X-Spam-To: uce@ftc.gov
X-Subliminal-Message: Microsoft sucks! Update your system to Linux today! (http://www.redhat.com/download/)
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="279710978-775806277-1009641323=:23274"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--279710978-775806277-1009641323=:23274
Content-Type: TEXT/PLAIN; charset=US-ASCII

depmod: *** Unresolved symbols in /lib/modules/2.5.2-pre3/kernel/fs/nfs/nfs.o
depmod:         seq_escape
depmod:         seq_printf

I'm quite sure the patch I've attached is *not* the right thing to do(tm), 
but it works for me until we get a better fix. ;)

LLaP
bero

-- 
This message is provided to you under the terms outlined at
http://www.bero.org/terms.html



--279710978-775806277-1009641323=:23274
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="linux-2.5.2pre3-nfsworkaround.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.42.0112291655230.23274@bochum.stuttgart.redhat.com>
Content-Description: NFS workaround
Content-Disposition: attachment; filename="linux-2.5.2pre3-nfsworkaround.patch"

LS0tIGxpbnV4LTIuNS9mcy9uZnMvaW5vZGUuYy5uZnN3CVNhdCBEZWMgMjkg
MTY6NDI6NTcgMjAwMQ0KKysrIGxpbnV4LTIuNS9mcy9uZnMvaW5vZGUuYwlT
YXQgRGVjIDI5IDE2OjMzOjE0IDIwMDENCkBAIC0zNyw2ICszNyw4IEBADQog
I2luY2x1ZGUgPGFzbS9zeXN0ZW0uaD4NCiAjaW5jbHVkZSA8YXNtL3VhY2Nl
c3MuaD4NCiANCisjaW5jbHVkZSAiLi4vc2VxX2ZpbGUuYyINCisNCiAjZGVm
aW5lIENPTkZJR19ORlNfU05BUFNIT1QgMQ0KICNkZWZpbmUgTkZTREJHX0ZB
Q0lMSVRZCQlORlNEQkdfVkZTDQogI2RlZmluZSBORlNfUEFSQU5PSUEgMQ0K

--279710978-775806277-1009641323=:23274--
