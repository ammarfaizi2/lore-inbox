Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265337AbRFVFf1>; Fri, 22 Jun 2001 01:35:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265338AbRFVFfS>; Fri, 22 Jun 2001 01:35:18 -0400
Received: from f00f.stub.clear.net.nz ([203.167.224.51]:15108 "HELO
	metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S265337AbRFVFfB>; Fri, 22 Jun 2001 01:35:01 -0400
Date: Fri, 22 Jun 2001 17:34:59 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        netdev@oss.sgi.com, "David S. Miller" <davem@redhat.com>
Subject: Re: PATCH: ethtool MII helpers
Message-ID: <20010622173459.D2642@metastasis.f00f.org>
In-Reply-To: <3B23AFC3.71CE2FD2@mandrakesoft.com> <20010622171037.D2576@metastasis.f00f.org> <3B32D694.CACF46D0@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B32D694.CACF46D0@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Fri, Jun 22, 2001 at 01:24:36AM -0400
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2001 at 01:24:36AM -0400, Jeff Garzik wrote:

    Sure, and that's planned.  Wanna send me a patch for it?  :)

Possibly, but I wonder if this is a kernel-space problem or not. Why
not put all the smarts into userland for it?

    It will definitely fall back on the MII ioctls if ethtool media
    support for the desired command doesn't exist.

Well, that is more or less as much as needs to be done. That, and
some kind of super-set API to be defined for all new stuff, having
two slightly different APIs for the same things sucks.



   --cw
