Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266551AbTGKAKG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 20:10:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266555AbTGKAKG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 20:10:06 -0400
Received: from smtp.terra.es ([213.4.129.129]:32480 "EHLO tsmtp4.mail.isp")
	by vger.kernel.org with ESMTP id S266551AbTGKAKD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 20:10:03 -0400
Date: Fri, 11 Jul 2003 02:24:46 +0200
From: Diego Calleja =?ISO-8859-15?Q?Garc=EDa?= <diegocg@teleline.es>
To: Robert Love <rml@tech9.net>
Cc: felipe_alfaro@linuxmail.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.75
Message-Id: <20030711022446.0ef98986.diegocg@teleline.es>
In-Reply-To: <1057880428.1984.12.camel@localhost>
References: <Pine.LNX.4.44.0307101405490.4560-100000@home.osdl.org>
	<1057879835.584.7.camel@teapot.felipe-alfaro.com>
	<1057880428.1984.12.camel@localhost>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El 10 Jul 2003 16:40:29 -0700 Robert Love <rml@tech9.net> escribió:

> I do not see it as a _huge_ problem, because we are just worrying about
> corner cases now. Worst case we can turn off the interactivity estimator
> - which is both the root of the improvement and the problems - and be
> back to where we are in 2.4.

It used to work fine in the past; now as Felipe said, it's a PITA. Con's
patch helps but it's not even near than what it used to be. My make -j 25
without any skip is now -j3 with Con's patch and some mp3 skips. Perhaps
i should start testing when it stopped "working" (i always save the kernel
images)


Diego Calleja
