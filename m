Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261939AbREPN2w>; Wed, 16 May 2001 09:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261941AbREPN2m>; Wed, 16 May 2001 09:28:42 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:14094 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S261939AbREPN2d>; Wed, 16 May 2001 09:28:33 -0400
Message-ID: <3B028063.67442F62@idb.hist.no>
Date: Wed, 16 May 2001 15:28:03 +0200
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5-pre2 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: Oystein Viggen <oysteivi@tihlde.org>, linux-kernel@vger.kernel.org
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <E504453C04C1D311988D00508B2C5C2DF2F9E1@mail11.gruppocredit.it>
		<3B0261EC.23BE5EF0@idb.hist.no> <031ypp1oi2.fsf@colargol.tihlde.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oystein Viggen wrote:
> 
> Quoth Helge Hafting:
> 
> > This could be extended to non-raid use - i.e. use the "raid autodetect"
> > partition type for non-raid as well.  The autodetect routine could
> > then create /dev/partitions/home, /dev/partitions/usr or
> > /dev/partitions/name_of_my_choice
> > for autodetect partitions not participating in a RAID.
> 
> What happens if I insert a hard drive from another computer which also
> has partitions named "home", "usr", and soforth?

This is the problem with all sorts of ID-based naming.  In this case
the kernel could simply change the conflicting names a bit,
and leave the cleanup to the administrator.  (Who probably
is around as he just inserted those disks....)

The current scheme have problems if you move a disk
from one controller to another, or in some cases
if you merely add a new one.  So the question becomes - 
what is most likely to go wrong?  And you can be
smart and name your partitions /usr21042001, /home03042001
and so on in order to minimize the risk of conflicts.

Helge Hafting
