Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263082AbTJULsh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 07:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263081AbTJULsh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 07:48:37 -0400
Received: from pop.gmx.net ([213.165.64.20]:53632 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263082AbTJULsf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 07:48:35 -0400
Date: Tue, 21 Oct 2003 13:48:34 +0200 (MEST)
From: "Svetoslav Slavtchev" <svetljo@gmx.de>
To: "lkml " <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="========GMXBoundary5741066736914"
Subject: [PATCH][2.6-mm] radeonfb as module 
X-Priority: 3 (Normal)
X-Authenticated: #20183004
Message-ID: <574.1066736914@www3.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME encapsulated multipart message -
please use a MIME-compliant e-mail program to open it.

Dies ist eine mehrteilige Nachricht im MIME-Format -
bitte verwenden Sie zum Lesen ein MIME-konformes Mailprogramm.

--========GMXBoundary5741066736914
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

acquire_console_sem is exported, 
but release_console_sem is not

this seems like a bug for me,
as if one acquire console_sem, he should be able to relase it

svetljo

PS.
missing symbol in (IIRC) drivers/video/aty/radeon_pm.c

-- 
NEU FÜR ALLE - GMX MediaCenter - für Fotos, Musik, Dateien...
Fotoalbum, File Sharing, MMS, Multimedia-Gruß, GMX FotoService

Jetzt kostenlos anmelden unter http://www.gmx.net

+++ GMX - die erste Adresse für Mail, Message, More! +++
--========GMXBoundary5741066736914
Content-Type: application/octet-stream; name="missed_export-release_console_sem.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="missed_export-release_console_sem.patch"

LS0tIGxpbnV4LTIuNi4wLXRlc3Q3L2tlcm5lbC9wcmludGsuYy5vcmlnCTIwMDMtMTAtMjEgMDk6
NDU6MzIuMjk0OTU2MDE4ICswMjAwCisrKyBsaW51eC0yLjYuMC10ZXN0Ny9rZXJuZWwvcHJpbnRr
LmMJMjAwMy0xMC0yMSAwOTo0Mzo1OS45NTIwNDkzMDYgKzAyMDAKQEAgLTU2Niw2ICs1NjYsNyBA
QAogCWlmICh3YWtlX2tsb2dkICYmICFvb3BzX2luX3Byb2dyZXNzICYmIHdhaXRxdWV1ZV9hY3Rp
dmUoJmxvZ193YWl0KSkKIAkJd2FrZV91cF9pbnRlcnJ1cHRpYmxlKCZsb2dfd2FpdCk7CiB9CitF
WFBPUlRfU1lNQk9MKHJlbGVhc2VfY29uc29sZV9zZW0pOwogCiAvKiogY29uc29sZV9jb25kaXRp
b25hbF9zY2hlZHVsZSAtIHlpZWxkIHRoZSBDUFUgaWYgcmVxdWlyZWQKICAqCg==

--========GMXBoundary5741066736914--

