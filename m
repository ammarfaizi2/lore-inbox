Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964899AbWGHQrl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964899AbWGHQrl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 12:47:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964902AbWGHQrl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 12:47:41 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:56450 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964903AbWGHQrk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 12:47:40 -0400
Subject: Re: [Suspend2-devel] Re: uswsusp history lesson
From: Arjan van de Ven <arjan@infradead.org>
To: Olivier Galibert <galibert@pobox.com>
Cc: Bojan Smojver <bojan@rexursive.com>, Jan Rychter <jan@rychter.com>,
       Pavel Machek <pavel@ucw.cz>, Avuton Olrich <avuton@gmail.com>,
       linux-kernel@vger.kernel.org, suspend2-devel@lists.suspend2.net,
       grundig <grundig@teleline.es>,
       Nigel Cunningham <ncunningham@linuxmail.org>
In-Reply-To: <20060708164312.GA36499@dspnet.fr.eu.org>
References: <20060627133321.GB3019@elf.ucw.cz>
	 <20060707215656.GA30353@dspnet.fr.eu.org>
	 <20060707232523.GC1746@elf.ucw.cz>
	 <200607080933.12372.ncunningham@linuxmail.org>
	 <20060708002826.GD1700@elf.ucw.cz> <m2d5cg1mwy.fsf@tnuctip.rychter.com>
	 <1152353698.2555.11.camel@coyote.rexursive.com>
	 <1152355318.3120.26.camel@laptopd505.fenrus.org>
	 <20060708164312.GA36499@dspnet.fr.eu.org>
Content-Type: text/plain
Date: Sat, 08 Jul 2006 18:47:26 +0200
Message-Id: <1152377246.3120.65.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-07-08 at 18:43 +0200, Olivier Galibert wrote:
> On Sat, Jul 08, 2006 at 12:41:58PM +0200, Arjan van de Ven wrote:
> > Very often, choice is good. but for something this fundamental, it is
> > not. We also don't have 2 scsi layers for example.
> 
> We have 2 ide layers, 2 usb-storage drivers, 2 sound systems and we
> have had 2 pcmcia subsystems and 2 usb subsystems. 

well not sure about all of them... but it sucks.

Just take the alsa/OSS case. It's taken Adrian Bunk a LOT of effort to
get people to report bugs against alsa; unless you threaten to remove
the other driver they just won't and switch to the other driver. On the
one hand, that is choice. On the other, it's BAD. The user experience is
BAD. It means we end up with 2 half arsed cases (since the OSS driver
doesn't do other things) instead of one quite good one.


