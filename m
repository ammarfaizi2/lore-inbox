Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262712AbVAFDzh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262712AbVAFDzh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 22:55:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262713AbVAFDzh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 22:55:37 -0500
Received: from web8404.mail.in.yahoo.com ([202.43.219.152]:14245 "HELO
	web8404.mail.in.yahoo.com") by vger.kernel.org with SMTP
	id S262712AbVAFDzZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 22:55:25 -0500
Message-ID: <20050106035522.46252.qmail@web8404.mail.in.yahoo.com>
Date: Thu, 6 Jan 2005 03:55:22 +0000 (GMT)
From: neha agrawal <nehavrce@yahoo.co.in>
Subject: RAW socket prgmming
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-989768986-1104983722=:42575"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-989768986-1104983722=:42575
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

hello!

        i want to implement smtp protocol on the same
machine.i have a libpcap trace file..in which i have
captured mail traffic..(single session).and i want to
develop a program which can read this trace file..and
communicate with the smtp server...
    first packet is Sync packet in trace file..so i
want to send it to smtp server...and then i want my
progrem to handle the reply sent by server..(say it
sent Syn-Ack) anf then my prgm should reply
accordingly..
       for doing this i am using PF_PACKET , SOCK_RAW
and using sendto function...i am sending the
packet..im able to see it through tcpdump...but
theserver is not replying...why??i am wrking with
linux Redhat 9 kernel 2.4.20-8
     
       (...if u r familiar with flowreplay tool..i
want to do something similar ...but mine is single
session..so less complicated...)

    attching source code...

 do let me know..if i am on correct track...
                                          thnks
                                           Neha

________________________________________________________________________
Yahoo! India Matrimony: Find your life partner online
Go to: http://yahoo.shaadi.com/india-matrimony
--0-989768986-1104983722=:42575
Content-Type: application/octet-stream; name="tcp1.c"
Content-Transfer-Encoding: base64
Content-Description: tcp1.c
Content-Disposition: attachment; filename="tcp1.c"

I2luY2x1ZGUgInRjcC5oIgojaW5jbHVkZTxzeXMvaW9jdGwuaD4KI2luY2x1
ZGU8bmV0L2lmLmg+CiNkZWZpbmUgUFJPVE8gaHRvbnMoRVRIX1BfQUxMKQoK
aW50IG1haW4oKQp7CiAgLy91bnNpZ25lZCBjaGFyIHBhY2tldFs3NF07Cgog
IHN0cnVjdCBzb2NrYWRkcl9sbCBteXNvY2tldCx0byxmcm9tOwogIGludCBm
cm9tbGVuOwogIHN0cnVjdCB0Y3BoZHIgKnRjcDsKICBpbnQgc29ja2QsIHNk
LG9uID0gMTsKICB1bnNpZ25lZCBjaGFyIHJidWZbMTUwMF07CiAgaW50IGks
bjsKICBjaGFyIGVycmJ1ZltQQ0FQX0VSUkJVRl9TSVpFXTsKICBwY2FwX3Qq
IGRlc2NyOwogIGNvbnN0IHVfY2hhciAqcGFja2V0OwogIHN0cnVjdCBwY2Fw
X3BrdGhkciBoZHI7ICAgICAvKiBwY2FwLmggKi8KICBzdHJ1Y3QgZXRoZXJf
aGVhZGVyICplcHRyOyAgLyogbmV0L2V0aGVybmV0LmggKi8KICB1X2NoYXIg
KnB0cjsgLyogcHJpbnRpbmcgb3V0IGhhcmR3YXJlIGhlYWRlciBpbmZvICov
CiAgc3RydWN0IGlwaGRyICppcDsKICBzdHJ1Y3QgaWZyZXEgaWZyOwoKICBk
ZXNjciA9IHBjYXBfb3Blbl9vZmZsaW5lKCIvcm9vdC9zMS50cmFjZSIsZXJy
YnVmKTsKICAgIGlmKGRlc2NyID09IE5VTEwpCiAgICB7CiAgICAgICAgcHJp
bnRmKCJwY2FwX29wZW5fb2ZmbGluZSgpOiAlc1xuIixlcnJidWYpOwogICAg
ICAgIGV4aXQoMSk7CiAgICB9CiAgICBwYWNrZXQgPSBwY2FwX25leHQoZGVz
Y3IsJmhkcik7CiAgICBpZihwYWNrZXQgPT0gTlVMTCkKICAgIHsKICAgICAg
ICBwcmludGYoIkRpZG4ndCBncmFiIHBhY2tldFxuIik7CiAgICAgICAgZXhp
dCgxKTsKICAgIH0KCiAgIGlmKChzb2NrZCA9IHNvY2tldChQRl9QQUNLRVQs
U09DS19SQVcsUFJPVE8pKSA8IDApICAKICAgewogICAgIHBlcnJvcigic29j
a2V0Iik7CiAgICAgZXhpdCgxKTsKICAgfQogCiAgc3RybmNweShpZnIuaWZy
X25hbWUsICJsbyIsIHNpemVvZihpZnIuaWZyX25hbWUpKTsKICBpZiAoaW9j
dGwoc29ja2QsIFNJT0NHSUZJTkRFWCwgJmlmcikgPT0gLTEpCiAgIHsKICAg
IGZwcmludGYoc3RkZXJyLCAiU0lPQ0dJRklOREVYIG9uICVzIGZhaWxlZDog
JXNcbiIsICJsbyIsc3RyZXJyb3IoZXJybm8pKTsKICAgIHByaW50ZigibXkg
ZXJyb3JcbiIpOwogICAgcmV0dXJuIDE7CiAgIH0KIAoKICBtZW1zZXQoJm15
c29ja2V0LCdcMCcsc2l6ZW9mKG15c29ja2V0KSk7ICAKICBteXNvY2tldC5z
bGxfZmFtaWx5ID0gQUZfUEFDS0VUOwogIG15c29ja2V0LnNsbF9wcm90b2Nv
bCA9aHRvbnMoRVRIX1BfQUxMKTsgCiAgbXlzb2NrZXQuc2xsX2lmaW5kZXgg
ID0gaWZyLmlmcl9pZmluZGV4OwogICAgCiAgaWYgKGJpbmQoc29ja2QsKHN0
cnVjdCBzb2NrYWRkciAqKSZteXNvY2tldCwgc2l6ZW9mKG15c29ja2V0KSkg
PDApIAogICAgewogICAgIHBlcnJvcigiQmluZCIpOwogICAgIGV4aXQoMSk7
CiAgICB9CiAgICBwcmludGYoIkJpbmQgc3VjY2VjY2VkIFxuIik7CgogIG1l
bXNldCgmdG8gLCAwLHNpemVvZih0bykpOwogIHRvLnNsbF9mYW1pbHkgPSBB
Rl9QQUNLRVQ7CiAgdG8uc2xsX3Byb3RvY29sID1odG9ucyhFVEhfUF9BTEwp
OyAKICB0by5zbGxfaWZpbmRleCAgPSBpZnIuaWZyX2lmaW5kZXg7CiAgdG8u
c2xsX2hhbGVuID0gRVRIX0FMRU47CiAgbWVtY3B5KHRvLnNsbF9hZGRyLHBh
Y2tldCxFVEhfQUxFTik7CgoKIGlwID0gKHN0cnVjdCBpcGhkciAqKSBwYWNr
ZXQ7ICAKIHByaW50ZigiSWQxICVkXG4iLGlwLT50dGwpOwogaXAtPmlkPWh0
b25zKGdldHVpZCgpKTsKIHByaW50ZigiSUQyICVkXG4iLChpcC0+aWQpKTsK
ICBuID0gc2VuZHRvKHNvY2tkLHBhY2tldCw3NCwweDAsKHN0cnVjdCBzb2Nr
YWRkciAqKSZ0byxzaXplb2YodG8pKTsgICAKICBpZihuIDwgMCkgIAogICB7
CiAgICBwZXJyb3IoInNlbmR0byIpOwogICAgZXhpdCgxKTsKICAgIH0KIGVs
c2UgIHByaW50ZigiUGFja2V0IHNlbmQgJWQgYnl0ZXMgXG4iLG4pOwogIAog
IC8qIGNhcHR1cmUgKi8KICBwcmludGYoIk5vdyByZWNldlxuIik7CiAgCiAg
CiAgYnplcm8ocmJ1ZixzaXplb2YocmJ1ZikpOwogIGZyb21sZW4gPSBzaXpl
b2YoZnJvbSk7CiAgbiA9IHJlY3Zmcm9tKHNvY2tkLHJidWYsc2l6ZW9mKHJi
dWYpLDAsKHN0cnVjdCBzb2NrYWRkciAqKSZmcm9tLCZmcm9tbGVuKTsKIAog
ICBpZihuIDwgMCkgIHByaW50ZigiRVJST1JcbiIpOwogICAgZWxzZSBwcmlu
dGYoIlJFQ0VpdmVkICVkYnl0ZXNcbiIsbik7ICAKICAKICAgcHJpbnRmKCJQ
YWNrZXQgdHlwZSAlZFxuIixmcm9tLnNsbF9wa3R0eXBlKTsKICAgcHJpbnRm
KCJQYWNrZXQgaGF0eXBlICVkXG4iLGZyb20uc2xsX2hhdHlwZSk7CgoKICAg
IGVwdHIgPSAoc3RydWN0IGV0aGVyX2hlYWRlciAqKSByYnVmOwogICAgaWYg
KG50b2hzIChlcHRyLT5ldGhlcl90eXBlKSA9PSBFVEhFUlRZUEVfSVApCiAg
ICB7CiAgICAgICAgcHJpbnRmKCJFdGhlcm5ldCB0eXBlIGhleDoleCBkZWM6
JWQgaXMgYW4gSVAgcGFja2V0XG4iLAogICAgICAgICAgICAgICAgbnRvaHMo
ZXB0ci0+ZXRoZXJfdHlwZSksCiAgICAgICAgICAgICAgICBudG9ocyhlcHRy
LT5ldGhlcl90eXBlKSk7CiAgICB9CiAgICAgICBlbHNlICBpZiAobnRvaHMg
KGVwdHItPmV0aGVyX3R5cGUpID09IEVUSEVSVFlQRV9BUlApCiAgICAgIHsK
ICAgICAgICBwcmludGYoIkV0aGVybmV0IHR5cGUgaGV4OiV4IGRlYzolZCBp
cyBhbiBBUlAgcGFja2V0XG4iLAogICAgICAgICAgICAgICAgbnRvaHMoZXB0
ci0+ZXRoZXJfdHlwZSksCiAgICAgICAgICAgICAgICBudG9ocyhlcHRyLT5l
dGhlcl90eXBlKSk7CiAgICAgIH0KICAgICAgZWxzZSAKICAgICAgIHsKICAg
ICAgICBwcmludGYoIkV0aGVybmV0IHR5cGUgJXggbm90IElQIiwgbnRvaHMo
ZXB0ci0+ZXRoZXJfdHlwZSkpOwogICAgICAgIGV4aXQoMSk7CiAgICAgIH0K
CiAgIGlwID0gKHN0cnVjdCBpcGhkciAqKXJidWY7CiAgIHByaW50ZigiVmVy
c2lvbiAlZFxuIixpcC0+dmVyc2lvbik7CiAgIHByaW50ZigiUHJvdG9jb2wg
JWRcbiIsaXAtPnByb3RvY29sKTsKICAgLy9wcmludGYoIlNvdXJjZSBJUDog
JXMgXHQgRGVzdG4gSVA6ICVzIFxuIixpbmV0X250b2EoaXAtPnNhZGRyKSAs
IGluZXRfbnRvYShpcC0+ZGFkZHIpKTsKICAgdGNwICA9IChzdHJ1Y3QgdGNw
aGRyICopIHJidWY7CiAgIHByaW50ZigiU291Y2UgJTA0ZCBhbmQgZGVzdG4g
cG9ydCAlMDRkXG4iLCBudG9ocyh0Y3AtPnNvdXJjZSksIG50b2hzKHRjcC0+
ZGVzdCkpOyAgIAogCiAgZXhpdCgwKTsKfQo=

--0-989768986-1104983722=:42575
Content-Type: application/octet-stream; name="tcp.h"
Content-Transfer-Encoding: base64
Content-Description: tcp.h
Content-Disposition: attachment; filename="tcp.h"

I2luY2x1ZGUgPHN0ZGxpYi5oPgojaW5jbHVkZSA8c3RkaW8uaD4KI2luY2x1
ZGU8cGNhcC5oPgojaW5jbHVkZTxlcnJuby5oPgovLyNpbmNsdWRlIDxsaWJu
ZC5oPgojaW5jbHVkZSA8c3lzL3R5cGVzLmg+CiNpbmNsdWRlIDxzeXMvc29j
a2V0Lmg+CgojaW5jbHVkZSA8bmV0aW5ldC9pbi5oPgojaW5jbHVkZSA8YXJw
YS9pbmV0Lmg+CgojaW5jbHVkZSA8bmV0aW5ldC9pbl9zeXN0bS5oPgoKI2lu
Y2x1ZGUgPGxpbnV4L2lwLmg+CiNpbmNsdWRlIDxsaW51eC90Y3AuaD4KI2lu
Y2x1ZGUgPG5ldGluZXQvaWZfZXRoZXIuaD4KCiNpbmNsdWRlPG5ldHBhY2tl
dC9wYWNrZXQuaD4KI2luY2x1ZGUgPHN0cmluZy5oPgojaW5jbHVkZSA8dW5p
c3RkLmg+CiNpbmNsdWRlIDx0aW1lLmg+Cg==

--0-989768986-1104983722=:42575--
