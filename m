Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265324AbRF0Mtx>; Wed, 27 Jun 2001 08:49:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265326AbRF0Mto>; Wed, 27 Jun 2001 08:49:44 -0400
Received: from metastasis.f00f.org ([203.167.249.89]:7041 "HELO weta.f00f.org")
	by vger.kernel.org with SMTP id <S265324AbRF0Mt2>;
	Wed, 27 Jun 2001 08:49:28 -0400
Date: Thu, 28 Jun 2001 00:48:54 +1200
To: Ben Ford <ben@kalifornia.com>
Cc: Marty Leisner <leisner@rochester.rr.com>, linux-kernel@vger.kernel.org
Subject: Re: mounting a fs in two places at once?
Message-ID: <20010628004854.B7331@weta.f00f.org>
In-Reply-To: <200106250212.WAA05336@soyata.home> <3B370250.1050305@kalifornia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B370250.1050305@kalifornia.com>
User-Agent: Mutt/1.3.18i
From: cw@f00f.org (Chris Wedgwood)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2001 at 02:20:16AM -0700, Ben Ford wrote:

> Feature.  It actually makes it quite nice when you want to allow
> chrooted user(s) access to a common directory, you just mount a
> partition in all the users home dirs.

For security, this can be a bad idea.

Potentially, chrooted user can mess with another, by messing with
libraries and such like. In most cases not terribly easy, but in some
cases possible.

No, if the fs was mounted RO, then I assume you would have less to
worry about. Its a pity the VFS code doesn't allow you to fix RO & RW
of the same fs.



  --cw


