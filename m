Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130315AbQKVSjf>; Wed, 22 Nov 2000 13:39:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129787AbQKVSjP>; Wed, 22 Nov 2000 13:39:15 -0500
Received: from smtp.alacritech.com ([209.10.208.82]:52997 "EHLO
        smtp.alacritech.com") by vger.kernel.org with ESMTP
        id <S129625AbQKVSiU>; Wed, 22 Nov 2000 13:38:20 -0500
Message-ID: <3A1C0D09.428F5398@alacritech.com>
Date: Wed, 22 Nov 2000 10:14:33 -0800
From: "Matt D. Robinson" <yakker@alacritech.com>
Organization: Alacritech, Inc.
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: 64738 <schwung@rumms.uni-mannheim.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: LKCD from SGI
In-Reply-To: <974906422.3a1be4369213b@rumms.uni-mannheim.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

64738 wrote:
> 
> Hi.
> 
> I tried to find some information on whether the Linux Kernel Crash Dumps
> patches are going into 2.4 (or 2.5). Has there been any decision?

LKCD won't go into 2.4 (or 2.5) until I finish writing the direct
disk open/write functions that avoid going through the standard
IDE and SCSI drivers.  I'm working on it.

As far as work for 2.4 goes, we've got a version on SourceForge that
works well (for i386 and 95% for ia64).

As soon as the drivers are done, we'll hopefully get acceptance.

--Matt

P.S.  Any way we can standardize 'make install' in the kernel?  It's
      disturbing to have different install mechanisms per platform ...
      I can make the changes for a few platforms.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
