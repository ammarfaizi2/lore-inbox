Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261442AbUJ3XzW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261442AbUJ3XzW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 19:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261434AbUJ3Xxv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 19:53:51 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:56910 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S261431AbUJ3XwS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 19:52:18 -0400
Subject: Re: pl2303/usb-serial driver problem in 2.4.27-pre6
From: Paul Fulghum <paulkf@microgate.com>
To: Greg KH <greg@kroah.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Oleksiy <Oleksiy@kharkiv.com.ua>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1099150595.6584.6.camel@at2.pipehead.org>
References: <416A6CF8.5050106@kharkiv.com.ua>
	 <20041012171004.GB11750@kroah.com> <20041023180625.GA12113@logos.cnet>
	 <1098572412.5996.6.camel@at2.pipehead.org>
	 <1098576844.5996.27.camel@at2.pipehead.org>
	 <1098908206.2856.17.camel@deimos.microgate.com>
	 <20041030034920.GA1501@kroah.com>
	 <1099150595.6584.6.camel@at2.pipehead.org>
Content-Type: text/plain
Message-Id: <1099180322.6000.35.camel@at2.pipehead.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sat, 30 Oct 2004 18:52:02 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-10-30 at 17:05, Oleksiy wrote: 
> I've tried the patch, it didn't work :( The same problem...
> Also, 2.6.9 works ok ( i haven't tried other 2.6.x kernels)

OK, I'm confused.

You reported that everything works in kernel
versions up to and including 2.4.27-pre5.
It breaks with 2.4.27-pre6.
It works again with 2.6.9

The only changes to pl2303.c between
2.4.27-pre5 and 2.4.27-pre6 are also present in 2.6.9

If all of the above this is correct, then the changes
to pl2303.c have nothing to do with your problem...
and my wonderful little theory is total crap.

Greg KH suggested enabling CONFIG_DEBUG.
Did you try that and get any output?

Thanks,
Paul

-- 
Paul Fulghum
paulkf@microgate.com


