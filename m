Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267862AbTBRQqs>; Tue, 18 Feb 2003 11:46:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267865AbTBRQqs>; Tue, 18 Feb 2003 11:46:48 -0500
Received: from [212.122.164.10] ([212.122.164.10]:12704 "EHLO
	pechkin.minfin.bg") by vger.kernel.org with ESMTP
	id <S267862AbTBRQqs>; Tue, 18 Feb 2003 11:46:48 -0500
From: "Kostadin Karaivanov" <larry@minfin.bg>
To: "'Christoph Hellwig'" <hch@infradead.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: XFS problem 2.5.6{0,1,2}
Date: Tue, 18 Feb 2003 18:55:51 +0200
Message-ID: <000001c2d76e$98c38500$04010101@laptop>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
Importance: Normal
In-Reply-To: <20030218152702.B16760@infradead.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




On Tue, Feb 18, 2003 at 03:28:32PM +0200, Kostadin Karaivanov wrote:
>> Oftenly I get errors something like ...
>> "In memory data corruption ..... shuting down filesystem ide(0,3)"
and
>> linux halts. Reboot fixes the things.
>> Sorry can't paste the proper error output.
>> It happens when I try to erase a lots of small files or on shutdown.
>> I can't reproduce this, but it happens for at least once a day.
>> My whole linux partition is on XFS.
>> As long as I can tell this is not present in 2.5.5{7,8,9}

> Do you use blocksize smaller than your pagesize?

No, nothing fancy, the partition is formated with default settings of
mkfs.xfs (as slackware did) bsize=4096 according to xfs_info.
BTW, the errors on reboot I get on my laptop right after (trying
to)shtutting down the PCMCIA card as result my /var/run is lost
Manual xfs_repair fixes that. 

