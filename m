Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132734AbRDNDaS>; Fri, 13 Apr 2001 23:30:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132735AbRDNDaI>; Fri, 13 Apr 2001 23:30:08 -0400
Received: from member.michigannet.com ([207.158.188.18]:30216 "EHLO
	member.michigannet.com") by vger.kernel.org with ESMTP
	id <S132734AbRDNDaD>; Fri, 13 Apr 2001 23:30:03 -0400
Date: Fri, 13 Apr 2001 23:28:55 -0400
From: Paul <set@pobox.com>
To: linux-kernel@vger.kernel.org
Cc: tomlins@cam.org, viro@math.psu.edu
Subject: Re: [PATCH] Re: memory usage - dentry_cacheg
Message-ID: <20010413232855.G219@squish.home.loc>
In-Reply-To: <Pine.GSO.4.21.0104120110210.18135-100000@weyl.math.psu.edu> <20010412114617.051FE723C@oscar.casa.dyndns.org> <0104121730590X.11986@webman>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0104121730590X.11986@webman>; from kowalski@datrix.co.za on Thu, Apr 12, 2001 at 05:30:59PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcin Kowalski <kowalski@datrix.co.za>, on Thu Apr 12, 2001 [05:30:59 PM] said:
> Hi
> 
> I have applied this(Tom's) patch as well as the small change to 
> dcache.c(thanx Andreas, David, Alexander and All), I ran some tests and so 
> far so good, both the dcache and inode cache entries in slabinfo are keeping 
> nice and low even though I tested by creating thousands of files and then 
> deleting then. The dentry and icache both pruged succesfully.
> 

	I applied these patches to 2.4.3-ac5, and it made a world
of difference. I can run kernel compiles, things like 'find /',
and move between desktops running netscape, mutt with 15000
messages threaded, etc. without sloggy delays... eg. previously
netscape used to take a second or so to repaint under this type
of 'load' upon returning to it from a brief visit to another
desktop.
	This is a subjective assesment of my desktop type system,
k6-333 with 64M; 2.4 is much more usable for me now.
	If anyone wants me to run specific tests, I am willing.

Paul
set@pobox.com

