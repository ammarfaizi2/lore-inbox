Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317215AbSIEHby>; Thu, 5 Sep 2002 03:31:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317232AbSIEHby>; Thu, 5 Sep 2002 03:31:54 -0400
Received: from d12lmsgate.de.ibm.com ([195.212.91.199]:27570 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id <S317215AbSIEHbx> convert rfc822-to-8bit; Thu, 5 Sep 2002 03:31:53 -0400
Importance: Normal
Sensitivity: 
Subject: Re: [PATCH} s390x sys32 duplicated code cleanup (was [PATCH RFC] s390x
 sys32...)
To: Tim Hockin <thockin@sun.com>
Cc: Tim Hockin <thockin@sun.com>, linux-390@vm.marist.edu,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OF75902446.F2BBB643-ONC1256C2B.00290ED8@de.ibm.com>
From: "Martin Schwidefsky" <schwidefsky@de.ibm.com>
Date: Thu, 5 Sep 2002 09:30:53 +0200
X-MIMETrack: Serialize by Router on D12ML016/12/M/IBM(Release 5.0.9a |January 7, 2002) at
 05/09/2002 09:36:19
MIME-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Tim,

>Uggh, DaveM pointed out a very good issue with this fix (similar for
>Sparc64) and core files.  Core files will now have truncated uid/gid
>values because fs/binfmt_elf calls NEW_TO_OLD_UID().  May be other
>places, too.
>
>I guess you should not apply this patch until I've had a better think
>about it.

Sad but true. And I don't see an easy way around it without changes
to fs/binfmt_elf.c.

blue skies,
   Martin

Linux/390 Design & Development, IBM Deutschland Entwicklung GmbH
Schönaicherstr. 220, D-71032 Böblingen, Telefon: 49 - (0)7031 - 16-2247
E-Mail: schwidefsky@de.ibm.com


