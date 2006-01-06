Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964826AbWAFSYu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964826AbWAFSYu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 13:24:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964820AbWAFSYt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 13:24:49 -0500
Received: from smtp.osdl.org ([65.172.181.4]:25230 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964824AbWAFSYq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 13:24:46 -0500
Date: Fri, 6 Jan 2006 10:23:53 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Patrick McHardy <kaber@trash.net>
Cc: Marcel Holtmann <marcel@holtmann.org>, Michael Buesch <mbuesch@freenet.de>,
       jgarzik@pobox.com, bcm43xx-dev@lists.berlios.de, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Bcm43xx-dev] [Fwd: State of the Union: Wireless]
Message-ID: <20060106102353.68d5f7ea@dxpl.pdx.osdl.net>
In-Reply-To: <43BE6697.3030009@trash.net>
References: <1136541243.4037.18.camel@localhost>
	<200601061200.59376.mbuesch@freenet.de>
	<1136547494.7429.72.camel@localhost>
	<200601061245.55978.mbuesch@freenet.de>
	<1136549423.7429.88.camel@localhost>
	<43BE6697.3030009@trash.net>
X-Mailer: Sylpheed-Claws 1.9.100 (GTK+ 2.6.10; x86_64-redhat-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 06 Jan 2006 13:46:15 +0100
Patrick McHardy <kaber@trash.net> wrote:

> Marcel Holtmann wrote:
> 
> >>I just personally liked the idea of having a device node in /dev for
> >>every existing hardware wlan card. Like we have device nodes for
> >>other real hardware, too. It felt like a bit of a "unix way" to do
> >>this to me. I don't say this is the way to go.
> >>If a netlink socket is used (which is possible, for sure), we stay with
> >>the old way of having no device node in /dev for networking devices.
> >>That is ok. But that is really only an implementation detail (and for sure
> >>a matter of taste).
> > 
> > 
> > At the OLS last year, I think the consensus was to use netlink for all
> > configuration task. However this was mainly driven by Harald Welte and
> > he might be able to talk about the pros and cons of netlink versus a
> > character device.
> 
> I think the main advantages of netlink over a character device is its
> flexible format, which is easily extendable, and multicast capability,
> which can be used to broadcast events and configuration changes. Its
> also good to have all the net stuff accessible in a uniform way.

Also netlink doesn't have the naming issues that /dev node would.

-- 
Stephen Hemminger <shemminger@osdl.org>
OSDL http://developer.osdl.org/~shemminger
