Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277473AbRJJWVS>; Wed, 10 Oct 2001 18:21:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277476AbRJJWVH>; Wed, 10 Oct 2001 18:21:07 -0400
Received: from sweetums.bluetronic.net ([66.57.88.6]:25537 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id <S277473AbRJJWUx>; Wed, 10 Oct 2001 18:20:53 -0400
Date: Wed, 10 Oct 2001 18:21:01 -0400 (EDT)
From: Ricky Beam <jfbeam@bluetopia.net>
X-X-Sender: <jfbeam@sweetums.bluetronic.net>
To: Mingming cao <cmm@us.ibm.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]Fix bug:rmdir could remove current working directory
In-Reply-To: <3BC4E8AD.72F175E3@us.ibm.com>
Message-ID: <Pine.GSO.4.33.0110101816320.22872-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Oct 2001, Mingming cao wrote:
>I read the man page of
>rmdir(2).  It says in this case EBUSY error should be returned.  I
>suspected this is a bug and added a check in vfs_rmdir(). The following
>patch is against 2.4.10 and has been verified.  Please comment and
>apply.

The bug is in the manpage.  This was discussed over a year ago (some time
after 2.1.44 introduced dcache (it was broken then, but that's when it
appeared.))

--Ricky


