Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932071AbWFBNyV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbWFBNyV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 09:54:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932106AbWFBNyV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 09:54:21 -0400
Received: from canuck.infradead.org ([205.233.218.70]:11217 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S932071AbWFBNyV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 09:54:21 -0400
Subject: Re: [PATCH RFC 0/11] usbserial: Serial Core port.
From: David Woodhouse <dwmw2@infradead.org>
To: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
Cc: Pete Zaitcev <zaitcev@redhat.com>, gregkh@suse.de,
       linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk,
       linux-usb-devel@lists.sourceforge.net
In-Reply-To: <20060602104542.061a1842@doriath.conectiva>
References: <1149217397133-git-send-email-lcapitulino@mandriva.com.br>
	 <20060601234833.adf12249.zaitcev@redhat.com>
	 <1149242609.4695.0.camel@pmac.infradead.org>
	 <20060602104542.061a1842@doriath.conectiva>
Content-Type: text/plain
Date: Fri, 02 Jun 2006 14:54:06 +0100
Message-Id: <1149256446.5053.40.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.1.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-06-02 at 10:45 -0300, Luiz Fernando N. Capitulino wrote:
>  Unfortunally my cables only connects devices to the computers
> (ie, I can't connect two computers).
> 
>  Don't know if exists a Prolific USB <-> DB9, but if it does, would
> be good if someone could make the test. Seems easy to do. 

What manner of device does it connect? I'm sure I've seen GSM phones
which seem to be something like pl2302 when you connect to them with
USB... and with a phone, you can dial up to a remote system and use
xmodem.

You also get to test the flow control, since if you're using a 9600 baud
dialup connection and your 'serial' link is faster than that, it'll need
to be throttled.

-- 
dwmw2

