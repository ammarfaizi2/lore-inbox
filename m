Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263875AbUE3Nyr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263875AbUE3Nyr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 09:54:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263923AbUE3Nyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 09:54:47 -0400
Received: from quechua.inka.de ([193.197.184.2]:55277 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S263875AbUE3Nyp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 09:54:45 -0400
Date: Sun, 30 May 2004 15:54:45 +0200
From: Eduard Bloch <edi@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: keyboard problem with 2.6.6
Message-ID: <20040530135445.GA7571@zombie.inka.de>
References: <xb7r7t2b3mb.fsf@savona.informatik.uni-freiburg.de> <20040530111847.GA1377@ucw.cz> <xb71xl2b0to.fsf@savona.informatik.uni-freiburg.de> <20040530124353.GB1496@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040530124353.GB1496@ucw.cz>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Moin Vojtech!
Vojtech Pavlik schrieb am Sonntag, den 30. Mai 2004:

> >     Vojtech> Of course, unless you create a device that can use it,
> >     Vojtech> but in that case you can easily write a kernel driver for
> >     Vojtech> it.
> > 
> > How about  the PS/2 mouse  port?  It's not  just for mice.   There ARE
> > implementations using it for other things: touchpad, touchscreen, etc.
> 
> All simulate a mouse. Some have somewhat extended protocols, but those
> protocols are still bound by mouse packet constraints, because the
> controllers tend to do nasty things to the data passing through, like
> merging input from multiple devices together into one stream by summing
> the packets, etc.

Who says that merging (as it is currently done) is the best way to do?
For examle, I wish to create two terminals with my system, using two
monitors (on dual-head video card), two keyboards and two mices. I can
do the first part (X manages it well) but not beeing able to use
different input devices for different users simply SUCKS.
But http://linuxconsole.sourceforge.net/ lets me hope.

Regards,
Eduard.
-- 
Wenn ein Mensch ein Loch sieht, hat er das Bestreben, es auszufüllen.
Dabei fällt er meistens hinein.
		-- Kurt Tucholsky
