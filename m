Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281728AbRKWXpZ>; Fri, 23 Nov 2001 18:45:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281770AbRKWXpR>; Fri, 23 Nov 2001 18:45:17 -0500
Received: from mail.cafes.net ([207.65.182.25]:48644 "HELO mail.cafes.net")
	by vger.kernel.org with SMTP id <S281728AbRKWXpF>;
	Fri, 23 Nov 2001 18:45:05 -0500
Date: Fri, 23 Nov 2001 17:45:04 -0600
From: Mike Eldridge <diz@cafes.net>
To: Andreas Dilger <adilger@turbolabs.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Filesize limit on SMBFS
Message-ID: <20011123174504.S21290@mail.cafes.net>
In-Reply-To: <Pine.LNX.4.42.0111231034330.15987-100000@boston.corp.fedex.com> <002801c1740f$7372f650$1300a8c0@marcelo> <20011123171157.Q21290@mail.cafes.net> <20011123161947.E1308@lynx.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011123161947.E1308@lynx.no>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2001 at 04:19:47PM -0700, Andreas Dilger wrote:
> On Nov 23, 2001  17:11 -0600, Mike Eldridge wrote:
> > ext2 has a 2GB filesize limitation.
> 
> Where do you get that idea from.  I have created files up to 4TB (sparse
> ones, of course) without problems.  After that you start hitting bugs in
> the VFS and ext2 _code_, but you should be able to have up to 16TB files
> on a 4kB block ext2 fs.
> 
> Please stop spreading misinformation.  Maybe there is a 2GB limitation
> in libc, or your tools, or in 2.2 ext2 _implementation_ (which is
> fixed if you apply the LFS patch for ext2), but no such limit in the
> design of ext2 itself.

oooh.  i apologize.  i remember reading in several different places that
little tidbit i rattled off.

i stand (majorly) corrected.

-mike

--------------------------------------------------------------------------
   /~\  The ASCII                       all that is gold does not glitter
   \ /  Ribbon Campaign                 not all those who wander are lost
    X   Against HTML                          -- jrr tolkien
   / \  Email!

          radiusd+mysql: http://www.cafes.net/~diz/kiss-radiusd           
--------------------------------------------------------------------------
