Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261490AbTCZGpm>; Wed, 26 Mar 2003 01:45:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261491AbTCZGpl>; Wed, 26 Mar 2003 01:45:41 -0500
Received: from proxy.povodiodry.cz ([62.77.115.11]:5534 "HELO pc11.op.pod.cz")
	by vger.kernel.org with SMTP id <S261490AbTCZGpl>;
	Wed, 26 Mar 2003 01:45:41 -0500
From: "Vitezslav Samel" <samel@mail.cz>
Date: Wed, 26 Mar 2003 07:56:50 +0100
To: Alan Cox <alan@redhat.com>, Andre Hedrick <andre@linux-ide.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [IDE SiI680] throughput drop to 1/4
Message-ID: <20030326065650.GA10282@pc11.op.pod.cz>
Mail-Followup-To: Alan Cox <alan@redhat.com>,
	Andre Hedrick <andre@linux-ide.org>, linux-kernel@vger.kernel.org
References: <20030324072910.GA16596@pc11.op.pod.cz> <Pine.LNX.4.10.10303240943070.8000-100000@master.linux-ide.org> <20030324072910.GA16596@pc11.op.pod.cz> <200303241213.h2OCD6u21467@devserv.devel.redhat.com> <20030325070605.GA26860@pc11.op.pod.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030325070605.GA26860@pc11.op.pod.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 25, 2003 at 08:06:05AM +0100, Vitezslav Samel wrote:
> On Mon, Mar 24, 2003 at 07:13:06AM -0500, Alan Cox wrote:
> > >   Recently I tried to figure out in 2.5.65, why throughput on my disk which
> > > hangs on Silicon Image 680 dropped to 1/4 compared to 2.4.21-pre5, but didn't
> > > found anything useful. Are there any known issues with this driver?
> > 
> > The same code in both cases. Its quite likely the problem is higher up in
> > the block or filesystem layer. It might also be a general IDE layer bug
> > 
> > What does performance look like on your other disk between
> > 2.4.21pre/2.5.65 ?
> 
>   Will test it as I come back home (it's on my home machine). But I think this
> performance drop is only on the SiI680 interface.

  Tested today: on the other disk on integrated interface (piix) is throughput
exactly the same on both kernels.

	Cheers,
		Vita
