Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263304AbUCNG0y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 01:26:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263306AbUCNG0y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 01:26:54 -0500
Received: from [213.227.237.65] ([213.227.237.65]:45952 "EHLO
	berloga.shadowland") by vger.kernel.org with ESMTP id S263304AbUCNG0x convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 01:26:53 -0500
Subject: Re: possible kernel bug in signal transit.
From: Alex Lyashkov <shadow@psoft.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040313220901.64dcd003.akpm@osdl.org>
References: <1079197336.13835.15.camel@berloga.shadowland>
	 <20040313171856.37b32e52.akpm@osdl.org>
	 <1079239159.8186.24.camel@berloga.shadowland>
	 <20040313210051.6b4a2846.akpm@osdl.org>
	 <1079241668.8186.33.camel@berloga.shadowland>
	 <20040313214700.387c4ff3.akpm@osdl.org>
	 <1079243761.8186.46.camel@berloga.shadowland>
	 <20040313220901.64dcd003.akpm@osdl.org>
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 8BIT
Organization: PSoft
Message-Id: <1079245606.8186.51.camel@berloga.shadowland>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-1) 
Date: Sun, 14 Mar 2004 08:26:47 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

В Вск, 14.03.2004, в 08:09, Andrew Morton пишет:
> Alex Lyashkov <shadow@psoft.net> wrote:
> >
> > > Well we can only return one error code.  Or are you suggesting that we
> >  > should terminate the loop early on error?  If so, why?
> >  You say me can return _last_ error core. but this function return
> >  _first_. 
> 
> It doesn't matter, really.  Other parts of the kernel will generally return
> the first-encountered error because at times it _does_ matter.  But here it
> doesn't.
okey. second question.
a really need extra variable instead change conditions in return ?


-- 
Alex Lyashkov <shadow@psoft.net>
PSoft
