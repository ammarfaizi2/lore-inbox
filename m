Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263374AbRFAFI5>; Fri, 1 Jun 2001 01:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263384AbRFAFIh>; Fri, 1 Jun 2001 01:08:37 -0400
Received: from [194.67.87.171] ([194.67.87.171]:31238 "EHLO
	altair.office.altlinux.ru") by vger.kernel.org with ESMTP
	id <S263374AbRFAFI0>; Fri, 1 Jun 2001 01:08:26 -0400
Date: Fri, 1 Jun 2001 09:08:46 +0400
From: Konstantin Volckov <goldhead@altlinux.ru>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Patch for Promise PDC20267 FastTrack100 Controller
Message-Id: <20010601090846.13490f6f.goldhead@altlinux.ru>
X-Mailer: Sylpheed version 0.4.66 (GTK+ 1.2.10; i586-alt-linux)
Organization: ALT Linux
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Fri__1_Jun_2001_09:08:46_+0400_0819c0e0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart_Fri__1_Jun_2001_09:08:46_+0400_0819c0e0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

I've found that 2.4.5-ac kernels can't detect hdd's connected to
FastTrack100 Promise controller, but Ultra100 works fine. Here is the
patch, that solve this problem.

Controllers tested - FastTrack100, Ultra100. Kernel - 2.4.5-ac4.

-- 
Good luck,
Konstantin

--Multipart_Fri__1_Jun_2001_09:08:46_+0400_0819c0e0
Content-Type: application/octet-stream;
 name="linux-2.4.4-ac10-promise.patch"
Content-Disposition: attachment;
 filename="linux-2.4.4-ac10-promise.patch"
Content-Transfer-Encoding: base64

LS0tIGxpbnV4L2RyaXZlcnMvaWRlL2lkZS1wY2kuY19vbGQJVGh1IE1heSAxNyAyMjoxNjoxNSAy
MDAxCisrKyBsaW51eC9kcml2ZXJzL2lkZS9pZGUtcGNpLmMJVGh1IE1heSAxNyAyMjoxMDo0MyAy
MDAxCkBAIC02NTUsNiArNjU1LDkgQEAKIAkJaWYgKChJREVfUENJX0RFVklEX0VRKGQtPmRldmlk
LCBERVZJRF9QREMyMDI2NSkpICYmIChzZWNvbmRwZGMrKz09MSkgJiYgKHBvcnQ9PTEpICApIAog
CQkJZ290byBjb250cm9sbGVyX29rOwogCQkJCisJCWlmIChJREVfUENJX0RFVklEX0VRKGQtPmRl
dmlkLCBERVZJRF9QREMyMDI2NykpIAorCQkJZ290byBjb250cm9sbGVyX29rOworCQkJCiAJCWlm
IChlLT5yZWcgJiYgKHBjaV9yZWFkX2NvbmZpZ19ieXRlKGRldiwgZS0+cmVnLCAmdG1wKSB8fCAo
dG1wICYgZS0+bWFzaykgIT0gZS0+dmFsKSkKIAkJCWNvbnRpbnVlOwkvKiBwb3J0IG5vdCBlbmFi
bGVkICovCiBjb250cm9sbGVyX29rOgkJCQo=

--Multipart_Fri__1_Jun_2001_09:08:46_+0400_0819c0e0--
