Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315993AbSETNuv>; Mon, 20 May 2002 09:50:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316023AbSETNuu>; Mon, 20 May 2002 09:50:50 -0400
Received: from APuteaux-101-2-1-180.abo.wanadoo.fr ([193.251.40.180]:51726
	"EHLO inet6.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S315993AbSETNuu>; Mon, 20 May 2002 09:50:50 -0400
Date: Mon, 20 May 2002 15:50:40 +0200
From: Lionel Bouton <Lionel.Bouton@inet6.fr>
To: Jens-Christian Skibakk <jens.c.skibakk@hiof.no>
Cc: morten.helgesen@nextframe.net,
        Jens Christian Skibakk <jenscski@sylfest.hiof.no>,
        linux-kernel@vger.kernel.org
Subject: Re: EXT3-fs error (device ide0(3,77)) in ext3_new_inode: error 28
Message-ID: <20020520155040.A19459@bouton.inet6-interne.fr>
Mail-Followup-To: Jens-Christian Skibakk <jens.c.skibakk@hiof.no>,
	morten.helgesen@nextframe.net,
	Jens Christian Skibakk <jenscski@sylfest.hiof.no>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0205201400490.11918-100000@sylfest.hiof.no> <20020520142325.B143@sexything> <3CE8FCDC.721DFC5D@hiof.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2002 at 03:40:44PM +0200, Jens-Christian Skibakk wrote:
> The df -i shows that there are now unused inodes.
> 
> SO I need to reformat my hd to have more inodes?
> 

Or you can make use of the loopback device if reformating the partition is
not an option.

You'll lose a bit of perf (don't know how much), but you can do this without
interrupting anything that depends on this filesystem.

LB.
