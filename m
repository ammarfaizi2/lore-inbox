Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261648AbSIXLa3>; Tue, 24 Sep 2002 07:30:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261650AbSIXLa2>; Tue, 24 Sep 2002 07:30:28 -0400
Received: from angband.namesys.com ([212.16.7.85]:59787 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S261648AbSIXLa1>; Tue, 24 Sep 2002 07:30:27 -0400
Date: Tue, 24 Sep 2002 15:35:40 +0400
From: Oleg Drokin <green@namesys.com>
To: Hans Reiser <reiser@namesys.com>
Cc: Jakob Oestergaard <jakob@unthought.net>, linux-kernel@vger.kernel.org
Subject: Re: ReiserFS buglet
Message-ID: <20020924153540.A25934@namesys.com>
References: <20020924072455.GE2442@unthought.net> <20020924132110.A22362@namesys.com> <20020924092720.GF2442@unthought.net> <20020924134816.A23185@namesys.com> <20020924100338.GH2442@unthought.net> <20020924142521.C23185@namesys.com> <3D904CC2.4080607@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <3D904CC2.4080607@namesys.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Tue, Sep 24, 2002 at 03:30:10PM +0400, Hans Reiser wrote:

> >>It's a question of which errors one wishes to handle, and which you
> >>simply choose to ignore.
> >Yes, that's true. Reiserfs chose to not handle any HW errors, this is even
> >written somewhere in our FAQ.
> No, this is not true.  We handle IO errors.  We do not attempt to handle 

Ok, IO errors is not kind of HW errors I meant.
I meant broken HW that does not behave like it should behave according
to specs (i.e. writing other data than we asked it, damaging memory
content and stuff).

> every imaginable hardware error because no one can.  If your CPU 
> overheats, our code makes no effort to compensate for it.

Bye,
    Oleg
