Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030279AbWBTPIj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030279AbWBTPIj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 10:08:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030278AbWBTPIi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 10:08:38 -0500
Received: from wproxy.gmail.com ([64.233.184.201]:16963 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030279AbWBTPIh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 10:08:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MDX/aTjYwk6pUlnD2ReY5AOoAUjSeOv4uoYZw6KD2FsjftXO/PO7svE8juJe99dhGZJWsd7WgxwF9H6IQNllMFg4Jk43/ZEqiSGCvoZHa/JysPslF8KRwc3IVqQAKgrJQJqd3hS14ydwTg8BeZPgD5VTbFQ0X04355U0Pm6VYe0=
Message-ID: <d120d5000602200708n2984fda9j62c3d7ba21b3e8ae@mail.gmail.com>
Date: Mon, 20 Feb 2006 10:08:35 -0500
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: "Pavel Machek" <pavel@ucw.cz>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Cc: "Mark Lord" <lkml@rtr.ca>, "Nigel Cunningham" <nigel@suspend2.net>,
       "Lee Revell" <rlrevell@joe-job.com>,
       "Matthias Hensler" <matthias@wspse.de>,
       "Sebastian Kgler" <sebas@kde.org>,
       "kernel list" <linux-kernel@vger.kernel.org>, rjw@sisk.pl
In-Reply-To: <20060220145405.GD1673@atrey.karlin.mff.cuni.cz>
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
	 <d120d5000602200641i136d9778uf9049355c39451a9@mail.gmail.com>
	 <20060220145405.GD1673@atrey.karlin.mff.cuni.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/20/06, Pavel Machek <pavel@ucw.cz> wrote:
> >
> > I know I am bad for not reporting that earlier but swsusp was working
> > OK for me till about 3 month ago when I started getting "soft lockup
> > detected on CPU0" with no useable backtrace 3 times out of 4. I
> > somehow suspect that having automounted nfs helps it to fail
> > somehow...
>
> Disable soft lockup watchdog :-).

Ok, I will try, but is this the permanent solution you are proposing?

--
Dmitry
