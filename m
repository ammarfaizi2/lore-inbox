Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265378AbUAPMIv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 07:08:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265379AbUAPMIu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 07:08:50 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:56450 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S265378AbUAPMIr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 07:08:47 -0500
Subject: Re: Patchlet for arch help in 2.6.1 s390
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.12   February 13, 2003
Message-ID: <OF01176535.B3C8A086-ONC1256E1D.004291A3-C1256E1D.0042B4CF@de.ibm.com>
From: "Martin Schwidefsky" <schwidefsky@de.ibm.com>
Date: Fri, 16 Jan 2004 13:08:36 +0100
X-MIMETrack: Serialize by Router on D12ML016/12/M/IBM(Release 5.0.9a |January 7, 2002) at
 16/01/2004 13:08:38
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Pete,

> --- linux-2.6.1-mm3/arch/s390/Makefile         2004-01-09
01:59:10.000000000 -0500
> +++ linux-2.6.1-mm3-s390/arch/s390/Makefile          2004-01-15
22:00:50.000000000 -0500
> @@ -70,3 +70,8 @@
>            $(call filechk,gen-asm-offsets)
>
>  CLEAN_FILES += include/asm-$(ARCH)/offsets.h
> +
> +# Don't use tabs in echo arguments.
> +define archhelp
> +  echo  '* image           - Kernel image for IPL ($(boot)/image)'
> +endef

this makes sense. I added this to out repository.

blue skies,
   Martin


