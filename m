Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276424AbRJYVYZ>; Thu, 25 Oct 2001 17:24:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276429AbRJYVYR>; Thu, 25 Oct 2001 17:24:17 -0400
Received: from sweetums.bluetronic.net ([66.57.88.6]:32952 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id <S276397AbRJYVYB>; Thu, 25 Oct 2001 17:24:01 -0400
Date: Thu, 25 Oct 2001 17:24:33 -0400 (EDT)
From: Ricky Beam <jfbeam@bluetopia.net>
X-X-Sender: <jfbeam@sweetums.bluetronic.net>
To: Mike <maneman@gmx.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Machine Check Exception in >2.4.5: Where to comment MCE out?
In-Reply-To: <3BD74E4C.8A9BB52C@gmx.net>
Message-ID: <Pine.GSO.4.33.0110251722280.6752-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Oct 2001, Mike wrote:
>So now my question is: what exactly should I comment out? One? Both? In
>_all_ sources?

The file containing all the MCE "garbage" is called bluesmoke.c.  It should
be obvious how to disable it upon inspection of the file.

As others have stated, "nomce" as a startup option also works.  I forget
when that entered the linus tree.

--Ricky


