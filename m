Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262044AbREPShj>; Wed, 16 May 2001 14:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262054AbREPSh2>; Wed, 16 May 2001 14:37:28 -0400
Received: from 216.41.5.host170 ([216.41.5.170]:63342 "EHLO
	habitrail.home.fools-errant.com") by vger.kernel.org with ESMTP
	id <S262053AbREPShY>; Wed, 16 May 2001 14:37:24 -0400
Message-Id: <200105161837.f4GIb7u06525@habitrail.home.fools-errant.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.3
To: Helge Hafting <helgehaf@idb.hist.no>
cc: Oystein Viggen <oysteivi@tihlde.org>, linux-kernel@vger.kernel.org
Subject: Re: LANANA: To Pending Device Number Registrants 
In-Reply-To: Your message of "Wed, 16 May 2001 15:28:03 +0200."
             <3B028063.67442F62@idb.hist.no> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 16 May 2001 14:37:07 -0400
From: Hacksaw <hacksaw@hacksaw.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>This is the problem with all sorts of ID-based naming.  In this case
>the kernel could simply change the conflicting names a bit,
>and leave the cleanup to the administrator.  (Who probably
>is around as he just inserted those disks....)

NO, NO, NO, NO, NO.

The kernel, when asked to report on the disks physically attached to the 
machine, should report the location and *volume* name.

It should never just mount things when there is a conflict. Make the user 
resolve the conflict immediately by being more specific.

Partition names are sacrosanct. They should always work within the relative 
filesystem.

If I have a disk with /, /usr and /var, I want mentions of ../var to work 
correctly in scripts in usr, assuming I have usr and var mounted into /.

