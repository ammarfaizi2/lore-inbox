Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265532AbRF1FFx>; Thu, 28 Jun 2001 01:05:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265537AbRF1FFn>; Thu, 28 Jun 2001 01:05:43 -0400
Received: from metastasis.f00f.org ([203.167.249.89]:12929 "HELO weta.f00f.org")
	by vger.kernel.org with SMTP id <S265536AbRF1FFb>;
	Thu, 28 Jun 2001 01:05:31 -0400
Date: Thu, 28 Jun 2001 17:04:54 +1200
To: Alexander Viro <viro@math.psu.edu>
Cc: Chris Wedgwood <cw@f00f.org>, Ben Ford <ben@kalifornia.com>,
        Marty Leisner <leisner@rochester.rr.com>, linux-kernel@vger.kernel.org
Subject: Re: mounting a fs in two places at once?
Message-ID: <20010628170454.D9011@weta.f00f.org>
In-Reply-To: <Pine.GSO.4.21.0106271005340.19655-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0106271005340.19655-100000@weyl.math.psu.edu>
User-Agent: Mutt/1.3.18i
From: cw@f00f.org (Chris Wedgwood)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2001 at 10:22:17AM -0400, Alexander Viro wrote:

> If you want root-proof analog of chroot - fine, but that will require
> at least taking away the ability to mount/umount anything.

How does FreeBSD implement this with jails? Don't jailed people get
dummy /dev access that is more or less crippled?


I wonder if all this effort is really worth it though, it seems like
lots of 'fixes' to avoid the all-powerful root, so perhaps the fix
lies elsewhere?



  --cw

