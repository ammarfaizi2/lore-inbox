Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288953AbSBVBAr>; Thu, 21 Feb 2002 20:00:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290118AbSBVBAh>; Thu, 21 Feb 2002 20:00:37 -0500
Received: from tomts21-srv.bellnexxia.net ([209.226.175.183]:7351 "EHLO
	tomts21-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S288953AbSBVBAX>; Thu, 21 Feb 2002 20:00:23 -0500
Date: Thu, 21 Feb 2002 20:00:21 -0500 (EST)
From: Craig <penguin@wombat.ca>
X-X-Sender: carsnau@wombat
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: SOLVED -> Re: Serial Console changes in linux 2.4.15??
In-Reply-To: <m1d6z23wjy.fsf@frodo.biederman.org>
Message-ID: <Pine.LNX.4.42.0202211958030.23209-100000@wombat>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 Feb 2002, Eric W. Biederman wrote:

> Old versions of /sbin/init are broken and clear CREAD.  Most getty's (except
> mingetty) do the right thing.  I saw the change at 2.4.2 -> 2.4.3.  I
> don't why some people have managed to avoid it for longer periods of
> time.
>
> The great mystery is how /sbin/init managed to work in 2.4.2....
>
> Eric
>


Eric,
  Thanks very much to both you and Alan.  You were exactly right.  The version
of /sbin/init on our filesystem was quite old (2 years old).  I grabbed the tar
ball of the newest version, and using this version (without the "#if 0" lines)
works just fine because it sets up the console properly.

Thanks again.

--
Craig.
+------------------------------------------------------+
http://www.wombat.ca               Why? Why not.
http://www.washington.edu/pine/    Pine @ the U of Wash.
+-------------=*sent via Pine4.42*=--------------------+



