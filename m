Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261743AbVCGKcZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261743AbVCGKcZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 05:32:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261741AbVCGKcZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 05:32:25 -0500
Received: from coderock.org ([193.77.147.115]:12724 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261740AbVCGKaX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 05:30:23 -0500
Date: Mon, 7 Mar 2005 11:30:14 +0100
From: Domen Puncer <domen@coderock.org>
To: "Edgar, Bob" <Bob.Edgar@commerzbankib.com>
Cc: "'Jesper Juhl'" <juhl-lkml@dif.dk>, Steve French <sfrench@us.ibm.com>,
       =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Luca Tettamanti <kronos@kronoz.cjb.net>,
       samba-technical <samba-technical@lists.samba.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] whitespace cleanups for fs/cifs/file.c
Message-ID: <20050307103014.GD18117@nd47.coderock.org>
References: <9D248E1E43ABD411A9B600508BAF6E9B0C737269@xmx7fraib.fra.ib.commerzbank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9D248E1E43ABD411A9B600508BAF6E9B0C737269@xmx7fraib.fra.ib.commerzbank.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/05 10:26 +0100, Edgar, Bob wrote:
> I lurk on the list and didn't comment last time but there is one aspect
> of this patch that I think is "bad" style. The function declaration should
> not be on the same line with the type. Why? Try to find the file where a
> function is defined instead of used. If you grep "^funcname" you'll find
> it quite simply. The same is true in YFE (mine being vi) /^funcname gets
> me there in one shot.

Does anybody actually use grep "^funcname"? cscope/ctags is the way.

> 
> This may not seem an important thing but when you are coming into a
> project cold and don't know how anything works or where it lives it
> can be very important. Consider trying to find where some common
> function from a library is defined in a project with sever 1000 files.

Again... cscope or ctags will make your life much easier here.

> 
> I now return you to your regularly scheduled programming.
> 
> bob
> 
> -----Original Message-----
> From:
> samba-technical-bounces+bob.edgar=commerzbankib.com@lists.samba.org
> [mailto:samba-technical-bounces+bob.edgar=commerzbankib.com@lists.samba.
> org]On Behalf Of Jesper Juhl
> Sent: Freitag, 4. März 2005 20:24
> To: Steve French
> Cc: Jörn Engel; Luca Tettamanti; samba-technical; Linux Kernel Mailing
> List; Domen Puncer
> Subject: [PATCH] whitespace cleanups for fs/cifs/file.c
...
> -int
> -cifs_open(struct inode *inode, struct file *file)
> +int cifs_open(struct inode *inode, struct file *file)
...
