Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314403AbSEBNVg>; Thu, 2 May 2002 09:21:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314404AbSEBNVf>; Thu, 2 May 2002 09:21:35 -0400
Received: from h24-68-93-250.vc.shawcable.net ([24.68.93.250]:57984 "EHLO
	me.bcgreen.com") by vger.kernel.org with ESMTP id <S314403AbSEBNVe>;
	Thu, 2 May 2002 09:21:34 -0400
Message-ID: <3CD13D58.7020000@bcgreen.com>
Date: Thu, 02 May 2002 06:21:28 -0700
From: Stephen Samuel <samuel@bcgreen.com>
Organization: Just Another Radical
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0+) Gecko/20020427
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Userspace proglem [Fwd: Re: A CD with errors (scratches etc.) blocks
 the whole system while	reading damadged files]
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xavier Bestel <xavier.bestel@free.fr>
> 
> Le jeu 02/05/2002 à 10:26, Stephen Samuel a écrit :
>> I ran a similar type of test on a 2.4.9.31 (redhat 7.1 ) kernel.
>> With the CD on HDD, I could read off of HDA just peachy while
>> the system was choking on a scratched (aol) cd.
> 
> The "system grinding to a halt" happens to me too, when *ripping*
> scratched cds. Note that it's when using *userspace* access to the block
> device, with e.g. cdparanoia or grip (or dvd ripping tools).
> 
> My DVD drive is on a VT82C693A/694x (ABit VP6).

A very important distinction. I'm not willing to sacrifice any of my
music CDs to the experiment, but if userspace reads are what block the
whole system, that explains why everybody claims that everybody else
is crazy.  All of my tests have been pure kernel-space (fs) accesses,
This is probably why I haven't seen any blockages.

Moral of the story: don't rip scratched CDs on server boxes
(at least -- nut until this is fixed, anyways).

-- 
Stephen Samuel +1(604)876-0426                samuel@bcgreen.com
		   http://www.bcgreen.com/~samuel/
Powerful committed communication, reaching through fear, uncertainty and
doubt to touch the jewel within each person and bring it to life.

