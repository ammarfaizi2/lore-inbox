Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266512AbSKGMKg>; Thu, 7 Nov 2002 07:10:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266516AbSKGMKg>; Thu, 7 Nov 2002 07:10:36 -0500
Received: from almesberger.net ([63.105.73.239]:17162 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S266512AbSKGMKf>; Thu, 7 Nov 2002 07:10:35 -0500
Date: Thu, 7 Nov 2002 09:17:10 -0300
From: Werner Almesberger <wa@almesberger.net>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Alexander Viro <viro@math.psu.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [lkcd-devel] Re: What's left over.
Message-ID: <20021107091710.G10679@almesberger.net>
References: <20021105221050.A10679@almesberger.net> <Pine.GSO.4.21.0211052017320.6521-100000@steklov.math.psu.edu> <20021105230505.D10679@almesberger.net> <m18z05ewzj.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m18z05ewzj.fsf@frodo.biederman.org>; from ebiederm@xmission.com on Wed, Nov 06, 2002 at 11:04:48PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
[ Al's FS-based kexec interface ]

> For the record my opinion is there is extra code bloat but it is ok
> if it is built as kexecfs.  Any other way of getting a magic file
> to work with seems currently insane.

Yes, such an interface change would only make sense if you couldn't
get the system call, or if there would actually be a useful way for
setting up kexec using "third party" programs. But it seems unlikely
to me that somebody could get all the magic right just by using dd.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
