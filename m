Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317135AbSFQWsb>; Mon, 17 Jun 2002 18:48:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317139AbSFQWsa>; Mon, 17 Jun 2002 18:48:30 -0400
Received: from admin.nni.com ([216.107.0.51]:59410 "EHLO admin.nni.com")
	by vger.kernel.org with ESMTP id <S317135AbSFQWs2>;
	Mon, 17 Jun 2002 18:48:28 -0400
Date: Mon, 17 Jun 2002 18:46:36 -0400
From: Andrew Rodland <arodland@noln.com>
To: "James Stevenson" <mistral@stev.org>, linux-kernel@vger.kernel.org
Subject: Re: invalidate: busy buffer
Message-Id: <20020617184636.592ba983.arodland@noln.com>
In-Reply-To: <003f01c2164e$2e86c6c0$0501a8c0@Stev.org>
References: <000701c2164c$65630930$0501a8c0@Stev.org>
	<20020617182137.5158103f.arodland@noln.com>
	<003f01c2164e$2e86c6c0$0501a8c0@Stev.org>
X-Mailer: Sylpheed version 0.7.6claws16 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jun 2002 23:27:35 +0100
"James Stevenson" <mistral@stev.org> wrote:

> 
> > Something tried to wipe out all of the caches for some device, but
> > something else was using it at the time. For example, if you try to
> > run parted on something mounted (and bypass/confuse its mountedness
> > check) you'll see this. Were you doing anything like that?
> 
> well i was running a badblocks over a 40GB ide disk i tend to check
> them every few months.
> apart from that everything else was running as non-root.
> but yes some things would have been using the disk there was a copy
> going on at the same time
> around 400MB
> 

badblocks is another one of those apps that will try to flush out as
much cache as it can; it's not much use trying the sectors repeatedly if
it's just going to get cached versions :)
> 
> > > Hi
> > >
> > > does anyone know what these mean ?
> > >
> > > under
> > >
> > > 2.4.19-pre8
> > >
> > > invalidate: busy buffer
> > >
> > > in the dmesg output
> > > got a bunch of these about 15 all together all of a sudden
> 
> 
> 
