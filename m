Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266903AbUHaGxb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266903AbUHaGxb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 02:53:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266885AbUHaGxa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 02:53:30 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:13466 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S266905AbUHaGwo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 02:52:44 -0400
X-Comment: AT&T Maillennium special handling code - c
Message-ID: <41341F08.7050401@namesys.com>
Date: Mon, 30 Aug 2004 23:47:36 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Masover <ninja@slaphack.com>
CC: flx@msu.ru, Rik van Riel <riel@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>, Diego Calleja <diegocg@teleline.es>,
       jamie@shareable.org, christophe@saout.de,
       vda@port.imtp.ilyichevsk.odessa.ua, christer@weinigel.se,
       spam@tnonline.net, akpm@osdl.org, wichert@wiggy.net, jra@samba.org,
       hch@lst.de, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
References: <Pine.LNX.4.44.0408271043090.10272-100000@chimarrao.boston.redhat.com> <412F7D63.4000109@namesys.com> <20040829150041.GD9471@alias> <4133CA74.6070906@slaphack.com>
In-Reply-To: <4133CA74.6070906@slaphack.com>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Masover wrote:

>
>
> And I did mention before about how it'd be nice for it to be an fs 
> chunk...

Please define fs chunk. My mind has an open door.;-)

>
> Imagine 5000 tiny little files that, by the time reiser's done with
> them, fit inside 5 blocks or so. It's insanely cheaper to copy the five
> blocks than to tar them up. It also means that we don't have to worry
> about supporting tar on other platforms -- if they don't have reiser4,
> they need a separate converter. If apps are going to use reiser4
> metadata for anything significant, they probably would link against some
> sort of userland implementation of reiser4 as a Windows library, say, to
> access the files elsewhere.
>
> That's extreme, but you get the idea.

