Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270203AbTHBTA5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 15:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270237AbTHBTA5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 15:00:57 -0400
Received: from smtp.terra.es ([213.4.129.129]:31012 "EHLO tsmtp9.mail.isp")
	by vger.kernel.org with ESMTP id S270203AbTHBTAz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 15:00:55 -0400
Date: Sat, 2 Aug 2003 21:00:55 +0200
From: Diego Calleja =?ISO-8859-15?Q?Garc=EDa?= <diegocg@teleline.es>
To: herbert@13thfloor.at
Cc: seanlkml@rogers.com, linux-kernel@vger.kernel.org
Subject: Re: .config in bzImage ?
Message-Id: <20030802210055.556cf98e.diegocg@teleline.es>
In-Reply-To: <20030802184932.GA12057@www.13thfloor.at>
References: <093901c35924$f3040ed0$7f0a0a0a@lappy7>
	<20030802184932.GA12057@www.13thfloor.at>
X-Mailer: Sylpheed version 0.9.3 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Sat, 2 Aug 2003 20:49:32 +0200 Herbert Pötzl <herbert@13thfloor.at> escribió:

> hmm, since ages I use for 2.4.x a small patch, which
> includes the .config in the kernel image (gzipped or 
> bzip2ed). this information can be retrieved from the
> procfs by zcat /proc/config.gz or bzcat /proc/config.bz2
> respectively ...


There's something in -ac tree:

  x CONFIG_IKCONFIG:                                                        x  
  x                                                                         x  
  x This option enables the complete Linux kernel ".config" file            x  
  x contents, information on compiler used to build the kernel,             x  
  x kernel running when this kernel was built and kernel version            x  
  x from Makefile to be saved in kernel. It provides documentation          x  
  x of which kernel options are used in a running kernel or in an           x  
  x on-disk kernel.  This information can be extracted from the kernel      x  
  x image file with the script scripts/extract-ikconfig and used as         x  
  x input to rebuild the current kernel or to build another kernel.         x  
  x It can also be extracted from a running kernel by reading               x  
  x /proc/ikconfig/config and /proc/ikconfig/built_with, if enabled.        x  
  x /proc/ikconfig/config will list the configuration that was used         x  
  x to build the kernel and /proc/ikconfig/built_with will list             x  
  x information on the compiler and host machine that was used to           x  
  x build the kernel.                                                       x  
