Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262969AbVCJTfJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262969AbVCJTfJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 14:35:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263030AbVCJTdS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 14:33:18 -0500
Received: from rproxy.gmail.com ([64.233.170.207]:38053 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262757AbVCJTZn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 14:25:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type:content-transfer-encoding;
        b=oFZimCaGdFhnSlCv9jFq1gzPsxa75H8kV7r1kdjjinkTp42NEdYMsRqu67QYmU46VpMtAgRnRtpFoNQ59JrmNRxkR66yR71NBISUrwl9PCaAMOs7BeksG2PRcE9pROw4637e8Mb8j4O5g/Wew3rOOwkTWfwyy6LXZexsJOw0+rg=
Message-ID: <d3a6bba0050310112514a8e924@mail.gmail.com>
Date: Thu, 10 Mar 2005 11:25:34 -0800
From: Anil Kumar <anilsr@gmail.com>
Reply-To: Anil Kumar <anilsr@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: driver compile parse errors for RHEL4
Cc: anilsr@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am getting parse errors when I try to build aic7xxx( Adaptec SCSI
controller) driver for RHEL4.
I am using my own build enviroment (I mean Makefiles, scripts) to build this.

#gcc -v
Reading specs from
/usr/adaptec/build/gcc343-32bit/lib/gcc/i386-redhat-linux/3.4.3/specs
Configured with: ./configure --prefix=/usr/adaptec/build/gcc343-32bit
--enable-threads=posix --disable-checking --target=i386-redhat-linux
--host=i686-redhat-linux-gnu
--with-libs=/usr/adaptec/build/gcc343-32bit/lib
--with-headers=/usr/adaptec/build/gcc343-32bit/include
--enable-languages=c --disable-libunwind-exceptions --with-system-zlib
--enable-__cxa_atexit --enable-java-awt=gtk --enable-shared
--mandir=/usr/adaptec/build/gcc343-32bit/man
--infodir=/usr/adaptec/build/gcc343-32bit/info
Thread model: posix
gcc version 3.4.3

The sources for the driver can be found under
/usr/src/linux/driver/scsi/aic7xxx when you download 2.6.9 kernel from
www.kernel.org.

The errors are as follows:

drivers/scsi/aic7xxx/aic7xxx_reg_print.c:23: error: parse error before '(' token
drivers/scsi/aic7xxx/aic7xxx_reg_print.c:40: error: parse error before '(' token
drivers/scsi/aic7xxx/aic7xxx_reg_print.c:57: error: parse error before '(' token
drivers/scsi/aic7xxx/aic7xxx_reg_print.c:82: error: parse error before '(' token

Can you please let me know if my gcc is installed correctly, I mean if
I disable/enable any of the flags. If not I will look into my
Makefiles and scripts.

with regards,
   Anil
