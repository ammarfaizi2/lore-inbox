Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262415AbVCXGgN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262415AbVCXGgN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 01:36:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263048AbVCXGgN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 01:36:13 -0500
Received: from rproxy.gmail.com ([64.233.170.201]:53109 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262415AbVCXGgK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 01:36:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=JkI4SQaOBxWJZ/uwvvleCslwfrpCpVOLqJnFG4Jcy7kZtOOiGsjjhxxu3F4YfcPmsROALM0hLGVA9hZYmQ+dij0lDlSzUUnEHI6SD8QD7id+0n0fXwfACIVmTakYXaFrR3sKpAlU1x8UyELZwkIWinFC1qwm47lVsfmNjaxmccU=
Message-ID: <21d7e99705032322366f2f4771@mail.gmail.com>
Date: Thu, 24 Mar 2005 17:36:10 +1100
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: X not working with Radeon 9200 under 2.6.11
Cc: covici@ccs.covici.com, linux-kernel@vger.kernel.org,
       benh@kernel.crashing.org, airlied@linux.ie
In-Reply-To: <20050321162214.71483708.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_28_11513560.1111646170403"
References: <16937.54786.986183.491118@ccs.covici.com>
	 <20050321145301.3511c097.akpm@osdl.org>
	 <16959.25374.535872.507486@ccs.covici.com>
	 <20050321162214.71483708.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_28_11513560.1111646170403
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

> 
> It's a bit sad that xfree _used_ to work (2.6.9?) and now it doesn't work,
> and the fix is to switch to the x.org server.
> 
> Do we know what changed to cause this?  Was it deliberate?

Okay I installed Debian Sarge today and found a bug in the drm version
ioctls alright with the older interface that XFree86 4.3 uses...

Anyone want to test this patch (Andrew I'll put it my -mm tree ASAP)...

I'm still at a loss to reproduce the brige problems ppl are seeing..
time to switch to i865 chipset ...

Dave.

------=_Part_28_11513560.1111646170403
Content-Type: application/octet-stream; name="drm_test_diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="drm_test_diff"

PT09PT0gZHJpdmVycy9jaGFyL2RybS9kcm1fZHJ2LmMgMS42MyB2cyBlZGl0ZWQgPT09PT0KLS0t
IDEuNjMvZHJpdmVycy9jaGFyL2RybS9kcm1fZHJ2LmMJMjAwNS0wMy0xMCAyMDoxOTo0MiArMTE6
MDAKKysrIGVkaXRlZC9kcml2ZXJzL2NoYXIvZHJtL2RybV9kcnYuYwkyMDA1LTAzLTI0IDE3OjA3
OjE2ICsxMTowMApAQCAtMTQ0LDYgKzE0NCwxMiBAQAogCWlmIChkZXYtPmRyaXZlci0+cHJldGFr
ZWRvd24pCiAJICBkZXYtPmRyaXZlci0+cHJldGFrZWRvd24oZGV2KTsKIAorCWlmIChkZXYtPnVu
aXF1ZSkgeworCQlkcm1fZnJlZShkZXYtPnVuaXF1ZSwgc3RybGVuKGRldi0+dW5pcXVlKSArIDEs
IERSTV9NRU1fRFJJVkVSKTsKKwkJZGV2LT51bmlxdWUgPSBOVUxMOworCQlkZXYtPnVuaXF1ZV9s
ZW4gPSAwOworCX0KKwogCWlmICggZGV2LT5pcnFfZW5hYmxlZCApIGRybV9pcnFfdW5pbnN0YWxs
KCBkZXYgKTsKIAogCWRvd24oICZkZXYtPnN0cnVjdF9zZW0gKTsK
------=_Part_28_11513560.1111646170403--
