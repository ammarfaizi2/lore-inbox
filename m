Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129767AbRBBSHO>; Fri, 2 Feb 2001 13:07:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129771AbRBBSHF>; Fri, 2 Feb 2001 13:07:05 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:3853 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S129767AbRBBSHA>; Fri, 2 Feb 2001 13:07:00 -0500
Message-ID: <3A7AEFBF.2FBA5822@namesys.com>
Date: Fri, 02 Feb 2001 20:34:55 +0300
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.2.14 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: Chris Mason <mason@suse.com>
CC: Alan Cox <alan@redhat.com>, Jan Kasprzak <kas@informatics.muni.cz>,
        linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: ReiserFS Oops (2.4.1, deterministic, symlink
In-Reply-To: <595250000.981126989@tiny>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Mason wrote:
 
> Hans, decisions about proper compilers should not be made in each
> individual part of the kernel.  If unpatched gcc 2.96 is getting reiserfs

broke is broke.  If you use reiserfs, DO NOT use 2.96.  Period.  Nobody gains
by letting a single user make this mistake.  

> wrong, it is compiling other parts of the kernel wrong as well.  l-k has
> discussed this at length already ;-)

So, did Linus say no?  If not, let's ask him with a patch.  Quite simply,
neither we nor the users should be burdened with this, and the patch removes
the burden.

Hans
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
