Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289018AbSANUcc>; Mon, 14 Jan 2002 15:32:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288992AbSANUbH>; Mon, 14 Jan 2002 15:31:07 -0500
Received: from mail016.syd.optusnet.com.au ([203.2.75.176]:27336 "EHLO
	mail016.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id <S289018AbSANUaf>; Mon, 14 Jan 2002 15:30:35 -0500
Date: Tue, 15 Jan 2002 07:29:40 +1100
From: Andrew Clausen <clausen@gnu.org>
To: Chris Mason <mason@suse.com>
Cc: Andreas Dilger <adilger@turbolabs.com>, Oleg Drokin <green@namesys.com>,
        Hans Reiser <reiser@namesys.com>, reiserfs-list@namesys.com,
        linux-kernel@vger.kernel.org, ewald.peiszer@gmx.at,
        matthias.andree@stud.uni-dortmund.de
Subject: Re: [reiserfs-list] Boot failure: msdos pushes in front of reiserfs
Message-ID: <20020115072940.J20639@gnu.org>
In-Reply-To: <20020113223803.GA28085@emma1.emma.line.org> <20020114095013.A4760@namesys.com> <3C42BE0E.2090902@namesys.com> <20020114143650.D828@namesys.com> <20020114104242.M26688@lynx.adilger.int> <551760000.1011039675@tiny>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <551760000.1011039675@tiny>; from mason@suse.com on Mon, Jan 14, 2002 at 03:21:15PM -0500
X-Accept-Language: en,pt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2002 at 03:21:15PM -0500, Chris Mason wrote:
> Hmmm mke2fs seems to always zero out the first 1024, except on sparcs (when
> ZAP_BOOT_BLOCK not defined).  I thought alphas stored the partition table on
> the first block of the first partition as well, and that we didn't want to
> zero it then.

*nitpick*

I think that's Sun... Alpha's use either BSD or MSDOS tables, neither
of which do that...

Andrew

