Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288855AbSAUWs0>; Mon, 21 Jan 2002 17:48:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288917AbSAUWsT>; Mon, 21 Jan 2002 17:48:19 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:59530 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S288842AbSAUWr1>; Mon, 21 Jan 2002 17:47:27 -0500
Date: Mon, 21 Jan 2002 15:47:11 -0700
Message-Id: <200201212247.g0LMlBU01766@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Jeff Dike <jdike@karaya.com>
Cc: bulb@ucw.cz, linux-kernel@vger.kernel.org
Subject: Re: 2.4.17 OOPS in tty code. 
In-Reply-To: <200201212204.RAA03719@ccure.karaya.com>
In-Reply-To: <20020121151037.A21622@ucw.cz>
	<200201212204.RAA03719@ccure.karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Dike writes:
> bulb@ucw.cz said:
> > Tty device code causes oopses when closing /dev/console and devfs is
> > used. The bug is reproducible on 2.4.17 UML port.
> 
> How do you reproduce it?
> 
> UML config, command line, a backtrace, etc would be nice.

Furthermore, this was done without applying the latest devfs patch
(v199.8 as I write this). Bug reports with old versions of devfs are
(and should be) dropped in the bit-bucket, especially considering
recent devfs patches have ChangeLog entries which talk about fixing
Oopses!

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
