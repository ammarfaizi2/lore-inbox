Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266541AbUBLR1c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 12:27:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266544AbUBLR1c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 12:27:32 -0500
Received: from p68.rivermarket.wintek.com ([208.13.56.68]:16768 "EHLO dust")
	by vger.kernel.org with ESMTP id S266541AbUBLR12 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 12:27:28 -0500
Date: Thu, 12 Feb 2004 12:30:22 -0500 (EST)
From: Alex Goddard <agoddard@purdue.edu>
To: Rik van Riel <riel@redhat.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation on how to debug modules
In-Reply-To: <Pine.LNX.4.44.0402121013040.1068-100000@chimarrao.boston.redhat.com>
Message-ID: <Pine.LNX.4.58.0402121219210.22024@dust>
References: <Pine.LNX.4.44.0402121013040.1068-100000@chimarrao.boston.redhat.com>
X-GPG-PUBLIC_KEY: N/a
X-GPG-FINGERPRINT: BCBC 0868 DB78 22F3 A657 785D 6E3B 7ACB 584E B835
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463785916-1739359682-1076607022=:22024"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1463785916-1739359682-1076607022=:22024
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Thu, 12 Feb 2004, Rik van Riel wrote:

> On Thu, 12 Feb 2004, Rusty Russell wrote:
> 
> > Just remove the debugging message which fill people's logs: the
> > correct way of debugging module problems is something like this:
> 
> Could you add that to Documentation/  ;)

I couldn't think of, or find a good place to put this, so I put the
information in it's own file.  I'm only moderately sure I've generated the
patch correctly.  However, it does apply with patch -p1 to a clean
2.6.3-rc2-bk2 tree, so it should be fine.

The wording is a slightly changed version of what Rusty said at the start
of this thread.

-- 
Alex Goddard
agoddard at purdue dot edu
---1463785916-1739359682-1076607022=:22024
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="debugging-modules.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.58.0402121230220.22024@dust>
Content-Description: 
Content-Disposition: attachment; filename="debugging-modules.patch"

ZGlmZiAtTnVycCBsaW51eC0yLjYuMy1yYzItYmsyL0RvY3VtZW50YXRpb24v
ZGVidWdnaW5nLW1vZHVsZXMudHh0IHBlcnNvbmFsLTIuNi4zLXJjMi1iazIv
RG9jdW1lbnRhdGlvbi9kZWJ1Z2dpbmctbW9kdWxlcy50eHQNCi0tLSBsaW51
eC0yLjYuMy1yYzItYmsyL0RvY3VtZW50YXRpb24vZGVidWdnaW5nLW1vZHVs
ZXMudHh0CTE5NjktMTItMzEgMTk6MDA6MDAuMDAwMDAwMDAwIC0wNTAwDQor
KysgcGVyc29uYWwtMi42LjMtcmMyLWJrMi9Eb2N1bWVudGF0aW9uL2RlYnVn
Z2luZy1tb2R1bGVzLnR4dAkyMDA0LTAyLTEyIDEyOjE1OjExLjkzNTQ4ODcy
MCAtMDUwMA0KQEAgLTAsMCArMSwxOCBAQA0KK0RlYnVnZ2luZyBNb2R1bGVz
IGFmdGVyIDIuNi4zDQorLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0N
CisNCitJbiBhbG1vc3QgYWxsIGRpc3RyaWJ1dGlvbnMsIHRoZSBrZXJuZWwg
YXNrcyBmb3IgbW9kdWxlcyB3aGljaCBkb24ndA0KK2V4aXN0LCBzdWNoIGFz
ICJuZXQtcGYtMTAiIG9yIHdoYXRldmVyLiAgQ2hhbmdpbmcgIm1vZHByb2Jl
IC1xIiB0bw0KKyJzdWNjZWVkIiBpbiB0aGlzIGNhc2UgaXMgaGFja3kgYW5k
IGJyZWFrcyBzb21lIHNldHVwcywgYW5kIGFsc28gd2UNCit3YW50IHRvIGtu
b3cgaWYgaXQgZmFpbGVkIGZvciB0aGUgZmFsbGJhY2sgY29kZSBmb3Igb2xk
IGFsaWFzZXMgaW4NCitmcy9jaGFyX2Rldi5jLCBmb3IgZXhhbXBsZS4NCisN
CitJbiB0aGUgcGFzdCBhIGRlYnVnZ2luZyBtZXNzYWdlIHdoaWNoIHdvdWxk
IGZpbGwgcGVvcGxlJ3MgbG9ncyB3YXMgDQorZW1pdHRlZC4gIFRoaXMgZGVi
dWdnaW5nIG1lc3NhZ2UgaGFzIGJlZW4gcmVtb3ZlZC4gIFRoZSBjb3JyZWN0
IHdheSANCitvZiBkZWJ1Z2dpbmcgbW9kdWxlIHByb2JsZW1zIGlzIHNvbWV0
aGluZyBsaWtlIHRoaXM6DQorDQorZWNobyAnIyEgL2Jpbi9zaCcgPiAvdG1w
L21vZHByb2JlDQorZWNobyAnZWNobyAiJEAiID4+IC90bXAvbW9kcHJvYmUu
bG9nJyA+PiAvdG1wL21vZHByb2JlDQorZWNobyAnZXhlYyAvc2Jpbi9tb2Rw
cm9iZSAiJEAiJyA+PiAvdG1wL21vZHByb2JlDQorY2htb2QgYSt4IC90bXAv
bW9kcHJvYmUNCitlY2hvIC90bXAvbW9kcHJvYmUgPiAvcHJvYy9zeXMva2Vy
bmVsL21vZHByb2JlDQo=

---1463785916-1739359682-1076607022=:22024--
