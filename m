Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274897AbRIVMYO>; Sat, 22 Sep 2001 08:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274896AbRIVMYC>; Sat, 22 Sep 2001 08:24:02 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:3084 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S274895AbRIVMXp>; Sat, 22 Sep 2001 08:23:45 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15276.33416.91166.412805@beta.reiserfs.com>
Date: Sat, 22 Sep 2001 16:22:32 +0400
To: "Tony Hoyle" <tmh@nothing-on.tv>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Reiserfs does not work from fstab in 2.4.9-ac12
In-Reply-To: <9og6rk$vd$1@sisko.my.home>
In-Reply-To: <9og6rk$vd$1@sisko.my.home>
X-Mailer: VM 6.89 under 21.4 (patch 3) "Academic Rigor" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tony Hoyle writes:
 > I just got caught by this on a box which had a reiserfs /usr partition...
 > 
 > # mount /disk2
 > reiserfs: kgetopt: there is not option

Yes, it's known bug (you are using Alan's kernel, right?). Yesterday
(2001.09.21) patch addressing this was posted on reiserfs list (archive
at http://marc.theaimsgroup.com/?l=reiserfs&r=1&w=2) and sent
to Alan.

 > <lots of mount failure stuff>
 > 
 > The fstab that generated this (which has worked for every other version,
 > so I believe it to be correct):
 > /dev/hdb1      /disk2          reiserfs        defaults        0       0
 > 
 > However
 > # mount -t reiserfs /dev/hdb1 /disk2
 > 
 > ..works correctly.
 > 
 > Tony
 > 
 > -- 
 > Microsoft - two out of three dead people who expressed a preference
 > said their coffins preferred it.
 > 
 > tmh@nothing-on.tv	http://www.nothing-on.tv
 > -

Nikita.
