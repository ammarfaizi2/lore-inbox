Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264678AbTD0Pn4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Apr 2003 11:43:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264682AbTD0Pn4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Apr 2003 11:43:56 -0400
Received: from pat.uio.no ([129.240.130.16]:24992 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S264678AbTD0Pnz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Apr 2003 11:43:55 -0400
To: Shantanu Goel <sgoel01@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21-rc1-ac2 NFS close-to-open question
References: <20030427151201.27191.qmail@web12802.mail.yahoo.com>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 27 Apr 2003 17:56:07 +0200
In-Reply-To: <20030427151201.27191.qmail@web12802.mail.yahoo.com>
Message-ID: <shshe8k6ijs.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Shantanu Goel <sgoel01@yahoo.com> writes:

     > if (!(NFS_SERVER(inode)->flags & NFS_MOUNT_NOCTO)) {
     >   err =
     > _nfs_revalidate_inode(NFS_SERVER(inode),inode);
     >   if (err)
     >     goto out;
     > }

     > If we desire close-to-open consistency, and assuming my reading
     > of the code is correct, is this a typo?

Duh... Now *that* is downright embarassing...
Yup. Damn right...

Cheers,
  Trond
