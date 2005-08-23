Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932152AbVHWU3p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152AbVHWU3p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 16:29:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932379AbVHWU3p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 16:29:45 -0400
Received: from wproxy.gmail.com ([64.233.184.207]:46315 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932152AbVHWU3o convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 16:29:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bEzHtKnpEBhnCraHwlI0zvgMNVdqQ8Dq/5gYbLPgN9ZIVu82nZ/92QdUWlZ1mNv8WIR0RVjYJRruU4BoLYnLjDlgm93IwTcOmSCXqvbuV5NJO77VaXRBGb+jY57zKD9rsFAIxon5iT19sVguoLxZPtS5ubwYQujQh2TOGY8Z4GI=
Message-ID: <5c77e7070508231329facb3da@mail.gmail.com>
Date: Tue, 23 Aug 2005 22:29:40 +0200
From: Carsten Otte <cotte.de@gmail.com>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: [RFC][PATCH] VFS: update documentation
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1124624250.5381.2.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1124624250.5381.2.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/21/05, Pekka Enberg <penberg@cs.helsinki.fi> wrote:
> This patch updates the out-of-date Documentation/filesystems/vfs.txt.
> As I am a novice on the VFS, I would much appreciate any comments and
> help on this.
Cool, thanks for updating it :)

> +  get_xip_page: called by the VM to translate a block number to a page.
> +       This is used by filesystems that want to implement execute-in-place
> +       (XIP).
A little more would be helpful, like:
get_xip_page: called by the VM to translate a block number to a page. 
        The page is valid until the corresponding filesystem is
unmounted. Filesystems
        that want to use execute-in-place (XIP) need to implement it.
        An example implementation can be found in fs/ext2/xip.c

cheers,
Carsten
