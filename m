Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262850AbUKXUtq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262850AbUKXUtq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 15:49:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262849AbUKXUrh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 15:47:37 -0500
Received: from zeus.kernel.org ([204.152.189.113]:33423 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262848AbUKXUpC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 15:45:02 -0500
Message-ID: <41A4DF61.8050008@pobox.com>
Date: Wed, 24 Nov 2004 14:22:09 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
CC: Justin Piszcz <jpiszcz@lucidpixels.com>, linux-kernel@vger.kernel.org
Subject: Re: tulip question: tulip.o vs de4x5.o
References: <Pine.LNX.4.61.0411231216470.3740@p500> <20041124073628.GJ2067@lug-owl.de>
In-Reply-To: <20041124073628.GJ2067@lug-owl.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan-Benedict Glaw wrote:
> On Tue, 2004-11-23 12:28:54 -0500, Justin Piszcz <jpiszcz@lucidpixels.com>
> wrote in message <Pine.LNX.4.61.0411231216470.3740@p500>:
> 
>>Each driver works, I have not benchmarked performance with one over the 
>>other with ttcp yet; however, does anyone have any experience with using 
>>one over the other? I see the tulip has several options and the de4x5 
>>seems to be a rather generic driver.
> 
> 
> The de4x5 driver supports some older revisions of the tulip chipset
> which aren't supported by the tulip driver. I guess it could be made to
> support those, too, but nobody did that up to now.

Incorrect, the older chips are supported by the de2104x driver.

de4x5 will be going away.


> You can actually see the difference on older Alphas: de4x5 works while
> tulip doesn't transmit or receive a single packet (getting netdev
> watchdogs later on...).

That's a bug in tulip.

	Jeff



