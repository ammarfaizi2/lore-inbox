Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261694AbUKPKrk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261694AbUKPKrk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 05:47:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261948AbUKPKrj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 05:47:39 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:49009 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261694AbUKPKrG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 05:47:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type;
        b=tfkrawLH3uoed/0Z6mwUbbVAhXU27x3X3lsbesrL/wHC6PQ4dU6sylvkX3qLQlYTyF6wJW2fPO99razEhU4UhEq8d5Z0r7v4IuyatF2oIAqKLbVX/FWL11PYIc4mxVkKs3/zP5X47jRAHY5melWtz+v0nh3tjSt6PRWTgrqIfB8=
Message-ID: <aec7e5c304111602474a3103e4@mail.gmail.com>
Date: Tue, 16 Nov 2004 11:47:05 +0100
From: Magnus Damm <magnus.damm@gmail.com>
Reply-To: Magnus Damm <magnus.damm@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] documentation - nohighio
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_205_4982442.1100602025806"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_205_4982442.1100602025806
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

The kernel parameter "nohighio" seems to be gone in the code, but the
parameter is still left in the documentation.

/ magnus

------=_Part_205_4982442.1100602025806
Content-Type: text/x-patch; name="linux-2.6.10-rc2-no_nohighio.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="linux-2.6.10-rc2-no_nohighio.patch"

--- linux-2.6.10-rc2/Documentation/kernel-parameters.txt=092004-11-14 18:35=
:07.000000000 +0100
+++ linux-2.6.10-rc2-no_nohighio/Documentation/kernel-parameters.txt=092004=
-11-16 11:37:58.201316728 +0100
@@ -785,8 +785,6 @@
=20
 =09nofxsr=09=09[BUGS=3DIA-32]
=20
-=09nohighio=09[BUGS=3DIA-32] Disable highmem block I/O.
-
 =09nohlt=09=09[BUGS=3DARM]
 =20
 =09no-hlt=09=09[BUGS=3DIA-32] Tells the kernel that the hlt

------=_Part_205_4982442.1100602025806--
