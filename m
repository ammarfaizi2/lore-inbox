Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261451AbUIIMKW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbUIIMKW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 08:10:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261234AbUIIMKW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 08:10:22 -0400
Received: from p5089E36A.dip.t-dialin.net ([80.137.227.106]:3588 "EHLO
	timbaland.dnsalias.org") by vger.kernel.org with ESMTP
	id S261474AbUIIMKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 08:10:04 -0400
From: Borislav Petkov <petkov@uni-muenster.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH][linux-2.6.9-rc1-mm4-funny characters in init/Kconfig:313
Date: Thu, 9 Sep 2004 14:10:01 +0200
User-Agent: KMail/1.7
Cc: akpm@osdl.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409091410.01568.petkov@uni-muenster.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 
probably these shouldn't be there:

--- init/Kconfig.orig   2004-09-09 13:59:16.000000000 +0200
+++ init/Kconfig        2004-09-09 13:59:30.000000000 +0200
@@ -313,8 +313,8 @@ config LOCALVERSION
        help
          Append an extra string to the end of your kernel version.
          This will show up when you type uname, for example.
-         The string you set here will be appended after the contents of=20
-         any files with a filename matching localversion* in your=20
+         The string you set here will be appended after the contents of
+         any files with a filename matching localversion* in your
          object and source tree, in that order.  Your total string can
          be a maximum of 64 characters.

Regards,
Boris.
