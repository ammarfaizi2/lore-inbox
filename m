Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266931AbRGHRI7>; Sun, 8 Jul 2001 13:08:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266932AbRGHRIt>; Sun, 8 Jul 2001 13:08:49 -0400
Received: from eax.student.umd.edu ([129.2.236.2]:61456 "EHLO
	eax.student.umd.edu") by vger.kernel.org with ESMTP
	id <S266931AbRGHRIj>; Sun, 8 Jul 2001 13:08:39 -0400
Date: Sun, 8 Jul 2001 13:08:37 -0500 (EST)
From: Adam <adam@cfar.umd.edu>
X-X-Sender: <cfar@eax.student.umd.edu>
To: Chris Wedgwood <cw@f00f.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: recvfrom and sockaddr_in.sin_port
In-Reply-To: <20010709050554.B28809@weta.f00f.org>
Message-ID: <Pine.LNX.4.33.0107081307570.936-100000@eax.student.umd.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>     	I have attached a simple program I used for generating those
>     	results.
>
> 'fromlen' needs to be set to sizeof 'from' before the recvfrom syscall

isn't it set? to quote from the example I have attached:

  socklen_t fromlen = sizeof(struct sockaddr_in);



