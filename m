Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267863AbUJNVlg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267863AbUJNVlg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 17:41:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267770AbUJNVjA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 17:39:00 -0400
Received: from fw.osdl.org ([65.172.181.6]:1441 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267367AbUJNVhM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 17:37:12 -0400
Date: Thu, 14 Oct 2004 14:41:07 -0700
From: Andrew Morton <akpm@osdl.org>
To: Haroldo Gamal <haroldo.gamal@silexonline.org>
Cc: samba@samba.org, linux-fsdevel@vger.kernel.org, urban@teststation.com,
       rddunlap@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] smbfs: smbfs do not honor uid, gid, file_mode and
 dir_mode supplied by user mount
Message-Id: <20041014144107.5cf63998.akpm@osdl.org>
In-Reply-To: <416EA4CD.3080804@silexonline.org>
References: <416EA4CD.3080804@silexonline.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Haroldo Gamal <haroldo.gamal@silexonline.org> wrote:
>
> This patch fixes "Samba Bugzilla Bug 999". The last version (2.6.8.1) of 
> smbfs kernel module do not honor uid, gid, file_mode and dir_mode 
> supplied by user during mount.

I merged this into -mm when you first sent it.  See
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc4/2.6.9-rc4-mm1/broken-out/smbfs-do-not-honor-uid-gid-file_mode-and-dir_mode-supplied.patch.

This latest patch seems to be significantly different from the earlier one.
What's up?
