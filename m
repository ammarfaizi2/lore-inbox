Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267170AbUJNWOq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267170AbUJNWOq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 18:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267934AbUJNWN2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 18:13:28 -0400
Received: from smtp.infolink.com.br ([200.187.64.6]:14853 "EHLO
	smtp.infolink.com.br") by vger.kernel.org with ESMTP
	id S267930AbUJNVtZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 17:49:25 -0400
Subject: Re: [PATCH] smbfs: smbfs do not honor uid, gid, file_mode and
	dir_mode supplied by user mount
From: Haroldo Gamal <haroldo.gamal@silexonline.org>
Reply-To: sileoxnline@silexonline.org
To: Andrew Morton <akpm@osdl.org>
Cc: samba@samba.org, linux-fsdevel@vger.kernel.org, urban@teststation.com,
       rddunlap@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20041014144107.5cf63998.akpm@osdl.org>
References: <416EA4CD.3080804@silexonline.org>
	 <20041014144107.5cf63998.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1097790562.24104.0.camel@gamal>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 14 Oct 2004 18:49:22 -0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the same patch. As I do not receive any ack I sent it again...

On Thu, 2004-10-14 at 18:41, Andrew Morton wrote:
> Haroldo Gamal <haroldo.gamal@silexonline.org> wrote:
> >
> > This patch fixes "Samba Bugzilla Bug 999". The last version (2.6.8.1) of 
> > smbfs kernel module do not honor uid, gid, file_mode and dir_mode 
> > supplied by user during mount.
> 
> I merged this into -mm when you first sent it.  See
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc4/2.6.9-rc4-mm1/broken-out/smbfs-do-not-honor-uid-gid-file_mode-and-dir_mode-supplied.patch.
> 
> This latest patch seems to be significantly different from the earlier one.
> What's up?
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

