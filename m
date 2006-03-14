Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932307AbWCNE7c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932307AbWCNE7c (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 23:59:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932502AbWCNE7c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 23:59:32 -0500
Received: from nproxy.gmail.com ([64.233.182.197]:47212 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932307AbWCNE7b convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 23:59:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=B9QTnifa3hznRVxg8TMJgOhQIIk3KPAZpGo1BEy7UkjLLnKnkas8e/2AKWJJx5+/U62yfyd8CbAKi97Y8SRYzb4iRTiYb7L8yzln1iO7nPoKmi8ljBnHphRV64m8lqFzW24evud4NsMPfLdhQlTORo/zXn5zoDb3eYHPrBRdlUU=
Message-ID: <40f323d00603132059g352ff3e6ufa2e0755f8a51975@mail.gmail.com>
Date: Tue, 14 Mar 2006 05:59:29 +0100
From: "Benoit Boissinot" <bboissin@gmail.com>
To: "Adrian Bunk" <bunk@stusta.de>
Subject: Re: 2.6.16-rc6: all psmouse regressions fixed?
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
       "Pavlik Vojtech" <vojtech@suse.cz>,
       "Ryan Phillips" <rphillips@gentoo.org>, Duncan <1i5t5.duncan@cox.net>,
       "Meelis Roos" <mroos@linux.ee>
In-Reply-To: <20060313190714.GD13973@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.64.0603111551330.18022@g5.osdl.org>
	 <20060313190714.GD13973@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/13/06, Adrian Bunk <bunk@stusta.de> wrote:
> On Sat, Mar 11, 2006 at 03:58:12PM -0800, Linus Torvalds wrote:
> >...
> > Dmitry Torokhov:
> >       Input: psmouse - disable autoresync
> >...
>
> We had the three psmouse regressions below in 2.6.16-rc5.
>
> Duncan already stated that this patch fixed (more exactly: works around)
> his problems.
>
> Does anyone still observe a psmouse regression in 2.6.16-rc6 compared
> to 2.6.15, or is everything fine now?
>
I didn't test vanilla, but i still have:
psmouse.c: DualPoint TouchPad at isa0060/serio1/input0 lost sync at byte 1
psmouse.c: DualPoint TouchPad at isa0060/serio1/input0 - driver resynched.

in -mm (2.6.16-rc6-mm1).
As I cannot reproduce it at will, it is hard to capture useful debug
info (it usually happens once a day).

regards,

Benoit
