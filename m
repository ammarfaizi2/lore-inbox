Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263044AbSJBK7C>; Wed, 2 Oct 2002 06:59:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263045AbSJBK7B>; Wed, 2 Oct 2002 06:59:01 -0400
Received: from tml.hut.fi ([130.233.44.1]:17937 "EHLO tml-gw.tml.hut.fi")
	by vger.kernel.org with ESMTP id <S263044AbSJBK7B> convert rfc822-to-8bit;
	Wed, 2 Oct 2002 06:59:01 -0400
Date: Wed, 2 Oct 2002 14:04:17 +0300
From: Antti Tuominen <ajtuomin@morphine.tml.hut.fi>
To: "YOSHIFUJI Hideaki / =?ISO-8859-1?Q?=1B$B5HF#1QL@=1B(B=22?= <yoshfuji@wide.ad.jp>"@vax.home.local
Cc: pekkas@netcore.fi, davem@redhat.com, kuznet@ms2.inr.ac.ru,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
Subject: Re: [PATCH] Mobile IPv6 for 2.5.40 (request for kernel inclusion)
Message-ID: <20021002110416.GC17010@morphine.tml.hut.fi>
References: <20021002.183113.16291158.yoshfuji@wide.ad.jp> <Pine.LNX.4.44.0210021232110.27910-100000@netcore.fi> <20021002.184418.121132248.yoshfuji@wide.ad.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20021002.184418.121132248.yoshfuji@wide.ad.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2002 at 06:44:18PM +0900, YOSHIFUJI Hideaki / ?$B5HF#1QL@?(B wrote:
> In article <Pine.LNX.4.44.0210021232110.27910-100000@netcore.fi> (at Wed, 2 Oct 2002 12:33:21 +0300 (EEST)), Pekka Savola <pekkas@netcore.fi> says:
> 
> > On Wed, 2 Oct 2002, YOSHIFUJI Hideaki / [iso-2022-jp] 吉藤英明 wrote:
> > > In article <Pine.LNX.4.44.0210021224350.27873-100000@netcore.fi> (at Wed, 2 Oct 2002 12:25:37 +0300 (EEST)), Pekka Savola <pekkas@netcore.fi> says:
> > > 
> > > > I believe MIPL implements an old version of MIPv6 (draft -15 or so).
> > > > 
> > > > Or do you support -18 ?
> > > 
> > > We believe we should do -18, not -15 at all.
> > 
> > Well, www.mipl.mediapoli.com front page at least refers to -15, but you 
> > should know better :-)
> 
> I meant, we should go with -18 (or later).  
> (If the MIPL supports only -15,) -15 is too old.

We do support Draft 18 in our development code (tested last week at
ETSI IPv6 Plugtest and mostly working), but since Draft 15 was the
last implementable draft (no _draft_ issues, compared to large number
of inconcistencies and contradictions in draft 18) and we've had time
to test the code properly, we decided to submit working code over
latest code.

Draft 15 based code is tested and works.  To get Mobile IPv6 in the
kernel we felt that it is more important to have solid, tested code
rather than our latest devel code for the submission.  Of course we
are committed to providing the latest draft revision compliant code
immediately when it's available.  But we don't feel draft 18 is the
answer since draft 19 will soon be out and should address rest of the
126 issues raised about drafts 16, 17 and 18.

If the kernel maintainers feel differently, we are happy to provide
you with our latest code implementing most of draft 18.


Regards,

Antti

-- 
Antti J. Tuominen, Gyldenintie 8A 11, 00200 Helsinki, Finland.
Research assistant, Institute of Digital Communications at HUT
work: ajtuomin@tml.hut.fi; home: tuominen@iki.fi

