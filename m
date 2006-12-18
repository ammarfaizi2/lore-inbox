Return-Path: <linux-kernel-owner+w=401wt.eu-S1753427AbWLRHRy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753427AbWLRHRy (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 02:17:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753428AbWLRHRy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 02:17:54 -0500
Received: from mx1.redhat.com ([66.187.233.31]:49936 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753427AbWLRHRx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 02:17:53 -0500
Date: Mon, 18 Dec 2006 08:17:37 +0100
From: Karel Zak <kzak@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Henne Vogelsang <hvogel@suse.de>, Olaf Hering <olh@suse.de>,
       "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: util-linux: orphan
Message-ID: <20061218071737.GA5217@petra.dvoda.cz>
References: <20061109224157.GH4324@petra.dvoda.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061109224157.GH4324@petra.dvoda.cz>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Hello,

 after few weeks I'm pleased to announce a new "util-linux-ng" project. This
 project is a fork of the original util-linux (2.13-pre7). 

 The goal of the project is to move util-linux code back to useful state, sync
 with actual distributions and kernel and make development more transparent end
 open.

 The short term goals (for 2.13 release):

	- remove all NFS code from util-linux-ng 
          (/sbin/mount.nfs from nfs-utils is replacement)
	- remove FS/device detection code
          (libblkid from e2fsprogs or libvolumeid is replacement)
	- move as much as possible patches from distributions to upstream

 Mailing list:
   http://vger.kernel.org/vger-lists.html#util-linux-ng

 FTP:
   ftp://ftp.kernel.org/pub/scm/utils/util-linux-ng/

 GIT:
   git clone git://git.kernel.org/pub/scm/utils/util-linux-ng/util-linux-ng.git util-linux-ng

   [Note, GIT repo contains previous 47 versions of util-linux.]

        
 The mailing list or my private e-mail are open for your patches, ideas and
 suggestion. The mailing list is also place where you can help us review
 patches.

 Thanks mostly to Ian Kent, P.H. Anvin. Well, and thanks to Adrian
 Bunk for his previous work on this package.

    Karel


On Thu, Nov 09, 2006 at 11:41:57PM +0100, Karel Zak wrote:
> 
>  It really seems that util-linux project is in a bad condition:
> 
>   * the latest *major* stable release: 05-Mar-2004 (util-linux-2.12a)
>   * the latest *minor* stable release: 23-Sep-2005 (util-linux-2.12r)
>   * the latest unstable release:       05-Mar-2006 (util-linux-2.13-pre7)
>   * missing source code repository
>   * missing web page
>   * maintainer (Adrian Bunk) completely ignores mails about this package
>   * source code doesn't follow linux kernel, because there isn't any
>     development
>   * contributors are sending their patches to distributions rather than 
>     to upstream
>   * Red Hat (FC6) has 75 patches for this package (!)
>   * Novell has (OpenSuse 10.2) 53 patches for this package (!)
>  
> 
>  I'm Red Hat util-linux maintainer (for 2 years) and I'd like to
>  change this bad situation. Yes.. I'd like to help. I've already
>  talked with Peter Anvin about git repository for this project at
>  kernel.org. Also I have feedback from Novell that they agree that the
>  current situation is bad and they want to contribute future
>  development.
> 
>  I've originally thought about util-linux upstream fork, but as
>  usually an fork is bad step. So.. I'd like to start some discussion
>  before this step. Maybe Adrian will be realistic and he will leave
>  the project and invest all his time to kernel only.

-- 
 Karel Zak  <kzak@redhat.com>
