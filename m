Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271842AbTGRVCS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 17:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271890AbTGRVCS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 17:02:18 -0400
Received: from 015.atlasinternet.net ([212.9.93.15]:28358 "EHLO
	ponti.gallimedina.net") by vger.kernel.org with ESMTP
	id S271842AbTGRU6a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 16:58:30 -0400
From: Ricardo Galli <gallir@uib.es>
Organization: UIB
To: Andrew Morton <akpm@osdl.org>
Subject: Re: Linux 2.6.0-test1 Ext3 Ooops. Reboot needed.
Date: Fri, 18 Jul 2003 23:13:23 +0200
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org
References: <200307181228.40142.gallir@uib.es> <20030718140019.4f6667bd.akpm@osdl.org>
In-Reply-To: <20030718140019.4f6667bd.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307182313.23288.gallir@uib.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 18 July 2003 23:00, Andrew Morton shaped the electrons to shout:
> Ricardo Galli <gallir@uib.es> wrote:
> >  Unable to handle kernel paging request at virtual address e9000018
> > EIP is at find_inode_fast+0x20/0x70
> > Call Trace:
> >  [<c0168e42>] iget_locked+0x52/0xc0
> >  [<c018a54b>] ext3_lookup+0x6b/0xd0
> >  [<c015cd92>] real_lookup+0xd2/0x100
>
> What is "famd"?  File access monitor daemon?  From where did you obtain it?

"File alteration monitor", from Debian. It uses portmapperand is recommended 
to improve kde performance.

$ apt-cache show fam
Package: fam
Priority: extra
Section: admin
Installed-Size: 232
Maintainer: Joerg Wendland <joergland@debian.org>
...
Description: File Alteration Monitor
 FAM monitors files and directories, notifying interested applications
 of changes.
 .
 This package provides a server that can monitor a given list of files
 and notify applications through a socket. If the kernel supports dnotify
 (kernels >= 2.4.x) FAM is notified directly by the kernel. Otherwise it has
 to poll the files' status. FAM can also provide a RPC service for monitoring
 remote files (such as on a mounted NFS filesystem).

Nevertheless I saw the same message the morning after updatedb run.

Regards,

-- 
  ricardo galli       GPG id C8114D34
  http://mnm.uib.es/~gallir/

