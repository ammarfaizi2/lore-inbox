Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267178AbTA0MAi>; Mon, 27 Jan 2003 07:00:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267180AbTA0MAi>; Mon, 27 Jan 2003 07:00:38 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:3456 "EHLO
	bilbo.tmr.com") by vger.kernel.org with ESMTP id <S267178AbTA0MAh>;
	Mon, 27 Jan 2003 07:00:37 -0500
Date: Mon, 27 Jan 2003 07:18:09 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
X-X-Sender: root@bilbo.tmr.com
Reply-To: Bill Davidsen <davidsen@tmr.com>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [2.5.59] sym53c8xx module fails to initialize
Message-ID: <Pine.LNX.4.44.0301270707090.24427-200000@bilbo.tmr.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463810548-1894543939-1043669889=:24427"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1463810548-1894543939-1043669889=:24427
Content-Type: TEXT/PLAIN; charset=US-ASCII

Attached to prevent munging is the output from trying to get 2.5.59 to see 
my SCSI controller. lspci shows it present, the module is in the modules 
tree. Loading the module results in output saying the device is not 
present, however the log message shows that it was found.

Needless to say, this works nicely under 2.4.18 and 2.4.20. Also BSD if
anyone cares, which has a really nice Linux environment at least as
functional as UML.

This is the "old" module, not the 8xx-2 which finds the controller and CD 
burner but not the tape drive or disk. That's another problem for another 
day.

Any suggestions to get this working?

-- 
bill davidsen, CTO TMR Associates, Inc <davidsen@tmr.com>
  Having the feature freeze for Linux 2.5 on Hallow'een is appropriate,
since using 2.5 kernels includes a lot of things jumping out of dark
corners to scare you.


---1463810548-1894543939-1043669889=:24427
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="x.tmp"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0301270718091.24427@bilbo.tmr.com>
Content-Description: 
Content-Disposition: attachment; filename="x.tmp"

U2NyaXB0IHN0YXJ0ZWQgb24gTW9uIEphbiAyNyAwNzowMDozMyAyMDAzDQpD
b21tb24gcHJvZmlsZSAxLjEwIGxhc3Rtb2QgMjAwMi0xMS0yOSAxMDozNjoz
OS0wNQ0KTm8gY29tbW9uIGRpcmVjdG9yeSBhdmFpbGFibGUNClNlc3Npb24g
dGltZSAwNzowMDozMyBvbiAwMS8yNy8wMw0KDQpiaWxibzpyb290PiBsc3Bj
aQ0KMDA6MDAuMCBIb3N0IGJyaWRnZTogSW50ZWwgQ29ycC4gNDQwQlgvWlgv
RFggLSA4MjQ0M0JYL1pYL0RYIEhvc3QgYnJpZGdlIChyZXYgMDMpDQowMDow
MS4wIFBDSSBicmlkZ2U6IEludGVsIENvcnAuIDQ0MEJYL1pYL0RYIC0gODI0
NDNCWC9aWC9EWCBBR1AgYnJpZGdlIChyZXYgMDMpDQowMDowNy4wIElTQSBi
cmlkZ2U6IEludGVsIENvcnAuIDgyMzcxQUIvRUIvTUIgUElJWDQgSVNBIChy
ZXYgMDIpDQowMDowNy4xIElERSBpbnRlcmZhY2U6IEludGVsIENvcnAuIDgy
MzcxQUIvRUIvTUIgUElJWDQgSURFIChyZXYgMDEpDQowMDowNy4yIFVTQiBD
b250cm9sbGVyOiBJbnRlbCBDb3JwLiA4MjM3MUFCL0VCL01CIFBJSVg0IFVT
QiAocmV2IDAxKQ0KMDA6MDcuMyBCcmlkZ2U6IEludGVsIENvcnAuIDgyMzcx
QUIvRUIvTUIgUElJWDQgQUNQSSAocmV2IDAyKQ0KMDA6MDkuMCBTQ1NJIHN0
b3JhZ2UgY29udHJvbGxlcjogTFNJIExvZ2ljIC8gU3ltYmlvcyBMb2dpYyAo
Zm9ybWVybHkgTkNSKSA1M2M4MjUgKHJldiAwMikNCjAwOjBkLjAgTXVsdGlt
ZWRpYSBhdWRpbyBjb250cm9sbGVyOiBDaXJydXMgTG9naWMgQ1MgNDYxNC8y
Mi8yNCBbQ3J5c3RhbENsZWFyIFNvdW5kRnVzaW9uIEF1ZGlvIEFjY2VsZXJh
dG9yXSAocmV2IDAxKQ0KMDA6MGYuMCBWR0EgY29tcGF0aWJsZSBjb250cm9s
bGVyOiBTMyBJbmMuIDg2Yzk2OCBbVmlzaW9uIDk2OCBWUkFNXSByZXYgMA0K
MDA6MTMuMCBVbmtub3duIG1hc3Mgc3RvcmFnZSBjb250cm9sbGVyOiBUcmlv
bmVzIFRlY2hub2xvZ2llcywgSW5jLiBIUFQzNjYgLyBIUFQzNzAgKHJldiAw
MSkNCjAwOjEzLjEgVW5rbm93biBtYXNzIHN0b3JhZ2UgY29udHJvbGxlcjog
VHJpb25lcyBUZWNobm9sb2dpZXMsIEluYy4gSFBUMzY2IC8gSFBUMzcwIChy
ZXYgMDEpDQoNCmJpbGJvOnJvb3Q+IGZpbmQgL2xpYi9tb2R1bGVzLyQodW5h
bWUgLXIpIC1uYW1lICcqeHgqJw0KL2xpYi9tb2R1bGVzLzIuNS41OS9rZXJu
ZWwvZHJpdmVycy9zY3NpL3N5bTUzYzh4eC5rbw0KDQpiaWxibzpyb290PiBt
b2Rwcm9iZSBzeW01M2M4eHgNCkZBVEFMOiBFcnJvciBpbnNlcnRpbmcgc3lt
NTNjOHh4ICgvbGliL21vZHVsZXMvMi41LjU5L2tlcm5lbC9kcml2ZXJzL3Nj
c2kvc3ltNTNjOHh4LmtvKTogTm8gc3VjaCBkZXZpY2UNCg0KYmlsYm86cm9v
dD4gdGFpbCAtNSAvdmFyL2xvZy9tZXNzYWdlcw0KSmFuIDI3IDA2OjUzOjE2
IGJpbGJvIHNzaGRbMjQyMzNdOiBBY2NlcHRlZCBwYXNzd29yZCBmb3IgZGF2
aWRzZW4gZnJvbSAxOTIuMTY4LjEyLjYyIHBvcnQgMTAyMw0KSmFuIDI3IDA2
OjU3OjIxIGJpbGJvIHNzaGRbMjQyNzldOiBBY2NlcHRlZCBwYXNzd29yZCBm
b3IgZGF2aWRzZW4gZnJvbSAxOTIuMTY4LjEyLjYyIHBvcnQgMTAyMw0KSmFu
IDI3IDA2OjU3OjI5IGJpbGJvIHN1KHBhbV91bml4KVsyNDMyMF06IHNlc3Np
b24gb3BlbmVkIGZvciB1c2VyIHJvb3QgYnkgZGF2aWRzZW4odWlkPTUwMCkN
CkphbiAyNyAwNzowMToxNiBiaWxibyBrZXJuZWw6IHN5bTUzYzh4eDogYXQg
UENJIGJ1cyAwLCBkZXZpY2UgOSwgZnVuY3Rpb24gMA0KSmFuIDI3IDA3OjAx
OjE2IGJpbGJvIGtlcm5lbDogc3ltNTNjOHh4OiBub3QgaW5pdGlhbGl6aW5n
LCBkZXZpY2Ugbm90IHN1cHBvcnRlZA0KDQpTY3JpcHQgZG9uZSBvbiBNb24g
SmFuIDI3IDA3OjAzOjAyIDIwMDMNCg==
---1463810548-1894543939-1043669889=:24427--
