Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964773AbWAFWet@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964773AbWAFWet (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 17:34:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964864AbWAFWet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 17:34:49 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:39316 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964851AbWAFWer (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 17:34:47 -0500
Date: Fri, 6 Jan 2006 23:34:24 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Dave Jones <davej@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: oops pauser.
Message-ID: <20060106223424.GA12428@elf.ucw.cz>
References: <20060105045212.GA15789@redhat.com> <1136468254.16358.23.camel@localhost.localdomain> <20060105205221.GN20809@redhat.com> <20060106152203.GA11906@elf.ucw.cz> <Pine.LNX.4.61.0601062006110.28630@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.61.0601062006110.28630@yvahk01.tjqt.qr>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Pá 06-01-06 20:06:36, Jan Engelhardt wrote:
> >No.
> >
> >But you _know_ if user is running X or not -- notice that kernel does
> >not attempt to printk() when X is running, because that could lock up
> >the box.
> >
> >If user is running X, you don't need the delay.
> >
> >if (CON_IS_VISIBLE(vc) && vc->vc_mode == KD_TEXT) {
> 
> Does framebuffer fall under KD_TEXT?

I think so.

-- 
Thanks, Sharp!
