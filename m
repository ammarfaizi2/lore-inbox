Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269691AbRHCXey>; Fri, 3 Aug 2001 19:34:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269702AbRHCXep>; Fri, 3 Aug 2001 19:34:45 -0400
Received: from weta.f00f.org ([203.167.249.89]:8592 "HELO weta.f00f.org")
	by vger.kernel.org with SMTP id <S269691AbRHCXeh>;
	Fri, 3 Aug 2001 19:34:37 -0400
Date: Sat, 4 Aug 2001 11:35:25 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Chris Mason <mason@suse.com>
Subject: Re: [PATCH] 2.4.8-pre3 fsync entire path (+reiserfs fsync semantic change patch)
Message-ID: <20010804113525.E17925@weta.f00f.org>
In-Reply-To: <20010804112026.D17925@weta.f00f.org> <Pine.GSO.4.21.0108031923581.5264-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0108031923581.5264-100000@weyl.math.psu.edu>
User-Agent: Mutt/1.3.20i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 03, 2001 at 07:25:19PM -0400, Alexander Viro wrote:

    You need credentials to sync a regular file on any network
    filesystem.

For 2.5.x I assume your planning or a credentials cache?  Something
like dentry->d_creds or something?  If that's the case we still don't
need the struct file* to be passed --- but I suspect that's not the
case and I really don't understand.



  --cw



