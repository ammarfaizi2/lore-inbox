Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284090AbRLWT27>; Sun, 23 Dec 2001 14:28:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284010AbRLWT2t>; Sun, 23 Dec 2001 14:28:49 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:51973 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S284073AbRLWT2g>; Sun, 23 Dec 2001 14:28:36 -0500
Message-ID: <3C26304B.3090205@zytor.com>
Date: Sun, 23 Dec 2001 11:28:11 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: tar vs cpio (was: Booting a modular kernel through a multiple streams file)
In-Reply-To: <Pine.GSO.4.21.0112230849550.23300-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
 >

> I doubt that extra utilities are worth the effort.  Said that, layout
> of the damn thing is nowhere near the top of the list of things that
> worry me - as long as it's well-defined, can be handled from userland
> and can be easily unpacked I'm OK with it.

   [...]

> 
> Frankly, holy wars over layout of archive look rather pointless.  _That_
> is trivial to change at any point until the moment when it hits the main
> tree.  Getting late-boot code clean is the real problem.

 >

Agreed, of course.  I just happen to be approaching this from this end, 
with considering what kind of boot loader changes are desirable.

	-hpa


P.S. As far as the umsdos pivot thing is concerned, I always considered 
it to be a bug that it was only applicable to the root.  I would like to 
suggest making it a mount option instead.




