Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275135AbRIYS06>; Tue, 25 Sep 2001 14:26:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275141AbRIYS0i>; Tue, 25 Sep 2001 14:26:38 -0400
Received: from waste.org ([209.173.204.2]:1824 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S275135AbRIYS0a>;
	Tue, 25 Sep 2001 14:26:30 -0400
Date: Tue, 25 Sep 2001 13:28:16 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: Alexander Viro <viro@math.psu.edu>
cc: William Scott Lockwood III <thatlinuxguy@hotmail.com>,
        Padraig Brady <padraig@antefacto.com>,
        Nerijus Baliunas <nerijus@users.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
Subject: Re: all files are executable in vfat
In-Reply-To: <Pine.GSO.4.21.0109251332470.24321-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.30.0109251323510.17451-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Sep 2001, Alexander Viro wrote:

> On Tue, 25 Sep 2001, William Scott Lockwood III wrote:
>
> > dmask?
>
> Umm... That makes sense.

Don't know if you already did this with umask, but {umask dmask uid gid}
probably make sense as per-mountpoint options rather than VFAT-specific
ones.

--
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

