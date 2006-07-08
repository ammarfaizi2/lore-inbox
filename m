Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964894AbWGHQnQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964894AbWGHQnQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 12:43:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964885AbWGHQnQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 12:43:16 -0400
Received: from dspnet.fr.eu.org ([213.186.44.138]:1808 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S964894AbWGHQnQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 12:43:16 -0400
Date: Sat, 8 Jul 2006 18:43:12 +0200
From: Olivier Galibert <galibert@pobox.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Bojan Smojver <bojan@rexursive.com>, Jan Rychter <jan@rychter.com>,
       Pavel Machek <pavel@ucw.cz>, Avuton Olrich <avuton@gmail.com>,
       linux-kernel@vger.kernel.org, suspend2-devel@lists.suspend2.net,
       grundig <grundig@teleline.es>,
       Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: [Suspend2-devel] Re: uswsusp history lesson
Message-ID: <20060708164312.GA36499@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Arjan van de Ven <arjan@infradead.org>,
	Bojan Smojver <bojan@rexursive.com>, Jan Rychter <jan@rychter.com>,
	Pavel Machek <pavel@ucw.cz>, Avuton Olrich <avuton@gmail.com>,
	linux-kernel@vger.kernel.org, suspend2-devel@lists.suspend2.net,
	grundig <grundig@teleline.es>,
	Nigel Cunningham <ncunningham@linuxmail.org>
References: <20060627133321.GB3019@elf.ucw.cz> <20060707215656.GA30353@dspnet.fr.eu.org> <20060707232523.GC1746@elf.ucw.cz> <200607080933.12372.ncunningham@linuxmail.org> <20060708002826.GD1700@elf.ucw.cz> <m2d5cg1mwy.fsf@tnuctip.rychter.com> <1152353698.2555.11.camel@coyote.rexursive.com> <1152355318.3120.26.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1152355318.3120.26.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 08, 2006 at 12:41:58PM +0200, Arjan van de Ven wrote:
> Very often, choice is good. but for something this fundamental, it is
> not. We also don't have 2 scsi layers for example.

We have 2 ide layers, 2 usb-storage drivers, 2 sound systems and we
have had 2 pcmcia subsystems and 2 usb subsystems.  At one point, it's
the only way to find out what will work out.  Suspend2 and uswsusp
have very different fundamental designs, and it's quite unclear at
that point which one is the right one.


> Including well a defined and portable set of requirements on the kernel
> and drivers, and done such that driver people who don't know the fine
> details, can still get their drivers right.

The polarisation that is going on has resulted in nobody caring about
that, sadly enough.  And in any case it's absolutely demented that
non-disk drivers could have so much of an influence on the stability
of suspend-to-disk.

  OG.
