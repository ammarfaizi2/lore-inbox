Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964797AbWKGP5t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964797AbWKGP5t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 10:57:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964769AbWKGP5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 10:57:49 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:43689 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964797AbWKGP5s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 10:57:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lCwauUGFT2JmMnBlMGFtWimkfFxGgw8AQKEmxemjofr221mIVrkI2s3gp9E34Rpb/b8YI3ouaDGIipIcfg6qJ1zigefTQQOsQOxZZvhUErycVBLouzhElzAMk7cAcxwkEE/60oIi8xrThk2OPEb02SeuTIHSrS14/do1jq0VucQ=
Message-ID: <610823610611070757o38898dddm90ee66f1f3926d3e@mail.gmail.com>
Date: Tue, 7 Nov 2006 10:57:46 -0500
From: "Andrew Wade" <andrew.j.wade@gmail.com>
Reply-To: ajwade@alumni.uwaterloo.ca
To: "Richardson, Charlotte" <Charlotte.Richardson@stratus.com>
Subject: Re: 2.6.19-rc4-mm2
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "Kimball Murray" <kimball.murray@gmail.com>,
       linux-fbdev-devel@lists.sourceforge.net
In-Reply-To: <1C68BCE03F80CD46A821B5B9C5F2163E01D7A051@EXNA.corp.stratus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1C68BCE03F80CD46A821B5B9C5F2163E01D7A051@EXNA.corp.stratus.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Charlotte,

> (Sorry, I don't know what timezone you're in, but I went home, cooked
> supper, ate supper, did two loads of laundry, slept for about seven
> hours, ate breakfast, did another load of laundry, and voted, and now
> I'm back!)

I'm EST (GMT-5). But the hours I'm online are somewhat erratic.

...
> If I can't repro it with this chip, if you want to mess around with it
> on yours, here's what I think we had to do... I believe the trick was
> to use 16bpp mode as far as what mode you write to the chip, and then
> double all the x coordinate values for things like offset, width, and
> pitch. You would have to do that to the accelerated routines also.

I'd be happy to mess around with the driver, but I won't have much
time to do so until tomorrow. I'll let you know if I find anything,
and of course I'll be happy to test patches.

-ajw
