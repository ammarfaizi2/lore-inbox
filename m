Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750720AbVKKLvL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750720AbVKKLvL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 06:51:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750724AbVKKLvL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 06:51:11 -0500
Received: from nproxy.gmail.com ([64.233.182.205]:45510 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750720AbVKKLvK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 06:51:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nHpf4lXSRi1qqmwyJQM9KC04MZZDLcgd3UVKR+QD1a+DnOFNRHk7wot6JQAYH5WPC41XnwbPcN5Dv0HQxklsj9qdd9SQ+ot8HPoDEveaEg7DBvDzXWo37nkW1uljJqL9uRER6NPZbCMaY/rHHjJEAhU6qKk5Y/Lrc4hwdf6Bino=
Message-ID: <84144f020511110351h68ced090l6a7ed2f3c4f84819@mail.gmail.com>
Date: Fri, 11 Nov 2005 13:51:08 +0200
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Christoph Lameter <clameter@engr.sgi.com>
Subject: Re: [PATCH] Remove alloc_pages() use from slab allocator
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, alokk@calsoftinc.com
In-Reply-To: <Pine.LNX.4.62.0511101347430.16380@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.62.0511101347430.16380@schroedinger.engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On 11/10/05, Christoph Lameter <clameter@engr.sgi.com> wrote:
> The slab allocator never uses alloc_pages since kmem_getpages() is always
> called with a valid nodeid. Remove the branch and the code from kmem_getpages()
>
> Signed-off-by: Christoph Lameter <clameter@sgi.com>

The patch looks good to me.

P.S. Please use the address penberg@cs.helsinki.fi instead when sending me mail.

                                       Pekka
