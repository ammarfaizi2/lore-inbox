Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290940AbSASL26>; Sat, 19 Jan 2002 06:28:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290939AbSASL2s>; Sat, 19 Jan 2002 06:28:48 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:40927 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S290938AbSASL2i>;
	Sat, 19 Jan 2002 06:28:38 -0500
Date: Sat, 19 Jan 2002 06:28:36 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Miquel van Smoorenburg <miquels@cistron.nl>
cc: linux-kernel@vger.kernel.org
Subject: Re: rm-ing files with open file descriptors
In-Reply-To: <a2bk6e$t2u$1@ncc1701.cistron.net>
Message-ID: <Pine.GSO.4.21.0201190627310.3523-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 19 Jan 2002, Miquel van Smoorenburg wrote:
 
> This could be hacked around ofcourse in fs/namei.c, so I tried
> it for fun. And indeed, with a minor correction it works:
> 
> % perl flink.pl 
> Success.
> 
> I now have a flink-test2.txt file. That is pretty cool ;)

It's also a security hole.

