Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275894AbTHOKff (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 06:35:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275902AbTHOKff
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 06:35:35 -0400
Received: from [66.98.134.43] ([66.98.134.43]:12168 "EHLO shitake.truemesh.com")
	by vger.kernel.org with ESMTP id S275894AbTHOKfb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 06:35:31 -0400
Date: Fri, 15 Aug 2003 11:35:30 +0100
From: Paul Nasrat <pauln@truemesh.com>
To: Milan Roubal <roubm9am@barbora.ms.mff.cuni.cz>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0test3mm2 - Synaptics touchpad problem
Message-ID: <20030815103529.GQ13037@shitake.truemesh.com>
Mail-Followup-To: Paul Nasrat <pauln@truemesh.com>,
	Milan Roubal <roubm9am@barbora.ms.mff.cuni.cz>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <003701c3630f$387a6330$401a71c3@izidor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <003701c3630f$387a6330$401a71c3@izidor>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 15, 2003 at 11:25:47AM +0200, Milan Roubal wrote:
> Hi,
> I have got problem runing Synaptics touchpad on kernel 2.6.0test3mm2.
> When previously booted system was windows XP, than the touchpad is working:
> here is part of working dmesg:

The touchpad driver uses the new event layer.  You either need
userspace which understands it.

http://w1.894.telia.com/~u89404340/touchpad/ for XFree86 driver

The other option is to append, is to disable the extensions from
psmouse by appending

psmouse_noext=1 to your kernel arguments


Paul
