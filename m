Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267474AbRGRBe2>; Tue, 17 Jul 2001 21:34:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267388AbRGRBeS>; Tue, 17 Jul 2001 21:34:18 -0400
Received: from sdsl-208-184-147-195.dsl.sjc.megapath.net ([208.184.147.195]:14960
	"EHLO bitmover.com") by vger.kernel.org with ESMTP
	id <S267474AbRGRBeH>; Tue, 17 Jul 2001 21:34:07 -0400
Date: Tue, 17 Jul 2001 18:34:10 -0700
From: Larry McVoy <lm@bitmover.com>
To: "Brian J. Watson" <Brian.J.Watson@compaq.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        schoebel@eicheinformatik.uni-stuttgart.de
Subject: Re: Common hash table implementation
Message-ID: <20010717183410.S29668@work.bitmover.com>
Mail-Followup-To: "Brian J. Watson" <Brian.J.Watson@compaq.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	schoebel@eicheinformatik.uni-stuttgart.de
In-Reply-To: <3B54DEF5.B85F57E4@compaq.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3B54DEF5.B85F57E4@compaq.com>; from Brian.J.Watson@compaq.com on Tue, Jul 17, 2001 at 05:57:25PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We've got a fairly nice hash table interface in BitKeeper that we'd be 
happy to provide under the GPL.  I've always thought it would be cool
to have it in the kernel, we use it everywhere.

http://bitmover.com:8888//home/bk/bugfixes/src/src/mdbm

will let you browse it.  The general interface is gdbm() like and there
are both file backed and memory backed versions.  It was designed to be
useful in small and large configs, you can get a hash into 128 bytes if
I recall correctly.

On Tue, Jul 17, 2001 at 05:57:25PM -0700, Brian J. Watson wrote:
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
> 
> -- 
> Brian Watson             | "The common people of England... so 
> Linux Kernel Developer   |  jealous of their liberty, but like the 
> Open SSI Clustering Lab  |  common people of most other countries 
> Compaq Computer Corp     |  never rightly considering wherein it 
> Los Angeles, CA          |  consists..."
>                          |      -Adam Smith, Wealth of Nations, 1776
> 
> mailto:Brian.J.Watson@compaq.com
> http://opensource.compaq.com/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
