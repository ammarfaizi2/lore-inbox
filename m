Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265706AbSKATEv>; Fri, 1 Nov 2002 14:04:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265708AbSKATEv>; Fri, 1 Nov 2002 14:04:51 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:65344 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id <S265706AbSKATEt>; Fri, 1 Nov 2002 14:04:49 -0500
Date: Fri, 1 Nov 2002 14:11:18 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
X-X-Sender: root@oddball.prodigy.com
Reply-To: Bill Davidsen <davidsen@tmr.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Sound doesn't work in 2.5.44-ac5?
Message-ID: <Pine.LNX.4.44.0211011405230.1166-201000@oddball.prodigy.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-666968182-1036177878=:1166"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-666968182-1036177878=:1166
Content-Type: TEXT/PLAIN; charset=US-ASCII

I must be doing something wrong, but I put in every sound card I had 
handy, one at a time, and the modules just can't load. No warnings in make 
modules or modules_install.

Script output attached to prevent munging, config attached if anyone has a 
problem duplicating this.

-- 
bill davidsen, at a machine far far away.

--8323328-666968182-1036177878=:1166
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="x.tmp"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0211011411180.1166@oddball.prodigy.com>
Content-Description: modprobe warnings
Content-Disposition: attachment; filename="x.tmp"

U2NyaXB0IHN0YXJ0ZWQgb24gRnJpIE5vdiAgMSAxNDowNDozNCAyMDAyDQpw
cm9maWxlIDEuMTkgMTk5OC0wNy0wMyAxNzo0Mjo1MC0wNCBtb2Qvbm9SQ1MN
Ck5vIGNvbW1vbiBkaXJlY3RvcnkgYXZhaWxhYmxlDQpTZXNzaW9uIHRpbWUg
MTQ6MDQ6MzQgb24gMTEvMDEvMDINCm9kZGJhbGw6cm9vdD4gbW9kcHJvYmUg
c25kLWh3ZGVwDQovbGliL21vZHVsZXMvMi41LjQ0LWFjNS9rZXJuZWwvc291
bmQvY29yZS9zbmQtaHdkZXAubzogdW5yZXNvbHZlZCBzeW1ib2wgbWNvdW50
DQovbGliL21vZHVsZXMvMi41LjQ0LWFjNS9rZXJuZWwvc291bmQvY29yZS9z
bmQtaHdkZXAubzogaW5zbW9kIC9saWIvbW9kdWxlcy8yLjUuNDQtYWM1L2tl
cm5lbC9zb3VuZC9jb3JlL3NuZC1od2RlcC5vIGZhaWxlZA0KL2xpYi9tb2R1
bGVzLzIuNS40NC1hYzUva2VybmVsL3NvdW5kL2NvcmUvc25kLWh3ZGVwLm86
IGluc21vZCBzbmQtaHdkZXAgZmFpbGVkDQpvZGRiYWxsOnJvb3Q+IG1vZHBy
b2JlIHNuZC1zYjE2DQovbGliL21vZHVsZXMvMi41LjQ0LWFjNS9rZXJuZWwv
c291bmQvY29yZS9zbmQtcmF3bWlkaS5vOiB1bnJlc29sdmVkIHN5bWJvbCBt
Y291bnQNCi9saWIvbW9kdWxlcy8yLjUuNDQtYWM1L2tlcm5lbC9zb3VuZC9j
b3JlL3NuZC1yYXdtaWRpLm86IGluc21vZCAvbGliL21vZHVsZXMvMi41LjQ0
LWFjNS9rZXJuZWwvc291bmQvY29yZS9zbmQtcmF3bWlkaS5vIGZhaWxlZA0K
L2xpYi9tb2R1bGVzLzIuNS40NC1hYzUva2VybmVsL3NvdW5kL2NvcmUvc25k
LXJhd21pZGkubzogaW5zbW9kIHNuZC1zYjE2IGZhaWxlZA0Kb2RkYmFsbDpy
b290PiBleGl0DQoNClNjcmlwdCBkb25lIG9uIEZyaSBOb3YgIDEgMTQ6MDU6
MTcgMjAwMg0K
--8323328-666968182-1036177878=:1166
Content-Type: APPLICATION/x-gzip; name="config.gz"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0211011411181.1166@oddball.prodigy.com>
Content-Description: config file gz
Content-Disposition: attachment; filename="config.gz"

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
--8323328-666968182-1036177878=:1166--
