Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265418AbUGDGwS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265418AbUGDGwS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 02:52:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265422AbUGDGwS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 02:52:18 -0400
Received: from web50606.mail.yahoo.com ([206.190.38.93]:33655 "HELO
	web50606.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265418AbUGDGwK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 02:52:10 -0400
Message-ID: <20040704065209.62186.qmail@web50606.mail.yahoo.com>
Date: Sat, 3 Jul 2004 23:52:09 -0700 (PDT)
From: mike havlicek <mhavlicek1@yahoo.com>
Subject: Kernel  crashes with Linux version 2.4.20-31.9  RedHat 9 distro....
To: linux-kernel@vger.kernel.org
Cc: phoeb@junu.com
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-965955302-1088923929=:59806"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-965955302-1088923929=:59806
Content-Type: text/plain; charset=us-ascii
Content-Id: 
Content-Disposition: inline

Hello,

These crashes have occured on a custom built
(hardware) AMD based system running redhat 9. The
basic architecture is :


cpuinfo : 

vendor_id       : AuthenticAMD
cpu family      : 5
model           : 8
model name      : AMD-K6(tm) 3D processor
stepping        : 12
cpu MHz         : 451.022
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 pge
mmx syscall 3dnow k6_mtrr
bogomips        : 897.84


meminfo:


        total:    used:    free:  shared: buffers: 
cached:
Mem:  187310080 175386624 11923456        0 56385536
74276864
Swap: 402644992  3325952 399319040
MemTotal:       182920 kB
MemFree:         11644 kB
MemShared:           0 kB
Buffers:         55064 kB
Cached:          69680 kB
SwapCached:       2856 kB
Active:         101988 kB
ActiveAnon:      13456 kB
ActiveCache:     88532 kB
Inact_dirty:        20 kB
Inact_laundry:   32580 kB
Inact_clean:      2776 kB
Inact_target:    27472 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       182920 kB
LowFree:         11644 kB
SwapTotal:      393208 kB
SwapFree:       389960 kB

The harddisk is a Quantum Bigfoot IDE.

I ran the oops report through ksymoops :

# ksymoops < /var/log/messages > textfilename.txt

I am attaching the output. I am concerned as to
whether the error resulting in the crash is due to
hardware failure, or miscommunication with an
"overbloated" kernel or a bug in this kernel release. 


What do you think? 

Thanks a bunch,

- Mike


		
__________________________________
Do you Yahoo!?
New and Improved Yahoo! Mail - Send 10MB messages!
http://promotions.yahoo.com/new_mail 
--0-965955302-1088923929=:59806
Content-Type: application/octet-stream; name="ksymoops-messages.1.out"
Content-Transfer-Encoding: base64
Content-Description: ksymoops-messages.1.out
Content-Disposition: attachment; filename="ksymoops-messages.1.out"

a3N5bW9vcHMgMi40Ljkgb24gaTU4NiAyLjQuMjAtMzEuOS4gIE9wdGlvbnMg
dXNlZAogICAgIC1WIChkZWZhdWx0KQogICAgIC1rIC9wcm9jL2tzeW1zIChk
ZWZhdWx0KQogICAgIC1sIC9wcm9jL21vZHVsZXMgKGRlZmF1bHQpCiAgICAg
LW8gL2xpYi9tb2R1bGVzLzIuNC4yMC0zMS45LyAoZGVmYXVsdCkKICAgICAt
bSAvdXNyL3NyYy9saW51eC9TeXN0ZW0ubWFwIChkZWZhdWx0KQoKV2Fybmlu
ZzogWW91IGRpZCBub3QgdGVsbCBtZSB3aGVyZSB0byBmaW5kIHN5bWJvbCBp
bmZvcm1hdGlvbi4gIEkgd2lsbAphc3N1bWUgdGhhdCB0aGUgbG9nIG1hdGNo
ZXMgdGhlIGtlcm5lbCBhbmQgbW9kdWxlcyB0aGF0IGFyZSBydW5uaW5nCnJp
Z2h0IG5vdyBhbmQgSSdsbCB1c2UgdGhlIGRlZmF1bHQgb3B0aW9ucyBhYm92
ZSBmb3Igc3ltYm9sIHJlc29sdXRpb24uCklmIHRoZSBjdXJyZW50IGtlcm5l
bCBhbmQvb3IgbW9kdWxlcyBkbyBub3QgbWF0Y2ggdGhlIGxvZywgeW91IGNh
biBnZXQKbW9yZSBhY2N1cmF0ZSBvdXRwdXQgYnkgdGVsbGluZyBtZSB0aGUg
a2VybmVsIHZlcnNpb24gYW5kIHdoZXJlIHRvIGZpbmQKbWFwLCBtb2R1bGVz
LCBrc3ltcyBldGMuICBrc3ltb29wcyAtaCBleHBsYWlucyB0aGUgb3B0aW9u
cy4KCkVycm9yIChleHBhbmRfb2JqZWN0cyk6IGNhbm5vdCBzdGF0KC9saWIv
ZXh0My5vKSBmb3IgZXh0MwpFcnJvciAoZXhwYW5kX29iamVjdHMpOiBjYW5u
b3Qgc3RhdCgvbGliL2piZC5vKSBmb3IgamJkCkVycm9yIChleHBhbmRfb2Jq
ZWN0cyk6IGNhbm5vdCBzdGF0KC9saWIvbHZtLW1vZC5vKSBmb3IgbHZtLW1v
ZApFcnJvciAocmVndWxhcl9maWxlKTogcmVhZF9zeXN0ZW1fbWFwIHN0YXQg
L3Vzci9zcmMvbGludXgvU3lzdGVtLm1hcCBmYWlsZWQKV2FybmluZyAobWFw
X2tzeW1fdG9fbW9kdWxlKTogY2Fubm90IG1hdGNoIGxvYWRlZCBtb2R1bGUg
ZXh0MyB0byBhIHVuaXF1ZSBtb2R1bGUgb2JqZWN0LiAgVHJhY2UgbWF5IG5v
dCBiZSByZWxpYWJsZS4KSnVuIDIxIDE1OjI3OjEzIGFtc2liYWNrIGtlcm5l
bDogODEzOXRvbyBGYXN0IEV0aGVybmV0IGRyaXZlciAwLjkuMjYKSnVuIDIx
IDE2OjU1OjA5IGFtc2liYWNrIGtlcm5lbDogODEzOXRvbyBGYXN0IEV0aGVy
bmV0IGRyaXZlciAwLjkuMjYKSnVuIDI2IDA0OjA0OjIzIGFtc2liYWNrIGtl
cm5lbDogVW5hYmxlIHRvIGhhbmRsZSBrZXJuZWwgTlVMTCBwb2ludGVyIGRl
cmVmZXJlbmNlIGF0IHZpcnR1YWwgYWRkcmVzcyAwMDAwMDAyOApKdW4gMjYg
MDQ6MDQ6MjMgYW1zaWJhY2sga2VybmVsOiBjYzAxZjkzMwpKdW4gMjYgMDQ6
MDQ6MjMgYW1zaWJhY2sga2VybmVsOiAqcGRlID0gMDAwMDAwMDAKSnVuIDI2
IDA0OjA0OjIzIGFtc2liYWNrIGtlcm5lbDogT29wczogMDAwMApKdW4gMjYg
MDQ6MDQ6MjMgYW1zaWJhY2sga2VybmVsOiBDUFU6ICAgIDAKSnVuIDI2IDA0
OjA0OjIzIGFtc2liYWNrIGtlcm5lbDogRUlQOiAgICAwMDYwOls8Y2MwMWY5
MzM+XSAgICBOb3QgdGFpbnRlZApVc2luZyBkZWZhdWx0cyBmcm9tIGtzeW1v
b3BzIC10IGVsZjMyLWkzODYgLWEgaTM4NgpKdW4gMjYgMDQ6MDQ6MjMgYW1z
aWJhY2sga2VybmVsOiBFRkxBR1M6IDAwMDEwMjA3Ckp1biAyNiAwNDowNDoy
MyBhbXNpYmFjayBrZXJuZWw6IGVheDogMDAwMDAwMDAgICBlYng6IDAwMDAw
MDAwICAgZWN4OiBjMTc5ZmY2MCAgIGVkeDogMDAwMDAwMDAKSnVuIDI2IDA0
OjA0OjIzIGFtc2liYWNrIGtlcm5lbDogZXNpOiBjODQ0YWVkMCAgIGVkaTog
MDAwMDAwMDAgICBlYnA6IGMwMmVmYWQ0ICAgZXNwOiBjMTc5ZmY2MApKdW4g
MjYgMDQ6MDQ6MjQgYW1zaWJhY2sga2VybmVsOiBkczogMDA2OCAgIGVzOiAw
MDY4ICAgc3M6IDAwNjgKSnVuIDI2IDA0OjA0OjI0IGFtc2liYWNrIGtlcm5l
bDogUHJvY2VzcyBrc3dhcGQgKHBpZDogNSwgc3RhY2twYWdlPWMxNzlmMDAw
KQpKdW4gMjYgMDQ6MDQ6MjQgYW1zaWJhY2sga2VybmVsOiBTdGFjazogMDAw
MDAwMDAgYzExYWQ4NjAgMDAwMDAxZDAgMDAwMDAxZDAgY2MwMmZhYTIgYzE3
ODlhNjAgYzExYWQ4NjAgMDAwMDAxZDAgCkp1biAyNiAwNDowNDoyNCBhbXNp
YmFjayBrZXJuZWw6ICAgICAgICBjMDE0MjRlYSBjMTFhZDg2MCAwMDAwMDFk
MCBjMTFhZDg3YyBjMTFhZDg2MCBjMDEzNjk5MyBjMTFhZDg2MCAwMDAwMDFk
MCAKSnVuIDI2IDA0OjA0OjI0IGFtc2liYWNrIGtlcm5lbDogICAgICAgIDAx
MDQwMDA4IDAwMDAwMDAxIDAwMDAwMDMxIGMwMmVmOTAwIDAwMDAwMDBlIGMw
MTM3ODg0IGMwMmVmOTAwIDAwMDAwMWQwIApKdW4gMjYgMDQ6MDQ6MjQgYW1z
aWJhY2sga2VybmVsOiBDYWxsIFRyYWNlOiAgIFs8Y2MwMmZhYTI+XSBleHQz
X3JlbGVhc2VwYWdlIFtleHQzXSAweDIyICgweGMxNzlmZjcwKSkKSnVuIDI2
IDA0OjA0OjI0IGFtc2liYWNrIGtlcm5lbDogWzxjMDE0MjRlYT5dIHRyeV90
b19yZWxlYXNlX3BhZ2UgW2tlcm5lbF0gMHgzYSAoMHhjMTc5ZmY4MCkpCkp1
biAyNiAwNDowNDoyNCBhbXNpYmFjayBrZXJuZWw6IFs8YzAxMzY5OTM+XSBs
YXVuZGVyX3BhZ2UgW2tlcm5lbF0gMHg1NjMgKDB4YzE3OWZmOTQpKQpKdW4g
MjYgMDQ6MDQ6MjQgYW1zaWJhY2sga2VybmVsOiBbPGMwMTM3ODg0Pl0gcmVi
YWxhbmNlX2RpcnR5X3pvbmUgW2tlcm5lbF0gMHg1NCAoMHhjMTc5ZmZiNCkp
Ckp1biAyNiAwNDowNDoyNCBhbXNpYmFjayBrZXJuZWw6IFs8YzAxMzdkZWQ+
XSBrc3dhcGQgW2tlcm5lbF0gMHgxM2QgKDB4YzE3OWZmZDQpKQpKdW4gMjYg
MDQ6MDQ6MjQgYW1zaWJhY2sga2VybmVsOiBbPGMwMTM3Y2IwPl0ga3N3YXBk
IFtrZXJuZWxdIDB4MCAoMHhjMTc5ZmZlNCkpCkp1biAyNiAwNDowNDoyNCBh
bXNpYmFjayBrZXJuZWw6IFs8YzAxMDcyYWQ+XSBrZXJuZWxfdGhyZWFkX2hl
bHBlciBba2VybmVsXSAweDUgKDB4YzE3OWZmZjApKQpKdW4gMjYgMDQ6MDQ6
MjQgYW1zaWJhY2sga2VybmVsOiBDb2RlOiA4YiA1YiAyOCBmNiA0MiAxOSAw
NCA3NSAyNCAzOSBmMyA3NSBmMSBmNyA0NCAyNCAxYyA1MCAwMCAwMCAKCgo+
PkVJUDsgY2MwMWY5MzMgPFtqYmRdam91cm5hbF90cnlfdG9fZnJlZV9idWZm
ZXJzKzIzL2EwPiAgIDw9PT09PQoKPj5lY3g7IGMxNzlmZjYwIDxfX19zdHJ0
b2srMTNmNWVlNC9iYzYyZmU0Pgo+PmVzaTsgYzg0NGFlZDAgPF9fX3N0cnRv
ays4MGEwZTU0L2JjNjJmZTQ+Cj4+ZWJwOyBjMDJlZmFkNCA8dm1fbWluX3Jl
YWRhaGVhZCs3NDgvZWY0Pgo+PmVzcDsgYzE3OWZmNjAgPF9fX3N0cnRvaysx
M2Y1ZWU0L2JjNjJmZTQ+CgpUcmFjZTsgY2MwMmZhYTIgPFtleHQzXS50ZXh0
LnN0YXJ0KzRhNDIvYjQxOT4KVHJhY2U7IGMwMTQyNGVhIDxzZXRfYmhfcGFn
ZSsxZmEvMjEwPgpUcmFjZTsgYzAxMzY5OTMgPGttZW1fZmluZF9nZW5lcmFs
X2NhY2hlcCsyNDAzLzRlZTA+ClRyYWNlOyBjMDEzNzg4NCA8a21lbV9maW5k
X2dlbmVyYWxfY2FjaGVwKzMyZjQvNGVlMD4KVHJhY2U7IGMwMTM3ZGVkIDxr
bWVtX2ZpbmRfZ2VuZXJhbF9jYWNoZXArMzg1ZC80ZWUwPgpUcmFjZTsgYzAx
MzdjYjAgPGttZW1fZmluZF9nZW5lcmFsX2NhY2hlcCszNzIwLzRlZTA+ClRy
YWNlOyBjMDEwNzJhZCA8c2hvd19yZWdzKzE1ZC80NTA+CgpDb2RlOyAgY2Mw
MWY5MzMgPFtqYmRdam91cm5hbF90cnlfdG9fZnJlZV9idWZmZXJzKzIzL2Ew
PgowMDAwMDAwMCA8X0VJUD46CkNvZGU7ICBjYzAxZjkzMyA8W2piZF1qb3Vy
bmFsX3RyeV90b19mcmVlX2J1ZmZlcnMrMjMvYTA+ICAgPD09PT09CiAgIDA6
ICAgOGIgNWIgMjggICAgICAgICAgICAgICAgICBtb3YgICAgMHgyOCglZWJ4
KSwlZWJ4ICAgPD09PT09CkNvZGU7ICBjYzAxZjkzNiA8W2piZF1qb3VybmFs
X3RyeV90b19mcmVlX2J1ZmZlcnMrMjYvYTA+CiAgIDM6ICAgZjYgNDIgMTkg
MDQgICAgICAgICAgICAgICB0ZXN0YiAgJDB4NCwweDE5KCVlZHgpCkNvZGU7
ICBjYzAxZjkzYSA8W2piZF1qb3VybmFsX3RyeV90b19mcmVlX2J1ZmZlcnMr
MmEvYTA+CiAgIDc6ICAgNzUgMjQgICAgICAgICAgICAgICAgICAgICBqbmUg
ICAgMmQgPF9FSVArMHgyZD4KQ29kZTsgIGNjMDFmOTNjIDxbamJkXWpvdXJu
YWxfdHJ5X3RvX2ZyZWVfYnVmZmVycysyYy9hMD4KICAgOTogICAzOSBmMyAg
ICAgICAgICAgICAgICAgICAgIGNtcCAgICAlZXNpLCVlYngKQ29kZTsgIGNj
MDFmOTNlIDxbamJkXWpvdXJuYWxfdHJ5X3RvX2ZyZWVfYnVmZmVycysyZS9h
MD4KICAgYjogICA3NSBmMSAgICAgICAgICAgICAgICAgICAgIGpuZSAgICBm
ZmZmZmZmZSA8X0VJUCsweGZmZmZmZmZlPgpDb2RlOyAgY2MwMWY5NDAgPFtq
YmRdam91cm5hbF90cnlfdG9fZnJlZV9idWZmZXJzKzMwL2EwPgogICBkOiAg
IGY3IDQ0IDI0IDFjIDUwIDAwIDAwICAgICAgdGVzdGwgICQweDUwLDB4MWMo
JWVzcCwxKQpDb2RlOyAgY2MwMWY5NDcgPFtqYmRdam91cm5hbF90cnlfdG9f
ZnJlZV9idWZmZXJzKzM3L2EwPgogIDE0OiAgIDAwIAoKCjIgd2FybmluZ3Mg
YW5kIDQgZXJyb3JzIGlzc3VlZC4gIFJlc3VsdHMgbWF5IG5vdCBiZSByZWxp
YWJsZS4K

--0-965955302-1088923929=:59806--
