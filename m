Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264403AbTEPKYH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 06:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264404AbTEPKYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 06:24:07 -0400
Received: from pa186.opole.sdi.tpnet.pl ([213.76.204.186]:55288 "EHLO
	uran.deimos.one.pl") by vger.kernel.org with ESMTP id S264403AbTEPKYG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 06:24:06 -0400
Date: Fri, 16 May 2003 12:36:51 +0200
From: Damian =?iso-8859-2?Q?Ko=B3kowski?= <deimos@deimos.one.pl>
To: np <np@ipc-fabautomation.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Radeon 9600TX.
Message-ID: <20030516103651.GA2858@deimos.one.pl>
References: <3EC4A9BD.1C9E2802@ipc-fabautomation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3EC4A9BD.1C9E2802@ipc-fabautomation.com>
User-Agent: Mutt/1.4.1i
X-Age: 23 (1980.09.27 - libra)
X-Girl: 1 will be enough!
X-GG: 88988
X-ICQ: 59367544
X-JID: deimos@jabber.gda.pl
X-Operating-System: Slackware GNU/Linux, kernel 2.4.21-rc2-ac1, up  3:06
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 16, 2003 at 11:05:01AM +0200, np wrote:
>   I have an Radeon 9600TX vidoe board from ATI but I did not find any
> Linux drivers for it. Do any of you have any ideea if this is under
> development or if it is already available ( when yes , in what kernel )?

Maby you simply add your chipset in driver, just like that:
http://deimos.one.pl/ftp/radeonfb/old/radeonfb-rv250if-2.4.20-ac2-1.patch

Use this:
lspci -v | grep ATI

And check of what _radeon_arch_ is it, then tray to add your radeon chip.

-- 
# Damian *dEiMoS* Ko³kowski # http://deimos.one.pl/ #
