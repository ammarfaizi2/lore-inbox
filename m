Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264915AbSK0WsL>; Wed, 27 Nov 2002 17:48:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264931AbSK0WsK>; Wed, 27 Nov 2002 17:48:10 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:59076 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP
	id <S264915AbSK0WsJ>; Wed, 27 Nov 2002 17:48:09 -0500
Date: Wed, 27 Nov 2002 14:59:31 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] Module alias and table support
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Message-id: <3DE54E53.8000005@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
References: <200211272054.MAA07617@baldur.yggdrasil.com>
 <3DE53EF6.4080303@pacbell.net> <20021127142006.A24246@adam.yggdrasil.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam J. Richter wrote:
> On Wed, Nov 27, 2002 at 01:53:58PM -0800, David Brownell wrote:
> 
>>One of the points being that the breakage comes from changing the
>>format supported by modutils.  Restoring current functionality should
>>IMO be high on the agenda .... USB has worked poorly in normal .configs
>>for a while now, because of this.
> 
> 
> 	I posted a patch a couple of days ago to revert 2.5.49/x86 to
> user level modules (no modversions or gplonly symbols in this version
> though).  However, I can't find the patch on marc.theaimsgroup.com, so
> here it is again.

Thanks, but I was hoping for a less radical solution:  just fixing
the "no device table support" bug fixed in the latest modutils ... I
do like the idea of forward motion in the module support, except that's
not what we've seen so far with modutils.

Seems like one of the issues is that there's really no maintainer
for modutils lately.  And I'm not even sure where to get the latest
modutils (more recent than 0.7) even if I were ready to patch them.

- Dave


