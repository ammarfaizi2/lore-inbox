Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261884AbVBZJw6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261884AbVBZJw6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 04:52:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261889AbVBZJw6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 04:52:58 -0500
Received: from main.gmane.org ([80.91.229.2]:59607 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261884AbVBZJw4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 04:52:56 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giuseppe Bilotta <bilotta78@hotpop.com>
Subject: Re: Re: 2.6.11-rc5
Date: Sat, 26 Feb 2005 10:52:22 +0100
Message-ID: <MPG.1c8a6545592be8d4989714@news.gmane.org>
References: <Pine.LNX.4.58.0502232014190.18997@ppc970.osdl.org> <20050224145049.GA21313@suse.de> <1109287708.15026.25.camel@gaston> <20050225070813.GA13735@suse.de> <1109316551.14993.63.camel@gaston> <20050225172945.GA31211@suse.de> <Pine.LNX.4.56.0502251758370.20213@pentafluge.infradead.org> <20050225202423.GA24282@suse.de> <20050225212157.GA31227@suse.de> <20050225233043.GA16187@suse.de> <1109379664.15026.108.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-ull-8-209.42-151.net24.it
User-Agent: MicroPlanet-Gravity/2.70.2067
X-Gmane-MailScanner: Found to be clean
Cc: linux-fbdev-devel@lists.sourceforge.net
X-Gmane-MailScanner: Found to be clean
X-MailScanner-From: glk-linux-kernel@m.gmane.org
X-MailScanner-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:
> I'm still curious what makes a difference between module and
> built-in.

There seems to be quite some difference between module and 
built-in for framebuffer drivers. Quite some time ago I 
reported a problem with nVidia framebuffer driver making the 
screen go nuts or simply blank (but no lock-up; could still 
blind type). I finally discovered that the problem only 
happened when the driver was compiled as a module.

-- 
Giuseppe "Oblomov" Bilotta

Can't you see
It all makes perfect sense
Expressed in dollar and cents
Pounds shillings and pence
                  (Roger Waters)

