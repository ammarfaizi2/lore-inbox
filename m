Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279658AbRJYAhK>; Wed, 24 Oct 2001 20:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279660AbRJYAhA>; Wed, 24 Oct 2001 20:37:00 -0400
Received: from dclient217-162-121-90.hispeed.ch ([217.162.121.90]:46979 "EHLO
	lttit") by vger.kernel.org with ESMTP id <S279658AbRJYAgw>;
	Wed, 24 Oct 2001 20:36:52 -0400
Date: Thu, 25 Oct 2001 02:34:27 +0200
From: Tim Tassonis <timtas@cubic.ch>
To: "Mohammad A. Haque" <mhaque@haque.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: fdisk: "File size limit exceeded on fdisk" 2.4.10 to 2.4.13-pre6
In-Reply-To: <Pine.LNX.4.33.0110241239230.5558-100000@viper.haque.net>
In-Reply-To: <E15wQz4-0000Hs-00@lttit>
	<Pine.LNX.4.33.0110241239230.5558-100000@viper.haque.net>
X-Mailer: Sylpheed version 0.6.3cvs10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <E15wYTb-0000Po-00@lttit>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Oct 2001 12:42:27 -0400 (EDT)
"Mohammad A. Haque" <mhaque@haque.net> wrote:

> On Wed, 24 Oct 2001, Tim Tassonis wrote:
> 
> > Well I do use hdparm -d 1 /dev/hda in init to set dma to 1. I know
called
> > hdparm -d 0 /dev/hda and tried again, but it still fails. Do you mean
> > hdparm should not touch the device at all and a reboot without the
hdparm
> > -d 1 /dev/hda would do the job? I could live with that for the moment,
as
> > I don't have to repartition my drive very often...
> >
> 
> Woops. hit send too fast.
> 
> You can use hdparm once you've repartitioned though it seems. Still
> won't be able create any files >2GB once you've touched it with hdparm
> again but at least you'll be up and running with whatever size
> partitions you want and have dma enabled. Dunno if that's an issue.

I'm quite suprised, but this actually worked for me. Rebooted without
using hdparm, created the partintion (3GB) and everything seems ok. Looks
as if hdparm is doing something wrong here (v3.6).

Bye
Tim

