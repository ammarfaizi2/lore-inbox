Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932114AbWFBNpl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932114AbWFBNpl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 09:45:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932113AbWFBNpl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 09:45:41 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:38874 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S932099AbWFBNpk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 09:45:40 -0400
Date: Fri, 2 Jun 2006 10:45:42 -0300
From: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Pete Zaitcev <zaitcev@redhat.com>, gregkh@suse.de,
       linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [PATCH RFC 0/11] usbserial: Serial Core port.
Message-ID: <20060602104542.061a1842@doriath.conectiva>
In-Reply-To: <1149242609.4695.0.camel@pmac.infradead.org>
References: <1149217397133-git-send-email-lcapitulino@mandriva.com.br>
	<20060601234833.adf12249.zaitcev@redhat.com>
	<1149242609.4695.0.camel@pmac.infradead.org>
Organization: Mandriva
X-Mailer: Sylpheed-Claws 2.2.0 (GTK+ 2.8.17; i586-mandriva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 02 Jun 2006 11:03:29 +0100
David Woodhouse <dwmw2@infradead.org> wrote:

| On Thu, 2006-06-01 at 23:48 -0700, Pete Zaitcev wrote:
| > 
| > >  The tests I've done so far weren't anything serious: as the mobile supports a
| > > AT command set, I have used the ones (with minicom) which transfers more data.
| > > Of course that I also did module load/unload tests, tried to disconnect the
| > > device while it's transfering data and so on.
| > 
| > Next, it would be nice to test if PPP works, and if getty and shell work
| > (with getty driving the USB-to-serial adapter).
| 
| xmodem is a good test -- better than PPP because it stresses the
| buffering in a way which PPP won't. Log into a remote system, try
| sending and receiving files with xmodem.

 Unfortunally my cables only connects devices to the computers
(ie, I can't connect two computers).

 Don't know if exists a Prolific USB <-> DB9, but if it does, would
be good if someone could make the test. Seems easy to do.

-- 
Luiz Fernando N. Capitulino
