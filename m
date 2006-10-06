Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750765AbWJFIDt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbWJFIDt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 04:03:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbWJFIDt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 04:03:49 -0400
Received: from wx-out-0506.google.com ([66.249.82.237]:58184 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750765AbWJFIDr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 04:03:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=Ad3c5YRgDQw3JAFKQeOND3YAvmlPV61WKk4lW93PVKJRboS/tmdI3y+rqHyTEXkFtM8nGQGapuY1NBGT0w5ZBcNFhLMCAz3EtWFor/LkcupobRYzT419tBM/dloGXCk3/oGWbbeHpUMYy4tRNjtVZ4R9/ZRSnGjuajdooF4G7Q4=
Message-ID: <9d2cd630610060103y1703f6b4w86bb6e08f872238c@mail.gmail.com>
Date: Fri, 6 Oct 2006 10:03:46 +0200
From: "Gregor Jasny" <gjasny@googlemail.com>
To: "David Howells" <dhowells@redhat.com>
Subject: Re: [PATCH 3/3] IRQ: Maintain regs pointer globally rather than passing to IRQ handlers
Cc: "Andrew Morton" <akpm@osdl.org>, "Thomas Gleixner" <tglx@linutronix.de>,
       "Ingo Molnar" <mingo@elte.hu>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       "Dmitry Torokhov" <dtor@mail.ru>, "Greg KH" <greg@kroah.com>,
       "David Brownell" <david-b@pacbell.net>,
       "Alan Stern" <stern@rowland.harvard.edu>
In-Reply-To: <18975.1160058127@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_163467_15113183.1160121826742"
References: <20061002162049.17763.39576.stgit@warthog.cambridge.redhat.com>
	 <20061002162053.17763.26032.stgit@warthog.cambridge.redhat.com>
	 <20061002132116.2663d7a3.akpm@osdl.org>
	 <18975.1160058127@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_163467_15113183.1160121826742
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I need the following patch to compile the latest git snapshot from Linus.

Gregor

------=_Part_163467_15113183.1160121826742
Content-Type: text/x-patch; name=apic-irq.diff; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_esyagib8
Content-Disposition: attachment; filename="apic-irq.diff"

U2lnbmVkLW9mZi1ieTogR3JlZ29yIEphc255IDxnamFzbnlAd2ViLmRlPgotLS0gCmRpZmYgLS1n
aXQgYS9hcmNoL2kzODYva2VybmVsL2FwaWMuYyBiL2FyY2gvaTM4Ni9rZXJuZWwvYXBpYy5jCmlu
ZGV4IDdkNTAwZGEuLjJmZDRiN2QgMTAwNjQ0Ci0tLSBhL2FyY2gvaTM4Ni9rZXJuZWwvYXBpYy5j
CisrKyBiL2FyY2gvaTM4Ni9rZXJuZWwvYXBpYy5jCkBAIC0xMTk3LDcgKzExOTcsNyBAQCBpbmxp
bmUgdm9pZCBzbXBfbG9jYWxfdGltZXJfaW50ZXJydXB0KHZvCiB7CiAJcHJvZmlsZV90aWNrKENQ
VV9QUk9GSUxJTkcpOwogI2lmZGVmIENPTkZJR19TTVAKLQl1cGRhdGVfcHJvY2Vzc190aW1lcyh1
c2VyX21vZGVfdm0oaXJxX3JlZ3MpKTsKKwl1cGRhdGVfcHJvY2Vzc190aW1lcyh1c2VyX21vZGVf
dm0oZ2V0X2lycV9yZWdzKCkpKTsKICNlbmRpZgogCiAJLyoK
------=_Part_163467_15113183.1160121826742--
