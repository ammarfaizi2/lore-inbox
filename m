Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932394AbWGDUhH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932394AbWGDUhH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 16:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932377AbWGDUhH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 16:37:07 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:15534 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S932394AbWGDUhF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 16:37:05 -0400
Date: Tue, 4 Jul 2006 17:36:52 -0300
From: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: paulkf@microgate.com, gregkh@suse.de, rmk+lkml@arm.linux.org.uk,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: Serial-Core: USB-Serial port current issues.
Message-ID: <20060704173652.7d0a9d47@doriath.conectiva>
In-Reply-To: <20060704125046.40ebb52d.zaitcev@redhat.com>
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
	<20060704125046.40ebb52d.zaitcev@redhat.com>
Organization: Mandriva
X-Mailer: Sylpheed-Claws 2.4.0-rc2 (GTK+ 2.9.4; i586-mandriva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jul 2006 12:50:46 -0700
Pete Zaitcev <zaitcev@redhat.com> wrote:

| On Tue, 4 Jul 2006 16:42:57 -0300, "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br> wrote:
| 
| >  Note that get_mctrl() is a callback and the driver is free to call
| > _its_ get_mctrl() from IRQ if it wants to.
| 
| What do you think "a callback" is? The get_mctrl may be a method,
| but it's certainly not a callback. A callback is something being
| called from bottom to the the top, e.g. (*urb->complete)().

 I thought Paul was referring to the driver's *callback* function, but
now I just realized that he was referring to the Serial Core's get_mctrl()
method.

 Then his comment makes sense.

-- 
Luiz Fernando N. Capitulino
