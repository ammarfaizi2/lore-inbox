Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262813AbRE0Qca>; Sun, 27 May 2001 12:32:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262814AbRE0QcU>; Sun, 27 May 2001 12:32:20 -0400
Received: from unthought.net ([212.97.129.24]:40330 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S262813AbRE0QcJ>;
	Sun, 27 May 2001 12:32:09 -0400
Date: Sun, 27 May 2001 18:32:07 +0200
From: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
To: Jaswinder Singh <jaswinder.singh@3disystems.com>
Cc: stepken@little-idiot.de, linux-kernel@vger.kernel.org
Subject: Re: IDE Performance lack !
Message-ID: <20010527183207.B21206@unthought.net>
Mail-Followup-To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
	Jaswinder Singh <jaswinder.singh@3disystems.com>,
	stepken@little-idiot.de, linux-kernel@vger.kernel.org
In-Reply-To: <01052622193100.01317@linux.zuhause.de> <00a101c0e642$4f0791a0$52a6b3d0@Toshiba>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <00a101c0e642$4f0791a0$52a6b3d0@Toshiba>; from jaswinder.singh@3disystems.com on Sat, May 26, 2001 at 05:16:42PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 26, 2001 at 05:16:42PM -0700, Jaswinder Singh wrote:
> >
> > RedHat 7.1 - IDE IBM 41.1 GIG
> > Update to 2.4.5 -> noticed, that hdparm -t /dev/hda went down from 10
> > MByte/sec to 1.9 MByte/sec
> > Any special Options, beside ide-scsi driver activated ..
> >
> > Anybody noticed the same problem ? Any clues ?
> >
> 
> yes , i am also not happy with IDE performance of Linux . That why i dont
> use Hard disk in my Target machines ;)
> 
> When ever i copy big data (around 400 to 700 MB ) from one partion to
> another my machine do not response at all (i can not work on another shell)
> during data transfer.

The answer for both of you is:

  hdparm -d1 /dev/hd{whatever}

Without DMA enabled, performance is going to suck.  1.9 MB/sec is actually pretty
good without DMA   ;)

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
