Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261167AbVCZQov@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261167AbVCZQov (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 11:44:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261173AbVCZQov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 11:44:51 -0500
Received: from mx1.mail.ru ([194.67.23.121]:52012 "EHLO mx1.mail.ru")
	by vger.kernel.org with ESMTP id S261167AbVCZQou (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 11:44:50 -0500
From: Alexey Dobriyan <adobriyan@mail.ru>
To: Jesper Juhl <juhl-lkml@dif.dk>
Subject: Re: [PATCH][1/6] cifs: inode.c cleanup - function definitions (whitespace changes only)
Date: Sat, 26 Mar 2005 19:44:46 +0300
User-Agent: KMail/1.7.1
Cc: Steve French <smfrench@austin.rr.com>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.62.0503261456390.2488@dragon.hyggekrogen.localhost>
In-Reply-To: <Pine.LNX.4.62.0503261456390.2488@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503261944.47012.adobriyan@mail.ru>
X-Spam: Not detected
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 26 March 2005 16:57, Jesper Juhl wrote:
> Clean up function definitione. Return value on same line as function name,
> consistent spacing between arguments, etc.

> --- linux-2.6.12-rc1-mm3-orig/fs/cifs/inode.c
> +++ linux-2.6.12-rc1-mm3/fs/cifs/inode.c

> -int
> -cifs_get_inode_info_unix(struct inode **pinode,
> -			 const unsigned char *search_path,
> -			 struct super_block *sb,int xid)
> +int cifs_get_inode_info_unix(struct inode **pinode,
> +	const unsigned char *search_path, struct super_block *sb, int xid)

Looks like code in fs/cifs/ align parameters after bracket.

int cifs_get_inode_info_unix(struct inode **pinode,
			     const unsigned char *search_path,
			     struct super_block *sb, int xid)


