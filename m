Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131980AbRBKHbb>; Sun, 11 Feb 2001 02:31:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131981AbRBKHbL>; Sun, 11 Feb 2001 02:31:11 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:45840 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S131980AbRBKHbI>; Sun, 11 Feb 2001 02:31:08 -0500
Message-ID: <3A86381B.ED93B55@namesys.com>
Date: Sun, 11 Feb 2001 09:58:35 +0300
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.2.14 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
CC: Daniel Stone <daniel@kabuki.eyep.net>, Chris Mason <mason@suse.com>,
        David Rees <dbr@spoke.nols.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "reiserfs-list@namesys.com" <reiserfs-list@namesys.com>
Subject: Re: [reiserfs-list] Re: Apparent instability of reiserfs on 2.4.1
In-Reply-To: <479040000.981564496@tiny> <E14QkfM-0004EL-00@piro.kabuki.eyep.net> <20010211020200.A9570@metastasis.f00f.org>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:
> 
> On Thu, Feb 08, 2001 at 05:34:44PM +1100, Daniel Stone wrote:
> 
>     I run Reiser on all but /boot, and it seems to enjoy corrupting my
>     mbox'es randomly.
> 
> what kind of corruption are you seeing?
> 
>     This also occurs in some log files, but I put it down to syslogd
>     crashing or something.
> 
> syslogd crashing shouldn't corrupt files...
> 
>   --cw

There is a known bug in which nulls get added to log files.  We are having
trouble reproducing it on our machines.

There is an elevator bug in 2.4 which just got found/fixed.  We don't know what
part of our bug reports are due to it.

Hans
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
