Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262567AbTJXTqH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 15:46:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262572AbTJXTqH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 15:46:07 -0400
Received: from nagatino-gw.corbina.net ([195.14.53.90]:52719 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S262567AbTJXTqE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 15:46:04 -0400
Date: Fri, 24 Oct 2003 23:50:06 +0400
From: Alex Tomas <alex@clusterfs.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix against sym53c8xx v.2
Message-Id: <20031024235006.34e00c2e.alex@clusterfs.com>
Organization: CFS
X-Mailer: Sylpheed version 0.9.6claws (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Fri__24_Oct_2003_23_50_06_+0400_46tOmKWZ450tBH0V"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart=_Fri__24_Oct_2003_23_50_06_+0400_46tOmKWZ450tBH0V
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

hi!

without following patch I couldn't get 160MB from my disk.
removed line restores previous clocking value (0 in my case).
so, driver thinks disk isn't DT-capable ...

with best regards, Alex

--Multipart=_Fri__24_Oct_2003_23_50_06_+0400_46tOmKWZ450tBH0V
Content-Type: application/octet-stream;
 name="sym53c8xx2-160-fix.patch"
Content-Disposition: attachment;
 filename="sym53c8xx2-160-fix.patch"
Content-Transfer-Encoding: base64

SW5kZXg6IGxpbnV4LTIuNi4wLXRlc3Q3L2RyaXZlcnMvc2NzaS9zeW01M2M4eHhfMi9zeW1fbWlz
Yy5jCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT0KLS0tIGxpbnV4LTIuNi4wLXRlc3Q3Lm9yaWcvZHJpdmVycy9zY3NpL3N5
bTUzYzh4eF8yL3N5bV9taXNjLmMJMjAwMy0xMC0yNCAyMzozNTozNy4wMDAwMDAwMDAgKzA0MDAK
KysrIGxpbnV4LTIuNi4wLXRlc3Q3L2RyaXZlcnMvc2NzaS9zeW01M2M4eHhfMi9zeW1fbWlzYy5j
CTIwMDMtMTAtMjQgMjM6Mzc6MDYuMDAwMDAwMDAwICswNDAwCkBAIC0zMjgsNyArMzI4LDYgQEAK
IAkgICAgdHAtPmlucV9ieXRlNTYgICE9IGlucV9ieXRlNTYpIHsKIAkJdHAtPmlucV92ZXJzaW9u
ID0gaW5xX3ZlcnNpb247CiAJCXRwLT5pbnFfYnl0ZTcgICA9IGlucV9ieXRlNzsKLQkJdHAtPmlu
cV9ieXRlNTYgID0gaW5xX2J5dGU1NjsKIAkJcmV0dXJuIDE7CiAJfQogCXJldHVybiAwOwo=

--Multipart=_Fri__24_Oct_2003_23_50_06_+0400_46tOmKWZ450tBH0V--
