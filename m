Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310924AbSCROG7>; Mon, 18 Mar 2002 09:06:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310920AbSCROGt>; Mon, 18 Mar 2002 09:06:49 -0500
Received: from d12lmsgate.de.ibm.com ([195.212.91.199]:48875 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id <S310917AbSCROGg> convert rfc822-to-8bit; Mon, 18 Mar 2002 09:06:36 -0500
Importance: Normal
Sensitivity: 
Subject: Re: 2.4.19-pre3 s390 patch for hwc_con.c
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.4a  July 24, 2000
Message-ID: <OF5991CEBE.CF23F14A-ONC1256B80.0042A9FE@de.ibm.com>
From: "Martin Schwidefsky" <schwidefsky@de.ibm.com>
Date: Mon, 18 Mar 2002 15:03:49 +0100
X-MIMETrack: Serialize by Router on D12ML016/12/M/IBM(Release 5.0.9a |January 7, 2002) at
 18/03/2002 15:06:27
MIME-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>This patch makes hwc_con more resilient to structure layout changes.
>It's not _strictly_ necessary, but I would like it to be in.

Yep makes sense as well. I actually made the same fix for the kernel
2.5.6. I have it basically going but SMP is still a bit broken. It
hangs on boot with 5 cpus. Seems like the startup of the migration
threads doesn't complete because load_balance isn't balancing...

blue skies,
   Martin

Linux/390 Design & Development, IBM Deutschland Entwicklung GmbH
Schönaicherstr. 220, D-71032 Böblingen, Telefon: 49 - (0)7031 - 16-2247
E-Mail: schwidefsky@de.ibm.com


