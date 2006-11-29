Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967368AbWK2OsY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967368AbWK2OsY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 09:48:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967367AbWK2OsY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 09:48:24 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:46689 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S967368AbWK2OsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 09:48:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RRnBnMpihBzn7U/brXA3kp65NJC/zZlI5Lm8gfUySKLOdcj1BJnJ00NN5oM7VH8H5gKWrCoaSKuBcvysUE9JnFb5FrUS8vHw6gQJCxhjHhYXQnk3Aa/4Ff0iNg0I55ijMrRELWz86Knu/3Uz8GH0lhA/YV3QroVAAbxQfEsP9uc=
Message-ID: <b6fcc0a0611290648kcef7dacs670eef2588d00788@mail.gmail.com>
Date: Wed, 29 Nov 2006 17:48:14 +0300
From: "Alexey Dobriyan" <adobriyan@gmail.com>
To: "d binderman" <dcb314@hotmail.com>
Subject: Re: fs/9p/vfs_inode.c(406): remark #593: variable "sb" was set but never used
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <BAY107-F302D53E3CC04B6B8AEA7E29CE40@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <BAY107-F302D53E3CC04B6B8AEA7E29CE40@phx.gbl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/06, d binderman <dcb314@hotmail.com> wrote:
>
> Hello there,
>
> I just tried to compile Linux kernel 2.6.18.3 with the Intel C
> C compiler.
>
> The compiler said
>
> 1.
>
> fs/9p/vfs_inode.c(406): remark #593: variable "sb" was set but never used
>
> The source code is
>
>     struct super_block *sb = NULL;
>
> I have checked the source code and I agree with the compiler.
> Suggest delete local variable.
>
> 2.
>
> fs/9p/vfs_inode.c(757): remark #593: variable "olddirfidnum" was set but
> never used
> fs/9p/vfs_inode.c(758): remark #593: variable "newdirfidnum" was set but
> never used

Please, upload full list of these warnings somewhere and post URL.
