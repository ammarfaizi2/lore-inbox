Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266490AbRGQNlZ>; Tue, 17 Jul 2001 09:41:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266505AbRGQNlP>; Tue, 17 Jul 2001 09:41:15 -0400
Received: from tower.t16.ds.pwr.wroc.pl ([156.17.232.1]:44734 "HELO
	tower.t16.ds.pwr.wroc.pl") by vger.kernel.org with SMTP
	id <S266490AbRGQNlJ>; Tue, 17 Jul 2001 09:41:09 -0400
Date: Tue, 17 Jul 2001 15:40:51 +0200 (CEST)
From: Przemyslaw Wegrzyn <czajnik@tower.t16.ds.pwr.wroc.pl>
To: linux-kernel@vger.kernel.org
Subject: Misleading Documentation/proc.txt ?
Message-ID: <Pine.LNX.4.21.0107171525050.815-100000@tower.t16.ds.pwr.wroc.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello!

I'd like to know what is the actual meaning of the second number in
/proc/sys/fs/file-nr ?
In Documentation/filesystems/proc.txt I can see:

"The three  values  in file-nr denote the number of allocated file
handles, the number of used file handles, and the maximum number of file
handles."

But I can see that the second number actually is the number of _free_
handles from the allocated handles pool !

Is proc.txt not updated or what ? The same with both 2.2.19 and 2.4.x

-=Czaj-nick=-



