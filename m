Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317316AbSGIGfD>; Tue, 9 Jul 2002 02:35:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317318AbSGIGfC>; Tue, 9 Jul 2002 02:35:02 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:43020 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317316AbSGIGfB>;
	Tue, 9 Jul 2002 02:35:01 -0400
Message-ID: <3D2A863D.DC0AF866@zip.com.au>
Date: Mon, 08 Jul 2002 23:44:13 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: Matthew Wilcox <willy@debian.org>, linux-kernel@vger.kernel.org
Subject: Re: readprofile from 2.5.25 web server benchmark
References: <3D2A8152.7040200@us.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:
> 
> ...
> and some which help this too: (akpm's smptimers and some smart
> updating logic)
>     5822 mod_timer                                 24.2583

Ingo's smptimers.  akpm's "don't mod the timer if it won't change
anything" tweak.

I'd be interested in the effect of the latter.  It's very 2.4-able.

-
