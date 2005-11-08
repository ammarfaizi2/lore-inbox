Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932496AbVKHQvJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932496AbVKHQvJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 11:51:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932498AbVKHQvI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 11:51:08 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:30816
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S932496AbVKHQvH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 11:51:07 -0500
Message-Id: <4370E5C4.76F0.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Tue, 08 Nov 2005 17:52:04 +0100
From: "Jan Beulich" <JBeulich@novell.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] i386: make trap information available to die handlers
References: <4370AEE1.76F0.0078.0@novell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__Part280A16A4.0__="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__Part280A16A4.0__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Pass the trap number causing the call to die() to the die notification
handler chain.

From: Jan Beulich <jbeulich@novell.com>

(actual patch attached)


--=__Part280A16A4.0__=
Content-Type: application/octet-stream; name="linux-2.6.14-i386-die-trap-info.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="linux-2.6.14-i386-die-trap-info.patch"

UGFzcyB0aGUgdHJhcCBudW1iZXIgY2F1c2luZyB0aGUgY2FsbCB0byBkaWUoKSB0byB0aGUgZGll
IG5vdGlmaWNhdGlvbgpoYW5kbGVyIGNoYWluLgoKRnJvbTogSmFuIEJldWxpY2ggPGpiZXVsaWNo
QG5vdmVsbC5jb20+CgotLS0gMi42LjE0L2FyY2gvaTM4Ni9rZXJuZWwvdHJhcHMuYwkyMDA1LTEw
LTI4IDAyOjAyOjA4LjAwMDAwMDAwMCArMDIwMAorKysgMi42LjE0LWkzODYtZGllLXRyYXAtaW5m
by9hcmNoL2kzODYva2VybmVsL3RyYXBzLmMJMjAwNS0xMS0wNCAxNzowMDo0Ny4wMDAwMDAwMDAg
KzAxMDAKQEAgLTMzMyw3ICszMzMsNyBAQCB2b2lkIGRpZShjb25zdCBjaGFyICogc3RyLCBzdHJ1
Y3QgcHRfcmVnCiAjZW5kaWYKIAkJaWYgKG5sKQogCQkJcHJpbnRrKCJcbiIpOwotCW5vdGlmeV9k
aWUoRElFX09PUFMsIChjaGFyICopc3RyLCByZWdzLCBlcnIsIDI1NSwgU0lHU0VHVik7CisJCW5v
dGlmeV9kaWUoRElFX09PUFMsIHN0ciwgcmVncywgZXJyLCBjdXJyZW50LT50aHJlYWQudHJhcF9u
bywgU0lHU0VHVik7CiAJCXNob3dfcmVnaXN0ZXJzKHJlZ3MpOwogICAJfSBlbHNlCiAJCXByaW50
ayhLRVJOX0VSUiAiUmVjdXJzaXZlIGRpZSgpIGZhaWx1cmUsIG91dHB1dCBzdXBwcmVzc2VkXG4i
KTsK

--=__Part280A16A4.0__=--
