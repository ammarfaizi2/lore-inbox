Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286935AbSBGJch>; Thu, 7 Feb 2002 04:32:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286934AbSBGJc0>; Thu, 7 Feb 2002 04:32:26 -0500
Received: from angband.namesys.com ([212.16.7.85]:26496 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S286925AbSBGJcS>; Thu, 7 Feb 2002 04:32:18 -0500
Date: Thu, 7 Feb 2002 12:32:17 +0300
From: Oleg Drokin <green@namesys.com>
To: peter <peter.zijlstra@chello.nl>
Cc: reiserfs-dev@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: [reiserfs-dev] Kernel(>2.4.16) BUG with reiserfs.
Message-ID: <20020207123217.B18107@namesys.com>
In-Reply-To: <1013071308.474.39.camel@twins.localnet> <20020207120002.A18107@namesys.com> <1013073645.3013.10.camel@twins.localnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1013073645.3013.10.camel@twins.localnet>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Thu, Feb 07, 2002 at 10:20:45AM +0100, peter wrote:
> > > With all kernels newer than 2.4.16 (eg. that's that last that works for
> > > me), I get a kernel BUG when remounting my rootfs (which is a reiserfs)
> > > for rw access. After the init scripts complete I can log into my machine
> > > but anything calling sync will freeze it hard.
> > Thanks a lot for your report. We were waiting for somebody to get fs in this
> > state (because we cannot reproduce problem locally).
> > How big your root partition is?
> 35 GB ;-)
Yes, that's somewhat big for the mail.

> > > anybody any ideas?
> > Can you please send us image of your root partition, if it is not big,
> > or at least the metadata snapshot.
> > (you can get metadata snapshot by running 
> > debugreiserfs  -p  /dev/xxx  |gzip -c >metadata.gz)
> > You need to make this with filesystem unmounted.
> I'll go hunting for a bootable cd that contains debugreiserfs.
> Where would you like me to send that metadata dump to?
Send it to me.

Bye,
    Oleg
