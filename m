Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261433AbTJ2TTg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 14:19:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261473AbTJ2TTg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 14:19:36 -0500
Received: from 198.216-123-194-0.interbaun.com ([216.123.194.198]:14060 "EHLO
	mail.harddata.com") by vger.kernel.org with ESMTP id S261433AbTJ2TT2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 14:19:28 -0500
Message-Id: <5.1.1.6.0.20031029120536.03db3840@mail.harddata.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1.1
Date: Wed, 29 Oct 2003 12:21:16 -0700
To: linux-kernel@vger.kernel.org
From: Mark Lane <mark@harddata.com>
Subject: 2.4.22 and Athlon64
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="=====================_68529591==_"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=====================_68529591==_
Content-Type: text/plain; charset="us-ascii"; format=flowed

I am having trouble compiling the 2.4.22 kernel for x86-64 non-smp. I can 
compile the smp kernel but not the regular kernel.

It seems that ksyms.c for x86-64 is looking for some smp stuff from the 
errors I am getting.

I have tried 2.4.23-8 and the problem seems gone but I get an error when 
linking fs/fs.o into vmlinux. I have attached the errors I received.

TIA,

-- 
Mark Lane, CET  mailto:mark@harddata.com
Hard Data Ltd.  http://www.harddata.com
T: 01-780-456-9771      F: 01-780-456-9772
11060 - 166 Avenue Edmonton, AB, Canada, T5X 1Y3
--> Ask me about our Excellent 1U Systems! <--
--=====================_68529591==_
Content-Type: application/octet-stream; name="compile_error.log"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="compile_error.log"

bGQgLW0gZWxmX3g4Nl82NCAtVCAvdXNyL3NyYy9saW51eC0yLjQuMjIvYXJjaC94ODZfNjQvdm1s
aW51eC5sZHMgLWUgc3RleHQgYXJjaC94ODZfNjQva2VybmVsL2hlYWQubyBhcmNoL3g4Nl82NC9r
ZXJuZWwvaGVhZDY0Lm8gYXJjaC94ODZfNjQva2VybmVsL2luaXRfdGFzay5vIGluaXQvbWFpbi5v
IGluaXQvdmVyc2lvbi5vIGluaXQvZG9fbW91bnRzLm8gXAogICAgICAgIC0tc3RhcnQtZ3JvdXAg
XAogICAgICAgIGFyY2gveDg2XzY0L2tlcm5lbC9rZXJuZWwubyBrZXJuZWwva2VybmVsLm8gbW0v
bW0ubyBmcy9mcy5vIGlwYy9pcGMubyBhcmNoL3g4Nl82NC9tbS9tbS5vIGFyY2gveDg2XzY0L2lh
MzIvaWEzMi5vICBcCiAgICAgICAgIGRyaXZlcnMvY2hhci9jaGFyLm8gZHJpdmVycy9ibG9jay9i
bG9jay5vIGRyaXZlcnMvbWlzYy9taXNjLm8gZHJpdmVycy9uZXQvbmV0Lm8gZHJpdmVycy9jaGFy
L2RybS9kcm0ubyBkcml2ZXJzL25ldC9mYy9mYy5vIGRyaXZlcnMvbmV0L2FwcGxldGFsay9hcHBs
ZXRhbGsubyBkcml2ZXJzL25ldC90b2tlbnJpbmcvdHIubyBkcml2ZXJzL25ldC93YW4vd2FuLm8g
ZHJpdmVycy9hdG0vYXRtLm8gZHJpdmVycy9pZGUvaWRlZHJpdmVyLm8gZHJpdmVycy9jZHJvbS9k
cml2ZXIubyBkcml2ZXJzL3BjaS9kcml2ZXIubyBkcml2ZXJzL25ldC93aXJlbGVzcy93aXJlbGVz
c19uZXQubyBkcml2ZXJzL3ZpZGVvL3ZpZGVvLm8gZHJpdmVycy9tZWRpYS9tZWRpYS5vIGRyaXZl
cnMvbWQvbWRkZXYubyBkcml2ZXJzL2lzZG4vdm1saW51eC1vYmoubyBjcnlwdG8vY3J5cHRvLm8g
XAogICAgICAgIG5ldC9uZXR3b3JrLm8gXAogICAgICAgIC91c3Ivc3JjL2xpbnV4LTIuNC4yMi9h
cmNoL3g4Nl82NC9saWIvbGliLmEgL3Vzci9zcmMvbGludXgtMi40LjIyL2xpYi9saWIuYSBcCiAg
ICAgICAgLS1lbmQtZ3JvdXAgXAogICAgICAgIC1vIHZtbGludXgKZnMvZnMubygudGV4dCsweDE0
MjlmKTogSW4gZnVuY3Rpb24gYGRwdXQnOgo6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8gYGF0b21p
Y19kZWNfYW5kX2xvY2snCm1ha2U6ICoqKiBbdm1saW51eF0gRXJyb3IgMQo=
--=====================_68529591==_--

