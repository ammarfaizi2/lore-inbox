Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315607AbSENK6o>; Tue, 14 May 2002 06:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315608AbSENK6n>; Tue, 14 May 2002 06:58:43 -0400
Received: from gateway.ukaea.org.uk ([194.128.63.73]:13096 "EHLO
	fuspcnjc.culham.ukaea.org.uk") by vger.kernel.org with ESMTP
	id <S315607AbSENK6m>; Tue, 14 May 2002 06:58:42 -0400
Message-ID: <3CE0EDF6.621AB9D0@ukaea.org.uk>
Date: Tue, 14 May 2002 11:59:02 +0100
From: Neil Conway <nconway.list@ukaea.org.uk>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-31 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: reality@delusion.de, linux-kernel@vger.kernel.org
Subject: Re: Ext3 errors with 2.4.18
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Your errors are just like the ones I experienced due to an IDE bug.

Are you: 
a) using a hard-disk on the same cable as a CD/DVD

b) seeing any "hdX: status error: status=0x58 {DriveReady SeekComplete
DataRequest}" errors in your log

c) seeing (b) in close proximity to ATAPI module init messages like:
"hdb: ATAPI 24X DVD-ROM drive, 128kB Cache, UDMA(33)"

?

If yes to all/most of the above, you may be suffering from the same
bug.  If not, your inodes in RAM are probably being trashed by a
different bug :-))

Neil
