Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261889AbVASUrX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261889AbVASUrX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 15:47:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261888AbVASUrX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 15:47:23 -0500
Received: from rproxy.gmail.com ([64.233.170.194]:4638 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261889AbVASUrN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 15:47:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=iLZ08p8ZzUm5F6mxhMtodwFth9Dk/N9bPxn6WWGvTOjd5P7PhJ5tvhJU3VaYPNgQrt+CGA5lkfxd1BAfUejOrmZnk2vg69NSOmbg+kwMABouk4yZ1hdxpOLhAmJmnn1EP3omj3GxeliEJDsiUEvQquydsEdzLWWDTx5EsP5+KWs=
Date: Wed, 19 Jan 2005 21:47:10 +0100
From: Diego Calleja <diegocg@gmail.com>
To: John Richard Moser <nigelenki@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: thoughts on kernel security issues
Message-Id: <20050119214710.5c0797cf.diegocg@gmail.com>
In-Reply-To: <41EEBF15.9050700@comcast.net>
References: <20050112205350.GM24518@redhat.com>
	<Pine.LNX.4.58.0501121750470.2310@ppc970.osdl.org>
	<20050112182838.2aa7eec2.akpm@osdl.org>
	<20050113033542.GC1212@redhat.com>
	<Pine.LNX.4.58.0501122025140.2310@ppc970.osdl.org>
	<20050113082320.GB18685@infradead.org>
	<Pine.LNX.4.58.0501130822280.2310@ppc970.osdl.org>
	<1105635662.6031.35.camel@laptopd505.fenrus.org>
	<Pine.LNX.4.58.0501130909270.2310@ppc970.osdl.org>
	<41E6BE6B.6050400@comcast.net>
	<20050119103020.GA4417@elte.hu>
	<41EE96E7.3000004@comcast.net>
	<1106157152.6310.171.camel@laptopd505.fenrus.org>
	<41EEABEF.5000503@comcast.net>
	<200501191947.j0JJlf3j024206@turing-police.cc.vt.edu>
	<41EEBF15.9050700@comcast.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[trimming of cc list since this has nothing to see with the thread]

El Wed, 19 Jan 2005 15:12:05 -0500 John Richard Moser <nigelenki@comcast.net> escribió:

> so you want 90-200 split out patches for GrSecurity?

Documentation/SubmittingPatches.txt is all you need to read.

There has been a lot of good projects that have failed just because they sat
around saying "my stuff is better" without caring about how to merge it or
without listening other kernel developers. Then someone reimplemented it
better and submitted it in a way it could be handled, and listened to other
developers, and it got in the kernel and everybody helped to make it better
than the first alternative. Kbuild is a good examle of this

So, if you want to have have PAX or grsecurity in the kernel, you probably
should submit patches (in the way described in SubmittingPatches.txt) and if
everybody agrees that it's better and you listen other developers and make
changes accordingly and you don't say "$SOMEPERSON is just a scheduler
developer" perhaps it'll be merged. Of course that's more difficult since
people has already cared about doing all that work with ES and it's already
working OK for thousand of people.
