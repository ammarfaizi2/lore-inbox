Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287865AbSA3BVE>; Tue, 29 Jan 2002 20:21:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287858AbSA3BUz>; Tue, 29 Jan 2002 20:20:55 -0500
Received: from sombre.2ka.mipt.ru ([194.85.82.77]:8838 "EHLO
	sombre.2ka.mipt.ru") by vger.kernel.org with ESMTP
	id <S287865AbSA3BUt>; Tue, 29 Jan 2002 20:20:49 -0500
Date: Wed, 30 Jan 2002 04:20:25 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Mingming cao <cmm@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com
Subject: Re: Could not compile md/raid5.c and md/multipath.c in 2.5.3-pre3
Message-Id: <20020130042025.051ee424.johnpol@2ka.mipt.ru>
In-Reply-To: <3C571DB2.4E0C0436@us.ibm.com>
In-Reply-To: <3C571DB2.4E0C0436@us.ibm.com>
Reply-To: johnpol@2ka.mipt.ru
Organization: MIPT
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Wed__30_Jan_2002_04:20:25_+0300_082e5770"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart_Wed__30_Jan_2002_04:20:25_+0300_082e5770
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 29 Jan 2002 14:09:54 -0800
Mingming cao <cmm@us.ibm.com> wrote:

> Hello,

Good time of day.

> -march=i686    -c -o raid5.o raid5.c
> In file included from raid5.c:23:
> /home/ming/views/253-pre3/include/linux/raid/raid5.h:218: parse error
> before `md_wait_queue_head_t'
> /home/ming/views/253-pre3/include/linux/raid/raid5.h:218: warning: no
> semicolon
> at end of struct or union
> /home/ming/views/253-pre3/include/linux/raid/raid5.h:222: parse error
> before `device_lock'
> ......
> for now.  Could someone fix this?

I hope this patch will help you.

This patch is also cc'ed to Ingo Molnar, who is one of the maintainers of
multiple discs support. Is it right, Ingo?
Or noone should annoy anyone with such things?

> -- 
> Mingming Cao


	Evgeniy Polyakov ( s0mbre ).

--Multipart_Wed__30_Jan_2002_04:20:25_+0300_082e5770
Content-Type: application/octet-stream;
 name="include_linux_raid_md.diff"
Content-Disposition: attachment;
 filename="include_linux_raid_md.diff"
Content-Transfer-Encoding: base64

LS0tIC4vaW5jbHVkZS9saW51eC9yYWlkL21kLmh+CVR1ZSBKYW4gMjkgMDM6NTA6MDYgMjAwMgor
KysgLi9pbmNsdWRlL2xpbnV4L3JhaWQvbWQuaAlXZWQgSmFuIDMwIDA0OjEyOjE0IDIwMDIKQEAg
LTYzLDYgKzYzLDkgQEAKICNkZWZpbmUgTURfTUlOT1JfVkVSU0lPTiAgICAgICAgICAgICAgICA5
MAogI2RlZmluZSBNRF9QQVRDSExFVkVMX1ZFUlNJT04gICAgICAgICAgIDAKIAordHlwZWRlZiB3
YWl0X3F1ZXVlX2hlYWRfdCBtZF93YWl0X3F1ZXVlX2hlYWRfdDsKK3R5cGVkZWYgc3BpbmxvY2tf
dCBtZF9zcGlubG9ja190OworCiBleHRlcm4gaW50IG1kX3NpemVbTUFYX01EX0RFVlNdOwogZXh0
ZXJuIHN0cnVjdCBoZF9zdHJ1Y3QgbWRfaGRfc3RydWN0W01BWF9NRF9ERVZTXTsKIAo=

--Multipart_Wed__30_Jan_2002_04:20:25_+0300_082e5770--
