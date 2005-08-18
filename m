Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932368AbVHRXeU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932368AbVHRXeU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 19:34:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932406AbVHRXeU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 19:34:20 -0400
Received: from twinlark.arctic.org ([207.7.145.18]:23697 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP id S932368AbVHRXeT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 19:34:19 -0400
Date: Thu, 18 Aug 2005 16:34:18 -0700 (PDT)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Folkert van Heusden <folkert@vanheusden.com>
cc: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       linux-kernel@vger.kernel.org
Subject: Re: zero-copy read() interface
In-Reply-To: <20050818104131.GH12313@vanheusden.com>
Message-ID: <Pine.LNX.4.63.0508181633510.20705@twinlark.arctic.org>
References: <20050818100151.GF12313@vanheusden.com> <20050818100536.GB16751@wohnheim.fh-wedel.de>
 <20050818104131.GH12313@vanheusden.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Aug 2005, Folkert van Heusden wrote:

> Doesn't that one also use copying? I've also heard that using mmap is
> expensive due to pagefaulting. I've found, for example, that copying a
> 1.3GB file using read/write instead of mmap & memcpy is seconds faster.

why would you memcpy if you're using mmap()?  just write() the mmap()d 
region.

-dean
