Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290122AbSAWVoE>; Wed, 23 Jan 2002 16:44:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290119AbSAWVno>; Wed, 23 Jan 2002 16:43:44 -0500
Received: from mailout11.sul.t-online.com ([194.25.134.85]:3730 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S290122AbSAWVnd>; Wed, 23 Jan 2002 16:43:33 -0500
Content-Type: text/plain; charset=US-ASCII
From: 520047054719-0001@t-online.de (Oliver Neukum)
Reply-To: Oliver.Neukum@lrz.uni-muenchen.de
To: Samuel Maftoul <maftoul@esrf.fr>
Subject: Re: umounting
Date: Wed, 23 Jan 2002 22:42:33 +0100
X-Mailer: KMail [version 1.3.2]
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20020122150703.B13509@pcmaftoul.esrf.fr> <16T6BH-1ZiPWiC@fwd07.sul.t-online.com> <20020123090614.A18262@pcmaftoul.esrf.fr>
In-Reply-To: <20020123090614.A18262@pcmaftoul.esrf.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <16TVAs-0xKiHYC@fwd10.sul.t-online.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 23 January 2002 09:06, Samuel Maftoul wrote:
> On Tue, Jan 22, 2002 at 08:01:44PM +0100, Oliver Neukum wrote:
> > > When a second user comes and unmounts a disk, then the data are flushed
> > > (the old data) and he gets a fs corruption, because the data were not
> > > from his disk.
> >
> > No. The sbp2 driver should report a disk change. If such a thing happens,
>
> According to my log, sbp2 has an event, It does see the new disk as I
> can mount it ( something bizarre: The first disk I plug, the sbp2 driver
> tells me the vendor and model of the disk, but all other disk won't tell
> me anything until I realod sbp2 module ( I think reloading is ok but not
> tested

Do you use some kind of hotplugging script ?

	Regards
		Oliver
