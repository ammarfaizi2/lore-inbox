Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751377AbWFBKDs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751377AbWFBKDs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 06:03:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751369AbWFBKDs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 06:03:48 -0400
Received: from canuck.infradead.org ([205.233.218.70]:52664 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S1751377AbWFBKDr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 06:03:47 -0400
Subject: Re: [PATCH RFC 0/11] usbserial: Serial Core port.
From: David Woodhouse <dwmw2@infradead.org>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>,
       gregkh@suse.de, linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk,
       linux-usb-devel@lists.sourceforge.net
In-Reply-To: <20060601234833.adf12249.zaitcev@redhat.com>
References: <1149217397133-git-send-email-lcapitulino@mandriva.com.br>
	 <20060601234833.adf12249.zaitcev@redhat.com>
Content-Type: text/plain
Date: Fri, 02 Jun 2006 11:03:29 +0100
Message-Id: <1149242609.4695.0.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.1.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-06-01 at 23:48 -0700, Pete Zaitcev wrote:
> 
> >  The tests I've done so far weren't anything serious: as the mobile supports a
> > AT command set, I have used the ones (with minicom) which transfers more data.
> > Of course that I also did module load/unload tests, tried to disconnect the
> > device while it's transfering data and so on.
> 
> Next, it would be nice to test if PPP works, and if getty and shell work
> (with getty driving the USB-to-serial adapter).

xmodem is a good test -- better than PPP because it stresses the
buffering in a way which PPP won't. Log into a remote system, try
sending and receiving files with xmodem.

-- 
dwmw2

