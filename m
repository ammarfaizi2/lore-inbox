Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267160AbSKMKXJ>; Wed, 13 Nov 2002 05:23:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267161AbSKMKXI>; Wed, 13 Nov 2002 05:23:08 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:28691 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S267160AbSKMKXI>; Wed, 13 Nov 2002 05:23:08 -0500
Message-Id: <200211131024.gADAObp13940@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: "Theodore Ts'o" <tytso@mit.edu>, Alexander Viro <viro@math.psu.edu>
Subject: Re: [RFC] devfs API
Date: Wed, 13 Nov 2002 13:15:58 -0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <20021112013244.GF1729@mythical.michonline.com> <Pine.GSO.4.21.0211112039430.29617-100000@steklov.math.psu.edu> <20021112080417.GA11660@think.thunk.org>
In-Reply-To: <20021112080417.GA11660@think.thunk.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 November 2002 06:04, Theodore Ts'o wrote:
> On Mon, Nov 11, 2002 at 08:49:22PM -0500, Alexander Viro wrote:
> > The only way I'll use devfs is
> > 	* on a separate testbox devoid of network interfaces
> > 	* with no users
> > 	* with no data - disk periodically populated from image on CD.
> >
> > And that's regardless of that cleanup - fixing the interface
> > doesn't solve the internal races, so...
>
> Hi Al,
>
> It's good that you're trying to clean up the devfs code, but...
>
> How many people are actually using devfs these days?  I don't like it
> myself, and I've had to add a fair amount of hair to fsck's
> mount-by-label/uuid code to deal with interesting cases such as
> kernels where devfs is configured, but not actually mounted (it
> changes what /proc/partitions exports).  So I'm one of those who have
> never looked all that kindly on devfs, which shouldn't come as a
> surprise to most folks.
>
> In any case, if there aren't all that many people using devfs, I can
> think of a really easy way in which we could simplify and clean up
> its API by slimming it down by 100%......

I do use it.
--
vda
