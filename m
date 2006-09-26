Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932220AbWIZR4k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932220AbWIZR4k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 13:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932224AbWIZR4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 13:56:30 -0400
Received: from ns2.uludag.org.tr ([193.140.100.220]:54491 "EHLO uludag.org.tr")
	by vger.kernel.org with ESMTP id S932225AbWIZR4L convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 13:56:11 -0400
From: Ismail Donmez <ismail@pardus.org.tr>
Organization: =?utf-8?q?T=C3=9CB=C4=B0TAK/UEKAE?=
To: Stelian Pop <stelian@popies.net>
Subject: Re: sonypc with Sony Vaio VGN-SZ1VP
Date: Tue, 26 Sep 2006 20:56:31 +0300
User-Agent: KMail/1.9.4
Cc: Andrea Gelmini <gelma@gelma.net>, linux-kernel@vger.kernel.org
References: <20060926135659.GA3685@jnb.gelma.net> <45195583.4090500@popies.net>
In-Reply-To: <45195583.4090500@popies.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200609262056.32052.ismail@pardus.org.tr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

26 Eyl 2006 Sal 19:29 tarihinde şunları yazmıştınız:
> Andrea Gelmini a écrit :
> > Hi,
> > 	I've got a Sony Vaio VGN-SZ1VP (dmidecode[1] and lspci[2]).
> > 	Using default kernel (linux-image-2.6.15-27-686) of Ubuntu
> > 	Dapper I've got /proc/acpi/sony/brightness and it works well
> > 	(yes, Ubuntu drivers/char/sonypi.c is patched).
> > 	With any other newer vanilla kernel, 2.6.15/16/17/18, /proc/acpi/sony
> > 	doesn't appear, and it's impossibile to set brigthness, of
> > 	course. Same thing with Ubuntu kernel package
> > 	(linux-image-2.6.17-9-386).
> > 	I tried to port Ubuntu sonypi.c patches to 2.6.18, but it doesn't
> > 	work (I mean, it compiles clean, it "modprobes"[3] clean, but no
> > 	/proc/acpi/sony/ directory).
>
> /proc/acpi/sony comes from the sony_acpi driver, not sonypi.
>
> You should get the latest sony_acpi driver, preferably from the -mm tree
> which hosts the most up to date version.

Will sony_acpi ever make it to the mainline? Its very useful for new Vaio 
models.

-- 
They that can give up essential liberty to obtain a little temporary safety 
deserve neither liberty nor safety.
-- Benjamin Franklin
