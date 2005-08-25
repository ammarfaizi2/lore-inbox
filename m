Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964960AbVHYMgw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964960AbVHYMgw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 08:36:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964961AbVHYMgw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 08:36:52 -0400
Received: from nproxy.gmail.com ([64.233.182.202]:64716 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964960AbVHYMgw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 08:36:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mT9cJVGXEu2ph/zX6GhCdZvbjuFKWh1kcEG145Q51U+Us49WqPO9VXapOuQUt5U3C4PzshNe8aG+HoAEPc4raH8oEJxHbpLaYgXeXNh32yAOYT2kmhTbJe2twsLV/iX+mECQPNpThtp293uwNEYenFOIoHQO+B6HR1wQtA7OAbg=
Message-ID: <2cd57c90050825053610b241de@mail.gmail.com>
Date: Thu, 25 Aug 2005 20:36:45 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
To: Pekka J Enberg <penberg@cs.helsinki.fi>
Subject: Re: [PATCH] VFS: update documentation
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       Anton Altaparmakov <aia21@cam.ac.uk>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Carsten Otte <cotte.de@gmail.com>
In-Reply-To: <Pine.LNX.4.58.0508250921460.30979@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.58.0508250921460.30979@sbz-30.cs.Helsinki.FI>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/25/05, Pekka J Enberg <penberg@cs.helsinki.fi> wrote:

> 
> @@ -392,6 +585,23 @@ otherwise noted.
>    fasync: called by the fcntl(2) system call when asynchronous
>         (non-blocking) mode is enabled for a file
> 
> +  lock: called by the fcntl(2) system call for F_GETLK, F_SETLK, and F_SETLKW
> +       commands
> +
> +  readv: called by the readv(2) system call
> +
> +  writev: called by the readv(2) system call

s/readv/writev/

> +
> +  sendfile: called by the sendfile(2) system call
> +
> +  get_unmapped_area: called by the mmap(2) system call
> +
> +  check_flags: called by the fcntl(2) system call for F_SETFL command
> +
> +  dir_notify: called by the fcntl(2) system call for F_NOTIFY command
> +
> +  flock: called by the flock(2) system call
> +


-- 
Coywolf Qi Hunt
http://ahbl.org/~coywolf/
