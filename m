Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269668AbRHCXFy>; Fri, 3 Aug 2001 19:05:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269675AbRHCXFo>; Fri, 3 Aug 2001 19:05:44 -0400
Received: from weta.f00f.org ([203.167.249.89]:3472 "HELO weta.f00f.org")
	by vger.kernel.org with SMTP id <S269668AbRHCXFa>;
	Fri, 3 Aug 2001 19:05:30 -0400
Date: Sat, 4 Aug 2001 11:06:14 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Chris Mason <mason@suse.com>
Subject: Re: [PATCH] 2.4.8-pre3 fsync entire path (+reiserfs fsync semantic change patch)
Message-ID: <20010804110614.A17925@weta.f00f.org>
In-Reply-To: <9keqr6$egl$1@penguin.transmeta.com> <01080315090600.01827@starship> <Pine.GSO.4.21.0108031400590.3272-100000@weyl.math.psu.edu> <9keqr6$egl$1@penguin.transmeta.com> <5.1.0.14.2.20010803232810.0415b840@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5.1.0.14.2.20010803232810.0415b840@pop.cus.cam.ac.uk>
User-Agent: Mutt/1.3.20i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 03, 2001 at 11:29:29PM +0100, Anton Altaparmakov wrote:

    Your patch down()s a semaphore without calling up() in the error
    code path...

Errors? Nah, you won't get errors :)


Yes, it does... I did a quick copy of the code from above and didn't
check it. I'll fix that shortly.



  --cw
