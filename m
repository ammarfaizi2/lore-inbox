Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314571AbSEYNsK>; Sat, 25 May 2002 09:48:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314596AbSEYNsJ>; Sat, 25 May 2002 09:48:09 -0400
Received: from zeus.kernel.org ([204.152.189.113]:35483 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S314571AbSEYNsI>;
	Sat, 25 May 2002 09:48:08 -0400
To: Jeremy White <jwhite@codeweavers.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: isofs unhide option:  troubles with Wine
In-Reply-To: <1022301029.2443.28.camel@jwhiteh>
From: Olaf Dietsche <olaf.dietsche--list.linux-kernel@exmail.de>
Date: Sat, 25 May 2002 15:46:38 +0200
Message-ID: <87vg9c49xd.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Common Lisp,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeremy,

Jeremy White <jwhite@codeweavers.com> writes:

> Unfortunately, I don't have a strong feeling for what the
> 'right' solution is.  I see several options:
>
>     1.  Invert the logic of the option, make it 'hide' instead
>         of unhide, and so unhide is the default.

how about:

/dev/hdb /cdrom iso9660 defaults,ro,unhide,user 0 2

in your /etc/fstab. This would allow users to mount and unmount CDs.
It also changes the default to unhide.

Regards, Olaf.
