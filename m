Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267500AbRGMQ0W>; Fri, 13 Jul 2001 12:26:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267501AbRGMQ0O>; Fri, 13 Jul 2001 12:26:14 -0400
Received: from mehl.gfz-potsdam.de ([139.17.1.100]:6048 "EHLO
	mehl.gfz-potsdam.de") by vger.kernel.org with ESMTP
	id <S267500AbRGMQ0B> convert rfc822-to-8bit; Fri, 13 Jul 2001 12:26:01 -0400
Date: Fri, 13 Jul 2001 18:26:01 +0200
From: Steffen Grunewald <steffen@gfz-potsdam.de>
To: linux-kernel@vger.kernel.org
Subject: Re: reiserfs error message
Message-ID: <20010713182600.B29470@dss19>
In-Reply-To: <20010712133544.R10669@dss19> <630460000.995033868@tiny>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <630460000.995033868@tiny>; from mason@suse.com on Fri, Jul 13, 2001 at 10:17:49AM -0400
X-Disclaimer: I don't speak for no one else. And vice versa
X-Operating-System: SunOS
Content-Transfer-Encoding: 8BIT
X-MIME-Autoconverted: from 8bit to quoted-printable by dss19.gfz-potsdam.de id SAA29700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2001-07-13 (10:17), Chris Mason wrote:
> 
> 
> On Thursday, July 12, 2001 01:35:44 PM +0200 Steffen Grunewald
> <steffen@gfz-potsdam.de> wrote:
> 
> > Should I worry about
> > 
> > kernel: vs-13048: reiserfs_iget: key in inode [62743 393750 0 0] and key
> > 	in entry [62444 393750 0 0] do not match
> > 
> > ? This is SuSE 7.1 kernel 2.2.18, with automatic FTP updates.
> > 
> 
> This is due to two files sharing the same inode number, which isn't supposed
> to happen.  You can find the two files by doing a find -inum 393750 on the
> filesystem.  You probably want to grab the latest reiserfsck from
> ftp.namesys.com/pub/reiserfsprogs/pre and check the entire FS.

Unfortunately I now have to guess which FS is affected.

I'll look for an upgrade from SuSE.

> The only known way to trigger this problems involves running an older version
> of reiserfsck --rebuild-tree.  Have you done that?

No. But perhaps the system did it when I changed from 7.0 to 7.1?

Steffen
-- 
 Steffen Grunewald | GFZ | PB 2.2 | Telegrafenberg E3 | D-14473 Potsdam
 » email: steffen(at)gfz-potsdam.de | fax/fon: +49-331-288-1266/-1245 «
       Success is a journey, not a destination. So stop running.
                                             --- www.despair.com
