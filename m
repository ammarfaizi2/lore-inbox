Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964869AbVI0JDq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964869AbVI0JDq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 05:03:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964870AbVI0JDq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 05:03:46 -0400
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:54949 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S964869AbVI0JDq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 05:03:46 -0400
From: Grant Coady <grant_lkml@dodo.com.au>
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Repeatable crash under 2.6.13.2 + NFS
Date: Tue, 27 Sep 2005 19:03:33 +1000
Organization: http://bugsplatter.mine.nu/
Message-ID: <u62ij19vjosurf6h3dovph0gcgmp3tdpth@4ax.com>
References: <Pine.LNX.4.63.0509270429360.1539@p34>
In-Reply-To: <Pine.LNX.4.63.0509270429360.1539@p34>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Sep 2005 04:37:01 -0400 (EDT), Justin Piszcz <jpiszcz@lucidpixels.com> wrote:

>Simply copy some files *over NFS* from box1 to box2.
Which NFS?  I've not had problems here with v3 + TCP, and each box 
here uses NFS, I'd notice.  Though I'm not using ACLs or any fancies.

>Or tar them, I did both.
>The remote machine locks and freezes, no console output.
>Copied 206MB before the MB/s went to 0 and crashed the remote box.

I'm unpacking source tarballs and patching from NFS mounted file 
mirror / server.  I'd surely notice if NFS stopped working here.

>Nasty bug.  SCP works fine.
>I've reported this before w/ .config etc but nobody responded.

NFS kernel options, exports, fstab mount options, and a test case 
please?

Cheers,
Grant.

