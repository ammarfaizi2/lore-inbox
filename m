Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265335AbSKEXOg>; Tue, 5 Nov 2002 18:14:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265336AbSKEXOg>; Tue, 5 Nov 2002 18:14:36 -0500
Received: from paloma15.e0k.nbg-hannover.de ([62.181.130.15]:4806 "HELO
	paloma15.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S265335AbSKEXOb> convert rfc822-to-8bit; Tue, 5 Nov 2002 18:14:31 -0500
From: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Chris Mason <mason@suse.com>
Subject: Re: 2.5.46: SCSI and/or ReiserFS v3.6 broken? Kernel panic
Date: Wed, 6 Nov 2002 00:21:01 +0100
User-Agent: KMail/1.4.7
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
References: <200211060006.10425.Dieter.Nuetzel@hamburg.de> <1036537937.24354.337.camel@tiny>
In-Reply-To: <1036537937.24354.337.camel@tiny>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200211060021.01178.Dieter.Nuetzel@hamburg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 6. November 2002 00:12 schrieb Chris Mason:
> On Tue, 2002-11-05 at 18:06, Dieter Nützel wrote:
> > VFS: Cannot open root device "803" or 08:03
> > Please append a correct "root=" boot option
> > Kernel panic: VFS: unable to mount root fs on 08:03
> >
> > With and without HugeTLB file system support.
> > With and without ACPI, APIC.
> >
> > Worked all the time before.
>
> Is aic7xxx still in your config?  I'm using 2.5.45 here without
> problems.

As always.
2.5.45 and before are running fine;-(

CONFIG_SCSI_AIC7XXX=y
CONFIG_AIC7XXX_CMDS_PER_DEVICE=253
CONFIG_AIC7XXX_RESET_DELAY_MS=1500
CONFIG_AIC7XXX_BUILD_FIRMWARE=y

My kernel .config file change only for some little cruft which didn't compile 
for one or the other kernel version.

-Dieter
