Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262874AbUDZQGG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262874AbUDZQGG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 12:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263019AbUDZQD6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 12:03:58 -0400
Received: from yellow.csi.cam.ac.uk ([131.111.8.67]:30128 "EHLO
	yellow.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S263032AbUDZQDP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 12:03:15 -0400
Subject: Re: [PATCH-2.6.6-rc2-bk] NTFS 2.1.7 release: Implement NFS
	exporting
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <408D31DC.6040708@tmr.com>
References: <Pine.SOL.4.58.0404232055210.15465@orange.csi.cam.ac.uk>
	 <408D31DC.6040708@tmr.com>
Content-Type: text/plain
Organization: University of Cambridge Computing Service
Message-Id: <1082995293.5754.8.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 26 Apr 2004 17:01:33 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-04-26 at 16:59, Bill Davidsen wrote:
> Anton Altaparmakov wrote:
> > Linus, please do a
> > 
> > 	bk pull http://linux-ntfs.bkbits.net/ntfs-2.6
> > 
> > Thanks!  This update implements NFS exporting of mounted NTFS volumes
> > which people have been requesting for a while.  Also, there are some minor
> > updates and white space cleanups.  This has been tested including forcing
> > a server reboot while clients have open files on an NTFS volume NFS
> > exported by the server.
> 
> Sounds like tha answer to the maiden's prayer. And if it will allow both 
>   NFS and SMB access to the same data, I know some people who will find 
> it most useful.

It certainly should allow both NFS and SMB access to the same data.  At
least I don't see any reason why it shouldn't work...

But keep in mind that whilst the ntfs driver can read everything (except
encrypted files) at present it can only overwrite existing files without
changes in file size...

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ &
http://www-stu.christs.cam.ac.uk/~aia21/


