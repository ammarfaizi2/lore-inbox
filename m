Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932221AbWF0Mae@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932221AbWF0Mae (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 08:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932236AbWF0Mad
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 08:30:33 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:8479 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932221AbWF0Mad (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 08:30:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=OeMLI3420xcOZqtvxR6lMMl+ufwrzai3c/mEks58id6UTPcVm5Fth1+7FJDiuzO8cxDmgmzO0h/KLOAJv4J0NKYC985em9O2tfBImtNXeo2J1R3Vk3coADT++bsBW+eK5zGySLhD6oydPzjXKJ/qdxDfWlDcnZ/jXOxMWzeW58o=
Message-ID: <d120d5000606270530x422988a3o4b6f586d3b6650ae@mail.gmail.com>
Date: Tue, 27 Jun 2006 08:30:31 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: "Linus Torvalds" <torvalds@osdl.org>
Subject: Re: [git pull] Input update for 2.6.17
Cc: "Greg KH" <greg@kroah.com>, "Andrew Morton" <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0606262247040.3927@g5.osdl.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_77996_27803393.1151411431635"
References: <200606260235.03718.dtor_core@ameritech.net>
	 <Pine.LNX.4.64.0606262247040.3927@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_77996_27803393.1151411431635
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 6/27/06, Linus Torvalds <torvalds@osdl.org> wrote:
> Greg? Dmitry?
>
> To trigger, you probably need both slab debugging _and_ spinlock debugging
> on. And perhaps just the right timings, although I've been able to do it
> three times in a row now, so it doesn't seem to be _that_ timing
> sensitive.
>

Yep, this was me. I need to activate more debug options by default...

I believe this patch will fix it. Sorry, I had to send it as an attachment.

-- 
Dmitry

------=_Part_77996_27803393.1151411431635
Content-Type: text/plain; name=input-fix-resetting-name.patch; 
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_eoy8lkf3
Content-Disposition: attachment; filename="input-fix-resetting-name.patch"

SW5wdXQ6IGZpeCByZXNldHRpbmcgbmFtZSwgcGh5cyBhbmQgdW5pcSB3aGVuIHVucmVnaXN0ZXJp
bmcgZGV2aWNlCgpJdCBzaG91bGQgYmUgZG9uZSBiZWZvcmUgY2FsbGluZyBjbGFzc19kZXZpY2Vf
dW5yZWdpc3RlcigpIGJlY2F1c2UKaXQgd2lsbCBkZXN0cm95IHRoZSBkZXZpY2UgYW5kIGZyZWUg
bWVtb3J5IGlmIHRoZXJlIGFyZSBubyBvdGhlcgpyZWZlcmVuY2VzIHRvIHRoZSBkZXZpY2UuCgpT
aWduZWQtb2ZmLWJ5OiBEbWl0cnkgVG9yb2tob3YgPGR0b3JAbWFpbC5ydT4KLS0tCiBkcml2ZXJz
L2lucHV0L2lucHV0LmMgfCAgICAzICsrLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygr
KSwgMSBkZWxldGlvbigtKQoKSW5kZXg6IGxpbnV4L2RyaXZlcnMvaW5wdXQvaW5wdXQuYwo9PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09Ci0tLSBsaW51eC5vcmlnL2RyaXZlcnMvaW5wdXQvaW5wdXQuYworKysgbGludXgvZHJp
dmVycy9pbnB1dC9pbnB1dC5jCkBAIC0xMDMzLDEyICsxMDMzLDEzIEBAIHZvaWQgaW5wdXRfdW5y
ZWdpc3Rlcl9kZXZpY2Uoc3RydWN0IGlucHUKIAlzeXNmc19yZW1vdmVfZ3JvdXAoJmRldi0+Y2Rl
di5rb2JqLCAmaW5wdXRfZGV2X2NhcHNfYXR0cl9ncm91cCk7CiAJc3lzZnNfcmVtb3ZlX2dyb3Vw
KCZkZXYtPmNkZXYua29iaiwgJmlucHV0X2Rldl9pZF9hdHRyX2dyb3VwKTsKIAlzeXNmc19yZW1v
dmVfZ3JvdXAoJmRldi0+Y2Rldi5rb2JqLCAmaW5wdXRfZGV2X2F0dHJfZ3JvdXApOwotCWNsYXNz
X2RldmljZV91bnJlZ2lzdGVyKCZkZXYtPmNkZXYpOwogCiAJbXV0ZXhfbG9jaygmZGV2LT5tdXRl
eCk7CiAJZGV2LT5uYW1lID0gZGV2LT5waHlzID0gZGV2LT51bmlxID0gTlVMTDsKIAltdXRleF91
bmxvY2soJmRldi0+bXV0ZXgpOwogCisJY2xhc3NfZGV2aWNlX3VucmVnaXN0ZXIoJmRldi0+Y2Rl
dik7CisKIAlpbnB1dF93YWtldXBfcHJvY2ZzX3JlYWRlcnMoKTsKIH0KIEVYUE9SVF9TWU1CT0wo
aW5wdXRfdW5yZWdpc3Rlcl9kZXZpY2UpOwo=
------=_Part_77996_27803393.1151411431635--
