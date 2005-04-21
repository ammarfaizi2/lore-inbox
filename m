Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261461AbVDUIvW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261461AbVDUIvW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 04:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261460AbVDUIvN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 04:51:13 -0400
Received: from mail.portrix.net ([212.202.157.208]:45519 "EHLO
	zoidberg.portrix.net") by vger.kernel.org with ESMTP
	id S261461AbVDUItd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 04:49:33 -0400
Message-ID: <42676919.6070306@ppp0.net>
Date: Thu, 21 Apr 2005 10:49:29 +0200
From: Jan Dittmer <jdittmer@ppp0.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050116 Thunderbird/1.0 Mnenhy/0.6.0.104
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: aherrman@de.ibm.com
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.12-rc3
References: <Pine.LNX.4.58.0504201728110.2344@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504201728110.2344@ppc970.osdl.org>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> aherrman@de.ibm.com:
>     [PATCH] zfcp: convert to compat_ioctl

This does not seem to compile anymore with defconfig:

  CC      drivers/s390/scsi/zfcp_aux.o
/usr/src/ctest/rc/kernel/drivers/s390/scsi/zfcp_aux.c:63: warning: initialization from incompatible pointer type
/usr/src/ctest/rc/kernel/drivers/s390/scsi/zfcp_aux.c:366: error: conflicting types for `zfcp_cfdc_dev_ioctl'
/usr/src/ctest/rc/kernel/drivers/s390/scsi/zfcp_aux.c:55: error: previous declaration of `zfcp_cfdc_dev_ioctl'
make[3]: *** [drivers/s390/scsi/zfcp_aux.o] Error 1
make[2]: *** [drivers/s390/scsi] Error 2
make[1]: *** [drivers/s390] Error 2
make: *** [_all] Error 2

Jan
