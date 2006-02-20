Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161125AbWBTUP1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161125AbWBTUP1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 15:15:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161126AbWBTUP1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 15:15:27 -0500
Received: from zproxy.gmail.com ([64.233.162.193]:7667 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161125AbWBTUP0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 15:15:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=E/6BUz64YWLhjsb7mKELrdjRbJmdhW0nGtuasZG7doqKnoZj+/c8AEV5RHNXDzAW6iESmkrI/ZxJnOQRGA15rm2ZNVlKzxh6GXK1IkYd1BXis65ozpt9MBmCgvqTr4vXcYGDq+yA9CiA1lxp76Ov9iCIQ3VSCp2KhXYuojHfeNU=
Message-ID: <d120d5000602201215p61aa676bx21a85adfa7c76816@mail.gmail.com>
Date: Mon, 20 Feb 2006 15:15:25 -0500
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Cc: "Pavel Machek" <pavel@ucw.cz>, "Mark Lord" <lkml@rtr.ca>,
       "Nigel Cunningham" <nigel@suspend2.net>,
       "Matthias Hensler" <matthias@wspse.de>,
       "Sebastian Kgler" <sebas@kde.org>,
       "kernel list" <linux-kernel@vger.kernel.org>, rjw@sisk.pl
In-Reply-To: <1140464704.6722.8.camel@mindpipe>
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
	 <1140464704.6722.8.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/20/06, Lee Revell <rlrevell@joe-job.com> wrote:
> On Mon, 2006-02-20 at 15:54 +0100, Pavel Machek wrote:
> > > I know I am bad for not reporting that earlier but swsusp was
> > working
> > > OK for me till about 3 month ago when I started getting "soft lockup
> > > detected on CPU0" with no useable backtrace 3 times out of 4. I
> > > somehow suspect that having automounted nfs helps it to fail
> > > somehow...
> >
> > Disable soft lockup watchdog :-).
>
> You do know that message is harmless and doesn't actually do anything
> right?  It's just warning you that the kernel allowed something to hog
> the CPU without rescheduling for a LONG time.

Well, if that is harmless I am not sure what you'd call harmful ;) 
because right after this message the box hangs solid and I have to
push and hold power button to power it off and start again.

--
Dmitry
