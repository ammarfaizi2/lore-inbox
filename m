Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318163AbSHIGNo>; Fri, 9 Aug 2002 02:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318164AbSHIGNn>; Fri, 9 Aug 2002 02:13:43 -0400
Received: from web12908.mail.yahoo.com ([216.136.174.75]:25355 "HELO
	web12908.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S318163AbSHIGNn>; Fri, 9 Aug 2002 02:13:43 -0400
Message-ID: <20020809061726.12333.qmail@web12908.mail.yahoo.com>
Date: Thu, 8 Aug 2002 23:17:26 -0700 (PDT)
From: Tom Sanders <developer_linux@yahoo.com>
Subject: /proce/scsi/scsi and /dev mapping ?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there a way to map entries in /proc/scsi/scsi with
their corresponding mapping with /dev/sda, /dev/sdb
etc ?

During system boot, entries in /proce/scsi/scsi and
/dev are initialized in serial order, and there is a
one to one mapping. However, this mapping is NOT
guaranteed if devices are selectively removed and
added using "scsi remove-single-device" and "scsi
add-single-device" commands.

Any idea of how to work around it ?

TIA.
Tom 

__________________________________________________
Do You Yahoo!?
HotJobs - Search Thousands of New Jobs
http://www.hotjobs.com
