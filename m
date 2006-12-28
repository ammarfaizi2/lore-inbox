Return-Path: <linux-kernel-owner+w=401wt.eu-S964919AbWL1Ej2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964919AbWL1Ej2 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 23:39:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964920AbWL1Ej2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 23:39:28 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:37984 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964919AbWL1Ej2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 23:39:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=ZH3Ylls24rwWWuBE2+VQjqTKTzwG4f+7/+onc/XsQc04jGzvMhDOXIZNDOUZDI7rt3DG/MT5XsbrAT0eVsiy2OG+LuqdaXk0kz7jwTISY76485e/9xsMEhJa03Uqu4LV4HIzITmhufk3fEGqgKaqHSJODTyWspYY7HK0BgMHAnM=
Message-ID: <8bd0f97a0612272039l15fb2484v8ebbc1065adab9e2@mail.gmail.com>
Date: Wed, 27 Dec 2006 23:39:26 -0500
From: "Mike Frysinger" <vapier.adi@gmail.com>
To: khali@linux-fr.org, "Andrew Morton" <akpm@osdl.org>
Subject: [patch] fix typo in i2c smbus documentation
Cc: i2c@lm-sensors.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_78199_32714685.1167280766240"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_78199_32714685.1167280766240
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

the i2c smbus documentation has a typo ... when it describes the
"SMBus Write Word Data" function, it says that it is meant to "read
from a device" when in reality it should obviously be writing to the
device

btw, the i2c/smbus docs in Documentation/i2c/ are superb, thanks all :)
-mike

------=_Part_78199_32714685.1167280766240
Content-Type: application/octet-stream; name=linux-i2c-smbus-doc-typo.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ew8osc2z
Content-Disposition: attachment; filename="linux-i2c-smbus-doc-typo.patch"

Rml4IHR5cG8gaW4gU01CdXMgV3JpdGUgV29yZCBEYXRhIGRlc2NyaXB0aW9uICh3cml0ZSBkYXRh
LCBkb250IHJlYWQgaXQpLgoKU2lnbmVkLW9mZi1ieTogTWlrZSBGcnlzaW5nZXIgPHZhcGllckBn
ZW50b28ub3JnPgoKZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vaTJjL3NtYnVzLXByb3RvY29s
IGIvRG9jdW1lbnRhdGlvbi9pMmMvc21idXMtcHJvdG9jb2wKaW5kZXggMDlmNWU1Yy4uM2JhZWRl
YyAxMDA2NDQKLS0tIGEvRG9jdW1lbnRhdGlvbi9pMmMvc21idXMtcHJvdG9jb2wKKysrIGIvRG9j
dW1lbnRhdGlvbi9pMmMvc21idXMtcHJvdG9jb2wKQEAgLTk3LDcgKzk3LDcgQEAgU01CdXMgV3Jp
dGUgV29yZCBEYXRhCiA9PT09PT09PT09PT09PT09PT09PT0KIAogVGhpcyBpcyB0aGUgb3Bwb3Np
dGUgb3BlcmF0aW9uIG9mIHRoZSBSZWFkIFdvcmQgRGF0YSBjb21tYW5kLiAxNiBiaXRzCi1vZiBk
YXRhIGlzIHJlYWQgZnJvbSBhIGRldmljZSwgZnJvbSBhIGRlc2lnbmF0ZWQgcmVnaXN0ZXIgdGhh
dCBpcyAKK29mIGRhdGEgaXMgd3JpdHRlbiB0byBhIGRldmljZSB0byB0aGUgZGVzaWduYXRlZCBy
ZWdpc3RlciB0aGF0IGlzIAogc3BlY2lmaWVkIHRocm91Z2ggdGhlIENvbW0gYnl0ZS4gCiAKIFMg
QWRkciBXciBbQV0gQ29tbSBbQV0gRGF0YUxvdyBbQV0gRGF0YUhpZ2ggW0FdIFAK
------=_Part_78199_32714685.1167280766240--
