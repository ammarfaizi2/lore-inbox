Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315374AbSIJUfy>; Tue, 10 Sep 2002 16:35:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316768AbSIJUfy>; Tue, 10 Sep 2002 16:35:54 -0400
Received: from angband.namesys.com ([212.16.7.85]:55941 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S315374AbSIJUfx>; Tue, 10 Sep 2002 16:35:53 -0400
Date: Wed, 11 Sep 2002 00:40:36 +0400
From: Oleg Drokin <green@namesys.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Hans Reiser <reiser@namesys.com>, linux-kernel@vger.kernel.org
Subject: Re: [BK] ReiserFS changesets for 2.4 (performs writes more than 4k at a time)
Message-ID: <20020911004036.A3137@namesys.com>
References: <20020910190950.A1064@namesys.com> <Pine.LNX.4.44.0209101504590.16518-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209101504590.16518-100000@freak.distro.conectiva>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Tue, Sep 10, 2002 at 03:16:51PM -0300, Marcelo Tosatti wrote:

> 
> Huh, now that I released -pre6 _with_ this stuff by accident its too late.
> Silly me.
> Can you make me a tree which backouts the big write code please?

Can you execute bk cset -x1.594,1.595,1.596
And that will remove our code for now.

Actually you can only do bk cset -x1.594,1.595
So that while our code is gone, stuff that exports VFS functions will stay.

Is this enough for your purposes? (I hope it is).

> Will be releasing a -pre7 shortly due to that.

That's your decision of course.

Bye,
    Oleg
