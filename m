Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932207AbVKGMv0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932207AbVKGMv0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 07:51:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932479AbVKGMv0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 07:51:26 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:48960
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S932207AbVKGMvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 07:51:25 -0500
Message-Id: <436F5C04.76F0.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Mon, 07 Nov 2005 13:52:04 +0100
From: "Jan Beulich" <JBeulich@novell.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] i386 NMI pointer comparison fix
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__PartEDCFCCE4.0__="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__PartEDCFCCE4.0__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Instruction pointer comparisons for the NMI on debug stack check/fixup
were incorrect.

From: Jan Beulich <jbeulich@novell.com>

(actual patch attached)

--=__PartEDCFCCE4.0__=
Content-Type: application/octet-stream; name="linux-2.6.14-i386-nmi-stack.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="linux-2.6.14-i386-nmi-stack.patch"

SW5zdHJ1Y3Rpb24gcG9pbnRlciBjb21wYXJpc29ucyBmb3IgdGhlIE5NSSBvbiBkZWJ1ZyBzdGFj
ayBjaGVjay9maXh1cAp3ZXJlIGluY29ycmVjdC4KCkZyb206IEphbiBCZXVsaWNoIDxqYmV1bGlj
aEBub3ZlbGwuY29tPgoKLS0tIC9ob21lL2piZXVsaWNoL3RtcC9saW51eC0yLjYuMTQvYXJjaC9p
Mzg2L2tlcm5lbC9lbnRyeS5TCTIwMDUtMTAtMjggMDI6MDI6MDguMDAwMDAwMDAwICswMjAwCisr
KyAyLjYuMTQvYXJjaC9pMzg2L2tlcm5lbC9lbnRyeS5TCTIwMDUtMTEtMDQgMTI6MTg6NTcuMDAw
MDAwMDAwICswMTAwCkBAIC01NjAsMTEgKzU2MCwxMCBAQCBubWlfc3RhY2tfZml4dXA6CiBubWlf
ZGVidWdfc3RhY2tfY2hlY2s6CiAJY21wdyAkX19LRVJORUxfQ1MsMTYoJWVzcCkKIAlqbmUgbm1p
X3N0YWNrX2NvcnJlY3QKLQljbXBsICRkZWJ1ZyAtIDEsKCVlc3ApCi0JamxlIG5taV9zdGFja19j
b3JyZWN0CisJY21wbCAkZGVidWcsKCVlc3ApCisJamIgbm1pX3N0YWNrX2NvcnJlY3QKIAljbXBs
ICRkZWJ1Z19lc3BfZml4X2luc24sKCVlc3ApCi0JamxlIG5taV9kZWJ1Z19zdGFja19maXh1cAot
bm1pX2RlYnVnX3N0YWNrX2ZpeHVwOgorCWphIG5taV9zdGFja19jb3JyZWN0CiAJRklYX1NUQUNL
KDI0LG5taV9zdGFja19jb3JyZWN0LCAxKQogCWptcCBubWlfc3RhY2tfY29ycmVjdAogCg==

--=__PartEDCFCCE4.0__=--
