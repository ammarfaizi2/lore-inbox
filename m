Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278647AbRJXQiR>; Wed, 24 Oct 2001 12:38:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278643AbRJXQhT>; Wed, 24 Oct 2001 12:37:19 -0400
Received: from etna.trivadis.com ([193.73.126.2]:18680 "EHLO lttit")
	by vger.kernel.org with ESMTP id <S278646AbRJXQgn>;
	Wed, 24 Oct 2001 12:36:43 -0400
Date: Wed, 24 Oct 2001 18:34:26 +0200
From: Tim Tassonis <timtas@cubic.ch>
To: "Mohammad A. Haque" <mhaque@haque.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: fdisk: "File size limit exceeded on fdisk" 2.4.10 to 2.4.13-pre6
In-Reply-To: <Pine.LNX.4.33.0110241226020.5558-100000@viper.haque.net>
In-Reply-To: <E15wQe6-0001wr-00@the-village.bc.nu>
	<Pine.LNX.4.33.0110241226020.5558-100000@viper.haque.net>
X-Mailer: Sylpheed version 0.6.3cvs10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <E15wQz4-0000Hs-00@lttit>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Oct 2001 12:28:05 -0400 (EDT)
"Mohammad A. Haque" <mhaque@haque.net> wrote:

> On Wed, 24 Oct 2001, Alan Cox wrote:
> 
> > > The latter seems to be the case because Vita Samel (hope I got this
right)
> > > just reported that "Booting into 2.4.10-ac10" fixed the problem.
Perhaps
> > > it once was fixed and later defixed?
> >
> > Sounds like it. I'll have a look some point next week to see if I can
see
> > what is up
> 
> I'm able fdisk/mke2fs with 2.4.13-pre6 without the error so long as I
> don't touch the device with hdparm.

Well I do use hdparm -d 1 /dev/hda in init to set dma to 1. I know called
hdparm -d 0 /dev/hda and tried again, but it still fails. Do you mean
hdparm should not touch the device at all and a reboot without the hdparm
-d 1 /dev/hda would do the job? I could live with that for the moment, as
I don't have to repartition my drive very often...

Bye
Tim

> 
> -- 
> 
> =====================================================================
> Mohammad A. Haque                              http://www.haque.net/
>                                                mhaque@haque.net
> 
>   "Alcohol and calculus don't mix.             Developer/Project Lead
>    Don't drink and derive." --Unknown          http://wm.themes.org/
>                                                batmanppc@themes.org
> =====================================================================
> 
