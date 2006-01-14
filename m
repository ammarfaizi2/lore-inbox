Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750749AbWANLlD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750749AbWANLlD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 06:41:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750918AbWANLlC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 06:41:02 -0500
Received: from cac94-1-81-57-151-96.fbx.proxad.net ([81.57.151.96]:35038 "EHLO
	localhost") by vger.kernel.org with ESMTP id S1750749AbWANLlA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 06:41:00 -0500
Message-ID: <43C8E3A6.2050103@free.fr>
Date: Sat, 14 Jan 2006 12:42:30 +0100
From: matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: greg@kroah.com
CC: linux-kernel@vger.kernel.org, usbatm@lists.infradead.org,
       linux-usb-devel@lists.sourceforge.net, ueagle <ueagleatm-dev@gna.org>
Subject: [PATCH 3/2] UEAGLE : cosmetic
Content-Type: multipart/mixed;
 boundary="------------080101090309000502050009"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080101090309000502050009
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

this patch correct a possible bug with cmv_name being static. If there 
is 2 modems and the driver is scheduled when filling cmv_name this could 
result with garbage in cmv_name. We allocate cmv_name on the stack but 
with a small size in order to avoid that.


Signed-off-by: Matthieu CASTET <castet.matthieu@free.fr>

--------------080101090309000502050009
Content-Type: text/plain;
 name="ueagle_cmv_name"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="ueagle_cmv_name"

SW5kZXg6IExpbnV4L2RyaXZlcnMvdXNiL2F0bS91ZWFnbGUtYXRtLmMKPT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PQotLS0gTGludXgub3JpZy9kcml2ZXJzL3VzYi9hdG0vdWVhZ2xlLWF0bS5jCTIwMDYtMDEt
MTQgMTI6Mzc6MDAuMDAwMDAwMDAwICswMTAwCisrKyBMaW51eC9kcml2ZXJzL3VzYi9hdG0v
dWVhZ2xlLWF0bS5jCTIwMDYtMDEtMTQgMTI6Mzc6MzkuMDAwMDAwMDAwICswMTAwCkBAIC0x
MDEyLDcgKzEwMTIsNyBAQAogCWludCByZXQsIHNpemU7CiAJdTggKmRhdGE7CiAJY2hhciAq
ZmlsZTsKLQlzdGF0aWMgY2hhciBjbXZfbmFtZVsyNTZdID0gRldfRElSOworCWNoYXIgY212
X25hbWVbRklSTVdBUkVfTkFNRV9NQVhdOyAvKiAzMCBieXRlcyBzdGFjayB2YXJpYWJsZSAq
LwogCiAJaWYgKGNtdl9maWxlW3NjLT5tb2RlbV9pbmRleF0gPT0gTlVMTCkgewogCQlpZiAo
VUVBX0NISVBfVkVSU0lPTihzYykgPT0gQURJOTMwKQo=
--------------080101090309000502050009--
