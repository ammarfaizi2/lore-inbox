Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262492AbRENVIM>; Mon, 14 May 2001 17:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262495AbRENVHw>; Mon, 14 May 2001 17:07:52 -0400
Received: from oss.sgi.com ([216.32.174.190]:5644 "EHLO oss.sgi.com")
	by vger.kernel.org with ESMTP id <S262492AbRENVHs>;
	Mon, 14 May 2001 17:07:48 -0400
Date: Sun, 13 May 2001 15:17:48 -0300
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Anuradha Ratnaweera <anuradha@gnu.org>
Cc: Russell King <rmk@arm.linux.org.uk>,
        Duncan Gauld <duncan@gauldd.freeserve.co.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: Possible README patch
Message-ID: <20010513151748.A1164@bacchus.dhis.org>
In-Reply-To: <20010505102133.A16788@flint.arm.linux.org.uk> <Pine.LNX.4.21.0105101754080.283-100000@presario>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0105101754080.283-100000@presario>; from anuradha@gnu.org on Thu, May 10, 2001 at 05:58:21PM +0600
X-Accept-Language: de,en,fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 10, 2001 at 05:58:21PM +0600, Anuradha Ratnaweera wrote:
> Date: 	Thu, 10 May 2001 17:58:21 +0600 (LKT)
> From: Anuradha Ratnaweera <anuradha@gnu.org>
> To: Russell King <rmk@arm.linux.org.uk>
> cc: Duncan Gauld <duncan@gauldd.freeserve.co.uk>, linux-kernel@vger.kernel.org
> Subject: Re: Possible README patch
> 
> 
> On Sat, 5 May 2001, Russell King wrote:
> 
> > gzip -dc linux-2.4.XX.tar.gz | tar zvf -
> > gzip -dc patchXX.gz | patch -p0
> 
> This does _not_ work for international kernel patch. They assume the
> directories lin.2.x.x/ (old) and int.2.x.x/ (new) and not linux/.
> Therefore it _is_ necessary to `cd linux' and do a `patch -p1'.

Or patch -p0 -d linux.

  Ralf
