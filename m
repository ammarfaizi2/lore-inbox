Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965225AbVKHOXq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965225AbVKHOXq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 09:23:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965230AbVKHOXp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 09:23:45 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:45894
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S965222AbVKHOXo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 09:23:44 -0500
Message-Id: <4370C333.76F0.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Tue, 08 Nov 2005 15:24:35 +0100
From: "Jan Beulich" <JBeulich@novell.com>
To: "Andreas Kleen" <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>, <discuss@x86-64.org>
Subject: [PATCH] x86-64: remove unprotected iret
References: <4370AFF0.76F0.0078.0@novell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__PartDDFFE333.1__="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__PartDDFFE333.1__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Make sure no iret can fault without attached recovery code.

From: Jan Beulich <jbeulich@novell.com>

(actual patch attached)


--=__PartDDFFE333.1__=
Content-Type: application/octet-stream; name="linux-2.6.14-x86_64-iret.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="linux-2.6.14-x86_64-iret.patch"

TWFrZSBzdXJlIG5vIGlyZXQgY2FuIGZhdWx0IHdpdGhvdXQgYXR0YWNoZWQgcmVjb3ZlcnkgY29k
ZS4KCkZyb206IEphbiBCZXVsaWNoIDxqYmV1bGljaEBub3ZlbGwuY29tPgoKLS0tIDIuNi4xNC9h
cmNoL3g4Nl82NC9rZXJuZWwvZW50cnkuUwkyMDA1LTEwLTI4IDAyOjAyOjA4LjAwMDAwMDAwMCAr
MDIwMAorKysgMi42LjE0LXg4Nl82NC1pcmV0L2FyY2gveDg2XzY0L2tlcm5lbC9lbnRyeS5TCTIw
MDUtMTEtMDcgMTQ6NTY6MDIuMDAwMDAwMDAwICswMTAwCkBAIC03NTEsNyArNzUxLDcgQEAgZXJy
b3JfZXhpdDoJCQogCWpueiAgcmV0aW50X2NhcmVmdWwKIAlzd2FwZ3MgCiAJUkVTVE9SRV9BUkdT
IDAsOCwwCQkJCQkJCi0JaXJldHEKKwlqbXAgaXJldF9sYWJlbAogCUNGSV9FTkRQUk9DCiAKIGVy
cm9yX2tlcm5lbHNwYWNlOgo=

--=__PartDDFFE333.1__=--
