Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262835AbRE3WBK>; Wed, 30 May 2001 18:01:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262834AbRE3WBA>; Wed, 30 May 2001 18:01:00 -0400
Received: from coruscant.franken.de ([193.174.159.226]:39441 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id <S262832AbRE3WAv>; Wed, 30 May 2001 18:00:51 -0400
Date: Wed, 30 May 2001 18:55:42 -0300
From: Harald Welte <laforge@gnumonks.org>
To: "Eric S. Raymond" <esr@thyrsus.com>, CML2 <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
Subject: Re: Remaining undocumented Configure.help symbols
Message-ID: <20010530185542.R14293@corellia.laforge.distro.conectiva>
In-Reply-To: <20010529145940.A11498@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <20010529145940.A11498@thyrsus.com>; from esr@thyrsus.com on Tue, May 29, 2001 at 02:59:40PM -0400
X-Operating-System: Linux corellia.laforge.distro.conectiva 2.4.3
X-Date: Today is Pungenday, the 2nd day of Confusion in the YOLD 3167
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2001 at 02:59:40PM -0400, Eric S. Raymond wrote:

> CONFIG_NET_CLS_TCINDEX

  If you say Y here, you will be able to classify outgoing packets 
  according to the tc_index field of the skb. You will want this 
  feature if you want to implement Differentiates Services useing
  sch_dsmark. If unsure, say Y.

  This code is also available as a module called cls_tcindex.o ( = code
  which can be inserted in and removed from the running kernel
  whenever you want). If you want to compile it as a module, say MM
  here and read Documentation/modules.txt

> CONFIG_NET_SCH_INGRESS

  If you say Y here, you will be able to police incoming bandwidth
  and drop packets when this bandwidth exceeds your desired rate.
  If unsure, say Y.

  This code is also available as a module called cls_tcindex.o ( = code
  which can be inserted in and removed from the running kernel
  whenever you want). If you want to compile it as a module, say MM
  here and read Documentation/modules.txt

> As before, if you know enough about any of these configuration options to
> write a help entry, please send it to me.

-- 
Live long and prosper
- Harald Welte / laforge@gnumonks.org               http://www.gnumonks.org/
============================================================================
GCS/E/IT d- s-: a-- C+++ UL++++$ P+++ L++++$ E--- W- N++ o? K- w--- O- M- 
V-- PS+ PE-- Y+ PGP++ t++ 5-- !X !R tv-- b+++ DI? !D G+ e* h+ r% y+(*)
