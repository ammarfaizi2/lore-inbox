Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129833AbRCCXEa>; Sat, 3 Mar 2001 18:04:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129835AbRCCXET>; Sat, 3 Mar 2001 18:04:19 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:8480 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S129833AbRCCXEG>; Sat, 3 Mar 2001 18:04:06 -0500
Date: Sun, 4 Mar 2001 00:03:56 +0100 (CET)
From: Francis Galiegue <fg@mandrakesoft.com>
To: linux-kernel@vger.kernel.org
cc: jgarzik@mandrakesoft.com, Kernel list <kernel@linux-mandrake.com>
Subject: [PATCH] 2.4.2: cure the kapm-idled taking (100-epsilon)% CPU time
Message-ID: <Pine.LNX.4.21.0103040000550.922-200000@toy.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463800575-1150426360-983660636=:922"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1463800575-1150426360-983660636=:922
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

As attachment. Don't ask me why it works. Rather, if you see why it works, I'd
like to know why :)

Patch also applies cleanly over 2.4.2-ac10.

-- 
Francis Galiegue, fg@mandrakesoft.com - Normand et fier de l'être
"Programming is a race between programmers, who try and make more and more
idiot-proof software, and universe, which produces more and more remarkable
idiots. Until now, universe leads the race"  -- R. Cook

---1463800575-1150426360-983660636=:922
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="linux-2.4-fix-kapm.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.21.0103040003560.922@toy.mandrakesoft.com>
Content-Description: 
Content-Disposition: attachment; filename="linux-2.4-fix-kapm.patch"

LS0tIGxpbnV4L2FyY2gvaTM4Ni9rZXJuZWwvYXBtLmMub2xkCVNhdCBNYXIg
IDMgMjM6NTk6MzYgMjAwMQ0KKysrIGxpbnV4L2FyY2gvaTM4Ni9rZXJuZWwv
YXBtLmMJU2F0IE1hciAgMyAyMzo1Nzo1NiAyMDAxDQpAQCAtNTU3LDcgKzU1
Nyw3IEBADQogew0KIAl1MzIJZHVtbXk7DQogDQotCWlmIChhcG1fYmlvc19j
YWxsX3NpbXBsZShBUE1fRlVOQ19JRExFLCAwLCAwLCAmZHVtbXkpKQ0KKwlp
ZiAoYXBtX2Jpb3NfY2FsbChBUE1fRlVOQ19JRExFLCAwLCAwLCAmZHVtbXks
ICZkdW1teSwgJmR1bW15LCAmZHVtbXksICZkdW1teSkpDQogCQlyZXR1cm4g
MDsNCiANCiAjaWZkZWYgQUxXQVlTX0NBTExfQlVTWQ0K
---1463800575-1150426360-983660636=:922--
