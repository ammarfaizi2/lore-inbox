Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318706AbSIFPRi>; Fri, 6 Sep 2002 11:17:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318711AbSIFPRi>; Fri, 6 Sep 2002 11:17:38 -0400
Received: from avscan1.sentex.ca ([199.212.134.11]:9734 "EHLO
	avscan1.sentex.ca") by vger.kernel.org with ESMTP
	id <S318706AbSIFPRi>; Fri, 6 Sep 2002 11:17:38 -0400
Message-ID: <027901c255b8$d3029360$294b82ce@connecttech.com>
From: "Stuart MacDonald" <stuartm@connecttech.com>
To: <linux-kernel@vger.kernel.org>
Subject: Temporary menuconfig file not removed by make mrproper
Date: Fri, 6 Sep 2002 11:19:42 -0400
Organization: Connect Tech Inc.
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux/scripts/lxdialog/lxtemp.c was left behind after hitting <ctrl-c>
during a make menuconfig. clean, distclean and mrproper all failed to
remove it.

Not sure how this could be handled for the general case; is there a
standard "this is a temporary file" tag that could be used so that
clean/mrproper would catch arbitrary temporary files? ie lxtemp~~.c or
similar.

..Stu


