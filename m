Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281489AbRKHI4r>; Thu, 8 Nov 2001 03:56:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281488AbRKHI4h>; Thu, 8 Nov 2001 03:56:37 -0500
Received: from natpost.webmailer.de ([192.67.198.65]:35274 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S281487AbRKHI43>; Thu, 8 Nov 2001 03:56:29 -0500
Date: Thu, 8 Nov 2001 10:00:14 +0100
From: Peter Seiderer <Peter.Seiderer@ciselant.de>
To: linux-kernel@vger.kernel.org
Cc: Ville Herva <vherva@niksula.hut.fi>
Subject: Re: What is the difference between 'login: root' and 'su -' ?
Message-ID: <20011108100014.A704@zodiak.ecademix.com>
In-Reply-To: <20011107184710.A1410@zodiak.ecademix.com> <20011107224824.G26218@niksula.cs.hut.fi> <20011107234025.A602@zodiak.ecademix.com> <20011108081006.S1504@niksula.cs.hut.fi> <20011108094637.B615@zodiak.ecademix.com> <20011108104634.T1504@niksula.cs.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011108104634.T1504@niksula.cs.hut.fi>; from vherva@niksula.hut.fi on Thu, Nov 08, 2001 at 10:46:34AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
first thank you for your effort.

Did the diff: nearly no difference till the failure point (only pid, time etc.).
Peter

On Thu, Nov 08, 2001 at 10:46:34AM +0200, Ville Herva wrote:
> On Thu, Nov 08, 2001 at 09:46:37AM +0100, you [Peter Seiderer] claimed:
> > Hello,
> > in both cases file descriptor 4 is from 'open("/dev/hdc4", O_RDWR) = 4'  ....
> > Peter
> 
> Well, beats me. Sorry I wasn't much of a help...
> 
> One thing you could try is to capture the strace output of both sessions up
> to the point where the 'su -' one fails. Then do a diff for those logs and
> see if anything suspicios differs. Not much _should_ differ, I reckon...
> 
> 
> -- v --
> 
> v@iki.fi

-- 
------------------------------------------------------------------------
Peter Seiderer                     E-Mail:  Peter.Seiderer@ciselant.de
(Diplom-Informatiker Univ.)                   (PGP-key available)
Holzstr. 13                        WWW   :  http://www.ciselant.de
D-80469 Muenchen                   Phone :  +49 (0)89 - 69380934
------------------------------------------------------------------------
