Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030255AbWBTOlE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030255AbWBTOlE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 09:41:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030257AbWBTOlE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 09:41:04 -0500
Received: from wproxy.gmail.com ([64.233.184.195]:18559 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030255AbWBTOlD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 09:41:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Qqn5VqqNlo8pSiKnSDfgmUnVk6/w3V0mzCS9JUepDsSN2dfFw8BA0kiDdR1wUuHcbJr43e+MmB81IfV1vylakPn2QlW6XcuodRHeok1Ul35lUvgeEiVzN3x0i64HNaTU8MuPuPSWUHBMCmpAAviRUL0ScjI7RKg0kqWz4mag1oE=
Message-ID: <d120d5000602200641i136d9778uf9049355c39451a9@mail.gmail.com>
Date: Mon, 20 Feb 2006 09:41:02 -0500
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: "Pavel Machek" <pavel@ucw.cz>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Cc: "Mark Lord" <lkml@rtr.ca>, "Nigel Cunningham" <nigel@suspend2.net>,
       "Lee Revell" <rlrevell@joe-job.com>,
       "Matthias Hensler" <matthias@wspse.de>,
       "Sebastian Kgler" <sebas@kde.org>,
       "kernel list" <linux-kernel@vger.kernel.org>, rjw@sisk.pl
In-Reply-To: <20060220143041.GB1673@atrey.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060201113710.6320.68289.stgit@localhost.localdomain>
	 <20060220103329.GE21817@kobayashi-maru.wspse.de>
	 <1140434146.3429.17.camel@mindpipe>
	 <200602202124.30560.nigel@suspend2.net>
	 <20060220132333.GB23277@atrey.karlin.mff.cuni.cz>
	 <43F9D0DC.5080302@rtr.ca>
	 <20060220143041.GB1673@atrey.karlin.mff.cuni.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/20/06, Pavel Machek <pavel@ucw.cz> wrote:
> > Pavel Machek wrote:
> > ..
> > >...so yes, it works...
> >
> > About 50% of the time for me.  The rest of the time I just
> > see a complete fresh boot from scratch.  What a pain!
>
> Ouch... strange. Does it work reliably from init=/bin/bash boot? Do
> you see final steps of writing on the screen? Can you submit it to
> bugzilla.kernel.org?
>

I know I am bad for not reporting that earlier but swsusp was working
OK for me till about 3 month ago when I started getting "soft lockup
detected on CPU0" with no useable backtrace 3 times out of 4. I
somehow suspect that having automounted nfs helps it to fail
somehow...

For the record - I never tried swsuspend2 as I am tracking the tip of
Linus's tree and prefre to have the tree clean for my work anyway.

--
Dmitry
