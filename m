Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289031AbSAIVgs>; Wed, 9 Jan 2002 16:36:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289028AbSAIVgj>; Wed, 9 Jan 2002 16:36:39 -0500
Received: from finch-post-11.mail.demon.net ([194.217.242.39]:39433 "EHLO
	finch-post-11.mail.demon.net") by vger.kernel.org with ESMTP
	id <S289027AbSAIVgW>; Wed, 9 Jan 2002 16:36:22 -0500
From: Stephen Kitchener <stephen@g6dzj.demon.co.uk>
Reply-To: stephen@g6dzj.demon.co.uk
Organization: none
To: <linux-kernel@vger.kernel.org>
Subject: Error message after lilo on 2.4.17
Date: Wed, 9 Jan 2002 21:36:06 +0000
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_6CXOVQUEFZV7UKG7COJZ"
Message-Id: <E16OQOR-00072j-0B@finch-post-11.mail.demon.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_6CXOVQUEFZV7UKG7COJZ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Hi,

I hope this it the right place, it is kernel related.

I have built a 2.4.17 kernel from source on a machine here, via make 
mrproper, make xconfig, make bZimage, make mdules, make modules_install, 
,make install. Im just repeating them here so that you can see what I have 
done :-).

Checked the lilo.config, run /sbin/lilo and booted the machine.

When the machine boots it finds the kernel, lilo dosnt hang but I get this...

uncompressing linux. OK booting the kernel
Unknown bridge resourse at 0: assuming transparent
mkroot: mknod failed: 17
mount error 16 Mounting ext3 flags. Kernel panic no init found.
Try passing init=option to kernel.

The first two lines appear when I am booting from a 2.4.8 kernel, but things 
load correctly there and the 2.4.8 kernel and modules were installed the same 
way as the 2.4.17 version, so I am at a loss as to what I have missed.

Can someone help please

-- 
Stephen Kitchener
--------------Boundary-00=_6CXOVQUEFZV7UKG7COJZ
Content-Type: text/plain;
  charset="iso-8859-1";
  name="copy-of-lilo"
Content-Transfer-Encoding: base64
Content-Description: copy of lilo
Content-Disposition: attachment; filename="copy-of-lilo"

Ym9vdD0vZGV2L3NkYQptYXA9L2Jvb3QvbWFwCmluc3RhbGw9L2Jvb3QvYm9vdC5iCnZnYT1ub3Jt
YWwKZGVmYXVsdD0yNDgtMzQxLXJhZGlvCmtleXRhYmxlPS9ib290L3VrLmtsdApsYmEzMgpwcm9t
cHQKdGltZW91dD01MAptZXNzYWdlPS9ib290L21lc3NhZ2UKbWVudS1zY2hlbWU9d2I6Ync6d2I6
YncKaW1hZ2U9L2Jvb3Qvdm1saW51egogICAgICAgIGxhYmVsPWxpbnV4CiAgICAgICAgcm9vdD0v
ZGV2L3NkYTEKICAgICAgICBpbml0cmQ9L2Jvb3QvaW5pdHJkLmltZwogICAgICAgIGFwcGVuZD0i
IGRldmZzPW1vdW50IHF1aWV0IgogICAgICAgIHZnYT03ODgKICAgICAgICByZWFkLW9ubHkKaW1h
Z2U9L2Jvb3Qvdm1saW51egogICAgICAgIGxhYmVsPWxpbnV4LW5vbmZiCiAgICAgICAgcm9vdD0v
ZGV2L3NkYTEKICAgICAgICBpbml0cmQ9L2Jvb3QvaW5pdHJkLmltZwogICAgICAgIGFwcGVuZD0i
IGRldmZzPW1vdW50IgogICAgICAgIHJlYWQtb25seQppbWFnZT0vYm9vdC92bWxpbnV6CiAgICAg
ICAgbGFiZWw9ZmFpbHNhZmUKICAgICAgICByb290PS9kZXYvc2RhMQogICAgICAgIGluaXRyZD0v
Ym9vdC9pbml0cmQuaW1nCiAgICAgICAgYXBwZW5kPSIgZGV2ZnM9bW91bnQgZmFpbHNhZmUiCiAg
ICAgICAgcmVhZC1vbmx5Cm90aGVyPS9kZXYvZmQwCiAgICAgICAgbGFiZWw9ZmxvcHB5CiAgICAg
ICAgdW5zYWZlCgppbWFnZT0vYm9vdC92bWxpbnV6LTIuNC44LTM0LjFtZGsKICAgICAgICBsYWJl
bD0yNDgtMzQxCiAgICAgICAgcm9vdD0vZGV2L3NkYTEKICAgICAgICByZWFkLW9ubHkKICAgICAg
ICBvcHRpb25hbAogICAgICAgIHZnYT1ub3JtYWwKICAgICAgICBhcHBlbmQ9IiBkZXZmcz1tb3Vu
dCBxdWlldCIKICAgICAgICBpbml0cmQ9L2Jvb3QvaW5pdHJkLTIuNC44LTM0LjFtZGsuaW1nCgpp
bWFnZT0vYm9vdC92bWxpbnV6LTIuNC4xNwogICAgICAgIGxhYmVsPTI0MTcKICAgICAgICByb290
PS9kZXYvc2RhMQogICAgICAgIHJlYWQtb25seQogICAgICAgIG9wdGlvbmFsCiAgICAgICAgdmdh
PW5vcm1hbAogICAgICAgIGFwcGVuZD0iIGRldmZzPW1vdW50IHF1aWV0IgogICAgICAgIGluaXRy
ZD0vYm9vdC9pbml0cmQtMi40LjE3LmltZwoKaW1hZ2U9L2Jvb3Qvdm1saW51ei0yLjQuOC0zNC4x
bWRrLVJhZGlvCiAgICAgICAgbGFiZWw9MjQ4LTM0MS1SYWRpbwogICAgICAgIHJvb3Q9L2Rldi9z
ZGExCiAgICAgICAgcmVhZC1vbmx5CiAgICAgICAgb3B0aW9uYWwKICAgICAgICB2Z2E9bm9ybWFs
CiAgICAgICAgYXBwZW5kPSIgZGV2ZnM9bW91bnQgcXVpZXQiCiAgICAgICAgaW5pdHJkPS9ib290
L2luaXRyZC0yLjQuOC0zNC4xbWRrLVJhZGlvLmltZw==

--------------Boundary-00=_6CXOVQUEFZV7UKG7COJZ--
