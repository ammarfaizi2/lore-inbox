Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277343AbRJEKmX>; Fri, 5 Oct 2001 06:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277344AbRJEKmH>; Fri, 5 Oct 2001 06:42:07 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:28936 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S277343AbRJEKlx>; Fri, 5 Oct 2001 06:41:53 -0400
Message-ID: <3BBD8E82.592130A7@namesys.com>
Date: Fri, 05 Oct 2001 14:42:10 +0400
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: "Stephen C. Tweedie" <sct@redhat.com>
CC: Bernd Eckenfels <ecki@lina.inka.de>, linux-kernel@vger.kernel.org
Subject: Re: [POT] Which journalised filesystem ?  (fwd)
In-Reply-To: <706340000.1002116485@gullevek.piwi.intern> <E15oqKN-00058k-00@calista.inka.de> <20011005113146.B3587@redhat.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Stephen C. Tweedie" wrote:
> 
> Hi,
> 
> On Wed, Oct 03, 2001 at 08:01:03PM +0200, Bernd Eckenfels wrote:
> >
> > Do you had NFS Problems or do you had filesystem problems?
> >
> > Because NFS interaction with Journaled Filesystems is/was an issue with
> > those recent kernels, as far as i understand.
> 
> Should be fine with ext3 and XFS.  It's not a journaling problem as
> much as NFS assuming a particular property of the filesystem.
> 
> Resierfs had a particular difficulty with NFS, mainly because the NFS
> spec assumes that every file can be looked up by a 64-bit cookie which
> doesn't change over reboots, and that's a hard invariant to deal with
> when you've only got 32-bit inode numbers in the kernel and when your
> filesystem is tree-structured so that the file metadata on disk can
> move about.  The VFS has been extended a bit in more recent kernels to
> allow Reiserfs to give NFS the hints it needs to get the file handles
> right.
> 
> Cheers,
>  Stephen
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
Err, I meant it is stable from all reports for recent kernels:-/.... excuse me.

Hans
