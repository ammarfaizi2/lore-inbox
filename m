Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276070AbRI1OaS>; Fri, 28 Sep 2001 10:30:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276072AbRI1OaI>; Fri, 28 Sep 2001 10:30:08 -0400
Received: from alcove.wittsend.com ([130.205.0.10]:32189 "EHLO
	alcove.wittsend.com") by vger.kernel.org with ESMTP
	id <S276070AbRI1O37>; Fri, 28 Sep 2001 10:29:59 -0400
Date: Fri, 28 Sep 2001 10:30:22 -0400
From: "Michael H. Warfield" <mhw@wittsend.com>
To: Bobby Hitt <bobhitt@bscnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2GB File limitation
Message-ID: <20010928103022.C28366@alcove.wittsend.com>
Mail-Followup-To: Bobby Hitt <bobhitt@bscnet.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <013801c147e5$3330bec0$092cdb3f@bobathome>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <013801c147e5$3330bec0$092cdb3f@bobathome>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2001 at 02:17:07AM -0400, Bobby Hitt wrote:
> Hello,

> Is someone working on a way to overcome the 2GB file limitation in Linux? I
> currently backup several servers using a dedicated hard drive for the
> backups. Recently I saw one backup die saying the the file size had been
> exceeded. I've never had good luck with tape backups, yes they backup, but
> whenever I really need a file, it can't be retrieved.

	The problem has been fixed in the file system, the kernel and
the supporting libraries for ages.  Applications may need to be updated
to take advantage of 64 bit file offsets and file operations, though.
You didn't say how you were backing up those other servers.  Is it a
particular backup program?  If so, that program may need to be rebuilt
or updated.  Are you backing up over NFS or some other file transport
where the Linux box is just acting as a file server or is the backup
program running on that Linux box?

	Oh...  And what version of Linux?  If it's old enough, I
suppose you might still have a problem there.  Recent (RedHat 7.x
and contemporaries) distributions shouldn't be a problem.

> TIA,

> Bobby

	Mike
-- 
 Michael H. Warfield    |  (770) 985-6132   |  mhw@WittsEnd.com
  (The Mad Wizard)      |  (678) 463-0932   |  http://www.wittsend.com/mhw/
  NIC whois:  MHW9      |  An optimist believes we live in the best of all
 PGP Key: 0xDF1DD471    |  possible worlds.  A pessimist is sure of it!

