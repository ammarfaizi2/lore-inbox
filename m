Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290135AbSAQS6x>; Thu, 17 Jan 2002 13:58:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290150AbSAQS6n>; Thu, 17 Jan 2002 13:58:43 -0500
Received: from smtp-out-6.wanadoo.fr ([193.252.19.25]:13473 "EHLO
	mel-rto6.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S290149AbSAQS6d>; Thu, 17 Jan 2002 13:58:33 -0500
Message-ID: <3C471E5E.1090103@wanadoo.fr>
Date: Thu, 17 Jan 2002 19:56:30 +0100
From: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:0.9.7) Gecko/20011221
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Tomasz Torcz <zdzichu@irc.pl>
CC: linux-kernel@vger.kernel.org
Subject: Re: OOPS on 2.4.17 -18pre4 while mounting root (reiserfs, on LVM, devfs)
In-Reply-To: <20020117182758.GA736@irc.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomasz Torcz wrote:

> VFS: Mounted root (reiserfs filesystem) readonly.
> devfs: devfs_do_symlink(root): could not append to parent, err: -17
> change_root: old root has d_count=2

try booting with devfs=nomount as devfs is not properly configured on 
your system.


Pierre
-- 
------------------------------------------------
  Pierre Rousselet <pierre.rousselet@wanadoo.fr>
------------------------------------------------

