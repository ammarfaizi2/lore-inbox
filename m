Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275839AbRJSAv3>; Thu, 18 Oct 2001 20:51:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276813AbRJSAvU>; Thu, 18 Oct 2001 20:51:20 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:24048
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S275798AbRJSAvG>; Thu, 18 Oct 2001 20:51:06 -0400
Date: Thu, 18 Oct 2001 17:51:26 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
Cc: James Sutherland <jas88@cam.ac.uk>, Ben Greear <greearb@candelatech.com>,
        Neil Brown <neilb@cse.unsw.edu.au>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: RFC - tree quotas for Linux (2.4.12, ext2)
Message-ID: <20011018175126.E2467@mikef-linux.matchmail.com>
Mail-Followup-To: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>,
	James Sutherland <jas88@cam.ac.uk>,
	Ben Greear <greearb@candelatech.com>,
	Neil Brown <neilb@cse.unsw.edu.au>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
In-Reply-To: <mfedyk@matchmail.com> <20011018155636.B2467@mikef-linux.matchmail.com> <200110190014.f9J0Ej7T016629@sleipnir.valparaiso.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200110190014.f9J0Ej7T016629@sleipnir.valparaiso.cl>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2001 at 09:14:45PM -0300, Horst von Brand wrote:
> Mike Fedyk <mfedyk@matchmail.com> said:
> > Lets say that you have about 50GB of space, but you only want to allow 20GB
> > for a certain tree (possibly mp3s), and you want to keep user ownerships of
> > the files they contribute.
> 
> Then they just copy the mp3's wherever they want, and symlink them into
> the tree. No (meaningful) charge.
> 
> BTW, you get (almost exactly) the same effect by mounting a partition of
> 20Gb under /mp3

Yep, unless you're sharing with nfs, and the path is different on the client
than on the server...  But it would work with ftp, http, smb, or anything
that follows the symlink on the server.

What we need is quota based on file type, no not extention, but the return
value of `file`.  j/k

Can anyone come up with something useful that a treequota will help?

Mike
