Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266064AbTLIQsb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 11:48:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266066AbTLIQsb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 11:48:31 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:62954
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S266064AbTLIQs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 11:48:27 -0500
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Greg KH <greg@kroah.com>, Andreas Jellinghaus <aj@dungeon.inka.de>
Subject: Re: State of devfs in 2.6?
Date: Mon, 8 Dec 2003 23:26:17 -0600
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200312081536.26022.andrew@walrond.org> <pan.2003.12.08.23.04.07.111640@dungeon.inka.de> <20031208233428.GA31370@kroah.com>
In-Reply-To: <20031208233428.GA31370@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312082326.17723.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 08 December 2003 17:34, Greg KH wrote:

> >  - 5 input/ devices
>
> Patch for sysfs support for this has been posted by Hanna Linder.  It
> still needs work before being added to the kernel tree.
>
> >  - full, kmem, kmsg, mem, null, port, random, urandom, zero
>
> Patch for this has been posted by me to lkml in the past.  It will
> probably go into 2.6.1
>
> >  - printers/0
>
> Hanna Linder is working on a patch for these devices.
>
> >  - 5 misc/ devices
>
> Patch for this has been posted by me to lkml in the past.  It will
> probably go into 2.6.1.
>
> >  - 12 snd/ devices
> >  - 5 sound/ devices
>
> I have a patch here from Leann Ogasawara that adds sysfs support for
> these devices.  I've been lacking time to test it better, but again, it
> will probably make it into 2.6.1.

Is there a big rollup patch against that adds all the sys/*/dev entries for 
people who want to try udev?

Rob


