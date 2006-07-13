Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030236AbWGMQpP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030236AbWGMQpP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 12:45:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030240AbWGMQpP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 12:45:15 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:52866 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030236AbWGMQpO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 12:45:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=HjFxY83flp5MojtkFcdl1Wr2rPqVJ9D9YmhsOGVgMuREatW6aMBoA7UnpQrPOZRCzLH7opD3Pru9fOjeO8WHmrkl8hUqtoFPSjnUYRtVsJ+K6GU4esZphvsKWmyY64YJ4hgjnRaQaZHCQPzKlXsE58P72dTlMZf4IihOtjFwemY=
Message-ID: <728201270607130945y30dbd388o76725b8a6fe28e56@mail.gmail.com>
Date: Thu, 13 Jul 2006 11:45:11 -0500
From: "Ram Gupta" <ram.gupta5@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: [PATCH]drivers: returning proper error from serial driver
Cc: "linux mailing-list" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_3937_7108193.1152809111575"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_3937_7108193.1152809111575
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This patch fixes the issue of returning 0 even in case of error from
uart_set_info function.
Now it returns the  error EBUSY  when it can not set new port. Please apply

Signed-off-by: Ram Gupta(r.gupta@astronautics.com)
-------------
Thanks
Ram Gupta

------=_Part_3937_7108193.1152809111575
Content-Type: application/octet-stream; name=patch.serial_core
Content-Transfer-Encoding: base64
X-Attachment-Id: f_eplcgdi4
Content-Disposition: attachment; filename="patch.serial_core"

LS0tIGxpbnV4LTIuNi4xNy9kcml2ZXJzL3NlcmlhbC9zZXJpYWxfY29yZS5jLm9yaWcJMjAwNi0w
Ny0xMyAxMToxNzo0OS4wMDAwMDAwMDAgLTA1MDAKKysrIGxpbnV4LTIuNi4xNy9kcml2ZXJzL3Nl
cmlhbC9zZXJpYWxfY29yZS5jCTIwMDYtMDctMTMgMTE6MjM6MDUuMDAwMDAwMDAwIC0wNTAwCkBA
IC03ODYsNiArNzg2LDcgQEAgc3RhdGljIGludCB1YXJ0X3NldF9pbmZvKHN0cnVjdCB1YXJ0X3N0
YQogCQkJICogV2UgZmFpbGVkIGFueXdheS4KIAkJCSAqLwogCQkJcmV0dmFsID0gLUVCVVNZOwor
CQkJZ290byBleGl0OyAgLy8gQWRkZWQgdG8gcmV0dXJuIHRoZSBjb3JyZWN0IGVycm9yIC1SYW0g
R3VwdGEKIAkJfQogCX0KIAo=
------=_Part_3937_7108193.1152809111575--
