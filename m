Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262821AbUKXTvf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262821AbUKXTvf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 14:51:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262823AbUKXTvf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 14:51:35 -0500
Received: from lucidpixels.com ([66.45.37.187]:26773 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id S262821AbUKXTvU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 14:51:20 -0500
Date: Wed, 24 Nov 2004 14:51:16 -0500 (EST)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p500
To: Jeff Garzik <jgarzik@pobox.com>
cc: Jan-Benedict Glaw <jbglaw@lug-owl.de>, linux-kernel@vger.kernel.org
Subject: Re: tulip question: tulip.o vs de4x5.o
In-Reply-To: <41A4DF61.8050008@pobox.com>
Message-ID: <Pine.LNX.4.61.0411241451070.19627@p500>
References: <Pine.LNX.4.61.0411231216470.3740@p500> <20041124073628.GJ2067@lug-owl.de>
 <41A4DF61.8050008@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for all the feedback, I am using the tulip driver, it seems to be 
working well.

On Wed, 24 Nov 2004, Jeff Garzik wrote:

> Jan-Benedict Glaw wrote:
>> On Tue, 2004-11-23 12:28:54 -0500, Justin Piszcz <jpiszcz@lucidpixels.com>
>> wrote in message <Pine.LNX.4.61.0411231216470.3740@p500>:
>> 
>>> Each driver works, I have not benchmarked performance with one over the 
>>> other with ttcp yet; however, does anyone have any experience with using 
>>> one over the other? I see the tulip has several options and the de4x5 
>>> seems to be a rather generic driver.
>> 
>> 
>> The de4x5 driver supports some older revisions of the tulip chipset
>> which aren't supported by the tulip driver. I guess it could be made to
>> support those, too, but nobody did that up to now.
>
> Incorrect, the older chips are supported by the de2104x driver.
>
> de4x5 will be going away.
>
>
>> You can actually see the difference on older Alphas: de4x5 works while
>> tulip doesn't transmit or receive a single packet (getting netdev
>> watchdogs later on...).
>
> That's a bug in tulip.
>
> 	Jeff
>
>
>
