Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265201AbUGGPOX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265201AbUGGPOX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 11:14:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265206AbUGGPOX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 11:14:23 -0400
Received: from linuxhacker.ru ([217.76.32.60]:37786 "EHLO shrek.linuxhacker.ru")
	by vger.kernel.org with ESMTP id S265201AbUGGPOW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 11:14:22 -0400
Date: Wed, 7 Jul 2004 18:14:04 +0300
From: Oleg Drokin <green@clusterfs.com>
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       braam@clusterfs.com
Subject: Re: [0/9] Lustre VFS patches for 2.6
Message-ID: <20040707151404.GJ5619@linuxhacker.ru>
References: <20040707124732.GA25877@clusterfs.com> <20040707125636.GA18058@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040707125636.GA18058@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Wed, Jul 07, 2004 at 01:56:36PM +0100, Christoph Hellwig wrote:
> >    patches from other parties (e.g. Trond Myklebust was interested in some
> >    intent changes as I remember) and we are ready to work with those so that
> >    the patches will suit their needs as well.
> So do you have plans to submit lustre for inclusion soon?  Else merging is

Well, the problems with that is that lustre still evolves pretty quickly,
but once it is in kernel, it is sort of set in stone, no more easy changes
to the wire protocol, no more big internal changes (fast)...

> completely pointless as it'll fall victim to dead code removal real soon.

Well, there is not all that much "dead" code introduced (I hope). Esp. if some
of the new intent code will be used by NFS, for example.
And it is not all that dead too, there would be at least one off-tree user ;)

Bye,
    Oleg
