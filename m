Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130399AbRCBKxO>; Fri, 2 Mar 2001 05:53:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130401AbRCBKxF>; Fri, 2 Mar 2001 05:53:05 -0500
Received: from chiara.elte.hu ([157.181.150.200]:48134 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S130399AbRCBKwx>;
	Fri, 2 Mar 2001 05:52:53 -0500
Date: Fri, 2 Mar 2001 11:52:01 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: tachino Nobuhiro <tachino@open.nm.fujitsu.co.jp>
Cc: <rml@ufl.edu>, Linux Kernel List <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [patch] ps2fix-2.4.2-A0
In-Reply-To: <snkwhfir.wl@frostrubin.open.nm.fujitsu.co.jp>
Message-ID: <Pine.LNX.4.30.0103021151090.3299-200000@elte.hu>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="655616-484281537-983530321=:3299"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--655616-484281537-983530321=:3299
Content-Type: TEXT/PLAIN; charset=US-ASCII


On Fri, 2 Mar 2001, tachino Nobuhiro wrote:

> +       if (c == &misc_list) {
>
>   This should be  (c != &misc_list)

indeed, this fixed the ps2 problem for me too. Patch against -ac8
attached.

	Ingo

--655616-484281537-983530321=:3299
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="ps2fix-2.4.2-A0"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.30.0103021152010.3299@elte.hu>
Content-Description: 
Content-Disposition: attachment; filename="ps2fix-2.4.2-A0"

LS0tIGxpbnV4L2RyaXZlcnMvY2hhci9taXNjLmMub3JpZwlGcmkgTWFyICAy
IDEzOjQyOjAwIDIwMDENCisrKyBsaW51eC9kcml2ZXJzL2NoYXIvbWlzYy5j
CUZyaSBNYXIgIDIgMTM6NDI6MDIgMjAwMQ0KQEAgLTE4MCw3ICsxODAsNyBA
QA0KIA0KIAl3aGlsZSAoKGMgIT0gJm1pc2NfbGlzdCkgJiYgKGMtPm1pbm9y
ICE9IG1pc2MtPm1pbm9yKSkNCiAJCWMgPSBjLT5uZXh0Ow0KLQlpZiAoYyA9
PSAmbWlzY19saXN0KSB7DQorCWlmIChjICE9ICZtaXNjX2xpc3QpIHsNCiAJ
CXVwKCZtaXNjX3NlbSk7DQogCQlyZXR1cm4gLUVCVVNZOw0KIAl9DQo=
--655616-484281537-983530321=:3299--
