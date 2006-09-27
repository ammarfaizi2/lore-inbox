Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965336AbWI0FOY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965336AbWI0FOY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 01:14:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965335AbWI0FOY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 01:14:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:17055 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965332AbWI0FOX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 01:14:23 -0400
Date: Tue, 26 Sep 2006 22:14:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ismail Donmez <ismail@pardus.org.tr>
Cc: Stelian Pop <stelian@popies.net>, Andrea Gelmini <gelma@gelma.net>,
       linux-kernel@vger.kernel.org, "Brown, Len" <len.brown@intel.com>,
       linux-acpi@vger.kernel.org
Subject: Re: sonypc with Sony Vaio VGN-SZ1VP
Message-Id: <20060926221400.5da1b796.akpm@osdl.org>
In-Reply-To: <200609262056.32052.ismail@pardus.org.tr>
References: <20060926135659.GA3685@jnb.gelma.net>
	<45195583.4090500@popies.net>
	<200609262056.32052.ismail@pardus.org.tr>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Sep 2006 20:56:31 +0300
Ismail Donmez <ismail@pardus.org.tr> wrote:

> 26 Eyl 2006 Sal 19:29 tarihinde şunları yazmıştınız:
> > Andrea Gelmini a écrit :
> > > Hi,
> > > 	I've got a Sony Vaio VGN-SZ1VP (dmidecode[1] and lspci[2]).
> > > 	Using default kernel (linux-image-2.6.15-27-686) of Ubuntu
> > > 	Dapper I've got /proc/acpi/sony/brightness and it works well
> > > 	(yes, Ubuntu drivers/char/sonypi.c is patched).
> > > 	With any other newer vanilla kernel, 2.6.15/16/17/18, /proc/acpi/sony
> > > 	doesn't appear, and it's impossibile to set brigthness, of
> > > 	course. Same thing with Ubuntu kernel package
> > > 	(linux-image-2.6.17-9-386).
> > > 	I tried to port Ubuntu sonypi.c patches to 2.6.18, but it doesn't
> > > 	work (I mean, it compiles clean, it "modprobes"[3] clean, but no
> > > 	/proc/acpi/sony/ directory).
> >
> > /proc/acpi/sony comes from the sony_acpi driver, not sonypi.
> >
> > You should get the latest sony_acpi driver, preferably from the -mm tree
> > which hosts the most up to date version.
> 
> Will sony_acpi ever make it to the mainline? Its very useful for new Vaio 
> models.
> 

I'm inclined to slip it in, but Len has good-sounding reasons for not
merging this sort of driver, and I always forget what they are?

