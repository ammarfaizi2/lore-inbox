Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S130380AbRC1KCA>; Wed, 28 Mar 2001 05:02:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S131740AbRC1KBv>; Wed, 28 Mar 2001 05:01:51 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:53512 "HELO hermine.idb.hist.no") by vger.kernel.org with SMTP id <S130380AbRC1KBh>; Wed, 28 Mar 2001 05:01:37 -0500
Message-ID: <3AC1B644.D5DE1181@idb.hist.no>
Date: Wed, 28 Mar 2001 12:00:36 +0200
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: no, da, en
MIME-Version: 1.0
To: Shawn Starr <spstarr@sh0n.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Disturbing news..
References: <Pine.LNX.4.30.0103280115180.7637-100000@coredump.sh0n.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shawn Starr wrote:
> 
> http://news.cnet.com/news/0-1003-200-5329436.html?tag=lh
> 
> Isn't it time to change the ELF format to stop this crap?
> 
Nothing to worry about.
A sane distribution have all executables installed read-only
and owned by root or some non-user.  

Email appliacations and file browsers etc. are run as normal
users.  So, even if the user stupidly run this mysterious
program he got in the mail - what happens?

It search for all ELF executables in the system and find
it can open none!  They are not writeable, and the
user don't own them so the bad program cannot change
permissions in order to modify the executables either.

About the only "danger" here is messing with a developer's
program being developed, but he can recompile it
and loose the virus that way.  And a developer wouldn't
trust a program he got in the mail in the first place.
Those dumb enough don't have any writeable executables.

Helge Hafting
