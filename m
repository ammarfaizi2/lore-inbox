Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265139AbUGGM6m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265139AbUGGM6m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 08:58:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265104AbUGGM6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 08:58:41 -0400
Received: from [213.146.154.40] ([213.146.154.40]:39305 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S265127AbUGGM4h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 08:56:37 -0400
Date: Wed, 7 Jul 2004 13:56:36 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Oleg Drokin <green@clusterfs.com>
Cc: linux-kernel@vger.kernel.org, braam@clusterfs.com
Subject: Re: [0/9] Lustre VFS patches for 2.6
Message-ID: <20040707125636.GA18058@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Oleg Drokin <green@clusterfs.com>, linux-kernel@vger.kernel.org,
	braam@clusterfs.com
References: <20040707124732.GA25877@clusterfs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040707124732.GA25877@clusterfs.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 07, 2004 at 03:47:32PM +0300, Oleg Drokin wrote:
> Hello!
> 
>    Following this mail, there are nine patches necessary for Lustre support
>    in 2.6. The patches are against latest 2.6 bk snapshot.
>    Compared to previous sets of patches, this one does not change existing
>    structure and field names therefore leaving kernel VFS API completely intact.
>    Also raw operations approach is changed, extra inode operation is introduced
>    that is supposed to be called at the end of parent lookup and do necessary
>    operations, if possible.
>    Of course it would be great if these patches would be included into the
>    kernel right away (and that is one of the reasons this set of patches
>    keeps old API intact). Also there were at least some interest in some of the
>    patches from other parties (e.g. Trond Myklebust was interested in some
>    intent changes as I remember) and we are ready to work with those so that
>    the patches will suit their needs as well.

So do you have plans to submit lustre for inclusion soon?  Else merging is
completely pointless as it'll fall victim to dead code removal real soon.

