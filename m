Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267850AbRGRJtG>; Wed, 18 Jul 2001 05:49:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267851AbRGRJs4>; Wed, 18 Jul 2001 05:48:56 -0400
Received: from mx02.uni-tuebingen.de ([134.2.3.12]:49932 "EHLO
	mx02.uni-tuebingen.de") by vger.kernel.org with ESMTP
	id <S267850AbRGRJst>; Wed, 18 Jul 2001 05:48:49 -0400
Date: Wed, 18 Jul 2001 11:48:21 +0200 (CEST)
From: Richard Guenther <rguenth@tat.physik.uni-tuebingen.de>
To: "Brian J. Watson" <Brian.J.Watson@compaq.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        schoebel@eicheinformatik.uni-stuttgart.de
Subject: Re: Common hash table implementation
In-Reply-To: <3B54DEF5.B85F57E4@compaq.com>
Message-ID: <Pine.LNX.4.21.0107181145530.3066-100000@bellatrix.tat.physik.uni-tuebingen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Jul 2001, Brian J. Watson wrote:

> A couple of days ago, I was thinking about a common hash table
> implementation, ala include/linux/list.h. Then I came across
> include/linux/ghash.h, and thought that someone's already done it.
> After that I noticed the copyright line said 1997, and a quick check
> in cscope showed that nobody's including it.
> 
> Does anyone know if this file is worth studying and working with? I
> have to wonder if nobody's using it after four years.
> 
> Does anyone see a problem with a common hash table implementation?
> I've implemented a few hash tables from scratch for our clustering
> work, and it's starting to get a little old. Something easy to use
> like list.h would be a lot nicer.

You may look at

http://cvs.sourceforge.net/cgi-bin/viewcvs.cgi/~checkout~/glame/glame/src/include/hash.h?rev=1.5&content-type=text/plain

which is essentially a automatic generator of code for static hash
tables like those from linux/mm/

Richard.

--
Richard Guenther <richard.guenther@uni-tuebingen.de>
WWW: http://www.tat.physik.uni-tuebingen.de/~rguenth/
The GLAME Project: http://www.glame.de/

