Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263572AbUCYUCn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 15:02:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263594AbUCYUCn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 15:02:43 -0500
Received: from colino.net ([62.212.100.143]:58096 "EHLO paperstreet.colino.net")
	by vger.kernel.org with ESMTP id S263572AbUCYUCi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 15:02:38 -0500
Date: Thu, 25 Mar 2004 21:01:54 +0100
From: Colin Leroy <colin@colino.net>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Kernel development list <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [PATCH] Re: [linux-usb-devel] Re: [OOPS] reproducible oops with
 2.6.5-rc2-bk3
Message-Id: <20040325210154.20b87112@jack.colino.net>
In-Reply-To: <Pine.LNX.4.44L0.0403251341550.1083-100000@ida.rowland.org>
References: <20040325184620.3b6b070c@jack.colino.net>
	<Pine.LNX.4.44L0.0403251341550.1083-100000@ida.rowland.org>
Organization: 
X-Mailer: Sylpheed version 0.9.8claws (GTK+ 2.2.4; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Thu__25_Mar_2004_21_01_54_+0100_WaiamQ4S+1aPaT+E"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart=_Thu__25_Mar_2004_21_01_54_+0100_WaiamQ4S+1aPaT+E
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On 25 Mar 2004 at 13h03, Alan Stern wrote:

Hi, 

> In this case, your patch could be improved by calling device_initialize()  
> during the first loop and device_add() during the second. 

Here you are :)
-- 
Colin

--Multipart=_Thu__25_Mar_2004_21_01_54_+0100_WaiamQ4S+1aPaT+E
Content-Type: application/octet-stream;
 name="cdc-acm.oops.patch"
Content-Disposition: attachment;
 filename="cdc-acm.oops.patch"
Content-Transfer-Encoding: base64

LS0tIGRyaXZlcnMvdXNiL2NvcmUvbWVzc2FnZS5jLm9yaWcJMjAwNC0wMy0yNSAxODozNDowNC4w
MDAwMDAwMDAgKzAxMDAKKysrIGRyaXZlcnMvdXNiL2NvcmUvbWVzc2FnZS5jCTIwMDQtMDMtMjUg
MjA6NTM6MDYuMDAwMDAwMDAwICswMTAwCkBAIC0xMTc5LDEwICsxMTc5LDI0IEBACiAJCQkJIGNv
bmZpZ3VyYXRpb24sCiAJCQkJIGFsdC0+ZGVzYy5iSW50ZXJmYWNlTnVtYmVyKTsKIAkJCWRldl9k
YmcgKCZkZXYtPmRldiwKKwkJCQkiaW5pdGlhbGl6aW5nICVzIChjb25maWcgIyVkLCBpbnRlcmZh
Y2UgJWQpXG4iLAorCQkJCWludGYtPmRldi5idXNfaWQsIGNvbmZpZ3VyYXRpb24sCisJCQkJaW50
Zi0+Y3VyX2FsdHNldHRpbmctPmRlc2MuYkludGVyZmFjZU51bWJlcik7CisJCQlkZXZpY2VfaW5p
dGlhbGl6ZSAoJmludGYtPmRldik7CQkJCisJCX0KKwkJCisJCS8qIGFsbCBpbnRlcmZhY2VzIGFy
ZSBpbml0aWFsaXplZCwgd2UgY2FuIG5vdyAKKwkJICogcmVnaXN0ZXIgdGhlbQorCQkgKi8KKwkJ
Zm9yIChpID0gMDsgaSA8IGNwLT5kZXNjLmJOdW1JbnRlcmZhY2VzOyArK2kpIHsKKwkJCXN0cnVj
dCB1c2JfaW50ZXJmYWNlICppbnRmID0gY3AtPmludGVyZmFjZVtpXTsKKwkJCWRldl9kYmcgKCZk
ZXYtPmRldiwKIAkJCQkicmVnaXN0ZXJpbmcgJXMgKGNvbmZpZyAjJWQsIGludGVyZmFjZSAlZClc
biIsCiAJCQkJaW50Zi0+ZGV2LmJ1c19pZCwgY29uZmlndXJhdGlvbiwKLQkJCQlhbHQtPmRlc2Mu
YkludGVyZmFjZU51bWJlcik7Ci0JCQlkZXZpY2VfcmVnaXN0ZXIgKCZpbnRmLT5kZXYpOworCQkJ
CWludGYtPmN1cl9hbHRzZXR0aW5nLT5kZXNjLmJJbnRlcmZhY2VOdW1iZXIpOworCQkJaWYgKChy
ZXQgPSBkZXZpY2VfYWRkICgmaW50Zi0+ZGV2KSkgPCAwKQorCQkJCWdvdG8gb3V0OworCQkJCQog
CQkJdXNiX2NyZWF0ZV9kcml2ZXJmc19pbnRmX2ZpbGVzIChpbnRmKTsKIAkJfQogCX0K

--Multipart=_Thu__25_Mar_2004_21_01_54_+0100_WaiamQ4S+1aPaT+E--
