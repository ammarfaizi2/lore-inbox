Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262589AbREVH6t>; Tue, 22 May 2001 03:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262587AbREVH6j>; Tue, 22 May 2001 03:58:39 -0400
Received: from zeus.kernel.org ([209.10.41.242]:62850 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S262595AbREVH6Y>;
	Tue, 22 May 2001 03:58:24 -0400
Message-ID: <3B09FF25.979EF793@namesys.com>
Date: Mon, 21 May 2001 22:54:45 -0700
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: Ricardo Galli <gallir@uib.es>, linux-kernel@vger.kernel.org,
        timothy@monkey.org, Guillem Cantallops Ramis <guillem@cantallops.net>,
        "Yury Yu. Rupasov" <yura@yura.polnet.botik.ru>,
        reiserfs-dev@namesys.com
Subject: Re: [reiserfs-dev] Re: New XFS, ReiserFS and Ext2 benchmarks
In-Reply-To: <LOEGIBFACGNBNCDJMJMOKEADCJAA.gallir@uib.es> <3B09F53E.FE67E795@namesys.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My apologies, I meant that the make is probably compiler bound (I said CPU
bound) not FS bound.

We find that one must use cp and similar utilities (not compilers) to become FS
bound when using a Linux FS (unlike the older Unixes for which compiles were
considered excellent benchmarks).

Hans Reiser wrote:

Hans
> 
> Ricardo Galli wrote:
> >
> > Hi,
> >         you can find at http://bulma.lug.net/static/ a few new benchmarks among
> > Reiser, XFS and Ext2 (also one with JFS).
> >
> > This time there is a comprehensive Hans' Mongo benchmarks
> > (http://bulma.lug.net/static/mongo/ )and a couple of kernel compilations and
> > read/write/fsync operations tests (I was very careful of populating the
> > cache before the measures for the last two cases).
> >
> > Regards,
> >
> > --ricardo
> > http://m3d.uib.es/~gallir/
> 
> These are interesting benchmarks, my only caveats are that make bzImage is
> probably CPU bound not IO bound (the traditional value of compiles as FS
> benchmarks does not apply to Linux filesystems, as they don't do the misdesigned
> synchronization policy of older Unices, and compiles are CPU bound for them in
> my experience), that I don't understand fully why we are so much faster at the
> cp -ar, and I would like Yura to try to reproduce the cp -ar as it seems too
> good to be true.
> 
> Thanks for investing the time into this Ricardo.
> 
> Hans
