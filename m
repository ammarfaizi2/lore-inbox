Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286263AbSBRVGM>; Mon, 18 Feb 2002 16:06:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287045AbSBRVGG>; Mon, 18 Feb 2002 16:06:06 -0500
Received: from M571P006.dipool.highway.telekom.at ([62.46.61.70]:2215 "HELO
	justp.at") by vger.kernel.org with SMTP id <S286263AbSBRVFs>;
	Mon, 18 Feb 2002 16:05:48 -0500
Subject: Re: khubd zombie
From: Patrik Weiskircher <me@justp.at>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020218204345.GF20284@kroah.com>
In-Reply-To: <1014039193.523.42.camel@dev1lap>
	<20020218181417.GA19992@kroah.com> <1014062182.608.36.camel@pat>
	<20020218200041.GE20284@kroah.com> <1014063390.6649.8.camel@pat> 
	<20020218204345.GF20284@kroah.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 18 Feb 2002 22:05:31 +0100
Message-Id: <1014066331.7083.3.camel@pat>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-02-18 at 21:43, Greg KH wrote:

> > > And what happened to your USB devices when you kill khubd after applying
> > > your patch?
> > 
> > They work as always.
> 
> Try removing a device, or plugging a new one in :)
> 

Without my patch, plugging a new one in doesn't work, after a killall
khubd. with my patch it worked without a single problem. (with ohci,
don't know if that matters.)

I'll do some more tests tomorrow morning. ;)

Thanks for your help so far,
Patrik

