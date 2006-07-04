Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932333AbWGDTwm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932333AbWGDTwm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 15:52:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932338AbWGDTwm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 15:52:42 -0400
Received: from mx1.redhat.com ([66.187.233.31]:21395 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932333AbWGDTwl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 15:52:41 -0400
Date: Tue, 4 Jul 2006 12:50:46 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
Cc: paulkf@microgate.com, gregkh@suse.de, rmk+lkml@arm.linux.org.uk,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: Serial-Core: USB-Serial port current issues.
Message-Id: <20060704125046.40ebb52d.zaitcev@redhat.com>
In-Reply-To: <20060704164257.03e70301@doriath.conectiva>
References: <20060613192829.3f4b7c34@home.brethil>
	<20060614152809.GA17432@flint.arm.linux.org.uk>
	<20060620161134.20c1316e@doriath.conectiva>
	<20060620193233.15224308.zaitcev@redhat.com>
	<20060621133500.18e82511@doriath.conectiva>
	<20060621164336.GD24265@flint.arm.linux.org.uk>
	<20060621181513.235fc23c@doriath.conectiva>
	<20060622082939.GA25212@flint.arm.linux.org.uk>
	<20060623142842.2b35103b@home.brethil>
	<20060626222628.GC29325@suse.de>
	<1151369349.2600.19.camel@localhost.localdomain>
	<20060704164257.03e70301@doriath.conectiva>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.2.3 (GTK+ 2.8.17; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jul 2006 16:42:57 -0300, "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br> wrote:

>  Note that get_mctrl() is a callback and the driver is free to call
> _its_ get_mctrl() from IRQ if it wants to.

What do you think "a callback" is? The get_mctrl may be a method,
but it's certainly not a callback. A callback is something being
called from bottom to the the top, e.g. (*urb->complete)().

-- Pete
