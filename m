Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265205AbSK1Geo>; Thu, 28 Nov 2002 01:34:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265211AbSK1Gen>; Thu, 28 Nov 2002 01:34:43 -0500
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:9131 "EHLO
	mta6.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S265205AbSK1Gen>; Thu, 28 Nov 2002 01:34:43 -0500
Date: Wed, 27 Nov 2002 22:44:24 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] Module alias and table support
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: "Adam J. Richter" <adam@yggdrasil.com>, greg@kroah.com,
       linux-kernel@vger.kernel.org
Message-id: <3DE5BB48.5090606@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
References: <20021128041136.35CA02C081@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> In message <3DE53EF6.4080303@pacbell.net> you write:
> 
>>One of the points being that the breakage comes from changing the
>>format supported by modutils.  Restoring current functionality should
>>IMO be high on the agenda .... USB has worked poorly in normal .configs
>>for a while now, because of this.
> 
> 
> Absolutely.  I sent the patch to put the USB etc. tables back in
> (merged in .48 IIRC).

Hmm, with 2.5.50 and module-init-tools 0.8a two "modules.*map" files
are created -- but they're empty.  That's with the latest 2.5 modutils

   http://www.kernel.org/pub/linux/kernel/people/rusty/modules/

So that's not quite working yet.  I should clarify that this hasn't
been the only stumbling block for usb in recent kernels ... looks
as if some of the others (like "re-plugging" issues seemingly in
driver model code) may be gone, but this modutils-based regression
is particularly visible.

- Dave


