Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751055AbWINTN4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751055AbWINTN4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 15:13:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751056AbWINTN4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 15:13:56 -0400
Received: from nz-out-0102.google.com ([64.233.162.205]:24874 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751054AbWINTNz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 15:13:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=SzBmyDQpLEerVyLa6kLHiuL8th8ZTazSuMhEjz2R5FE9eOtkviOxS+kr2nNenN6NW8qRxt9v1AS9PJlyG+lXrDpDwpFVni70Qn6vTcV1xzUebK0qZ0gBmb2lxLbnngfvOof9bh3D1HTn9bg8632uUDgSAU7d4+gkYtQb9fYmTds=
Message-ID: <4509AA10.4050907@gmail.com>
Date: Thu, 14 Sep 2006 13:14:24 -0600
From: Jim Cromie <jim.cromie@gmail.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: [RFC patch] MAINTAINERS:  encourage testers to volunteer
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add a new entry-type into MAINTAINERS whereby folks with hardware can 
volunteer to
test patches to the driver.  It should encourage folks to put themselves 
"on the hook"
in trade for a little bit of notoriety.

Hopefully this will help improve:
- support for rare hardware
- QA on that hardware
- connections between hackers & testers
- would-be hackers can find new things to do, esp in less visited parts 
of the dist.

Additions should be approved by maintainers etc, but thats no different 
than is currently done.


--- doc-touches/MAINTAINERS~	2006-09-14 11:50:03.000000000 -0600
+++ doc-touches/MAINTAINERS	2006-09-14 12:19:13.000000000 -0600
@@ -80,6 +80,12 @@
 			it has been replaced by a better system and you
 			should be using that.
 
+V: Validation/Test contact and hardware they can test.
+
+	Identifies folks who are willing to test driver patches, etc.
+	Also can identify lack of hardware for otherwize maintained drivers
+	by using 'none'
+
 3C359 NETWORK DRIVER
 P:	Mike Phillips
 M:	mikep@linuxtr.net


