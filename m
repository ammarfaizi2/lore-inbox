Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932496AbVLESZK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932496AbVLESZK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 13:25:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932498AbVLESZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 13:25:10 -0500
Received: from hera.kernel.org ([140.211.167.34]:969 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932496AbVLESZJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 13:25:09 -0500
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: Broadcom 43xx first results
Date: Mon, 5 Dec 2005 10:24:57 -0800
Organization: OSDL
Message-ID: <20051205102457.093b0f32@localhost.localdomain>
References: <E1Eiyw4-0003Ab-FW@www1.emo.freenet-rz.de>
	<20051205190038.04b7b7c1@griffin.suse.cz>
	<1133806444.4498.35.camel@gimli>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1133807098 21696 10.8.0.222 (5 Dec 2005 18:24:58 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Mon, 5 Dec 2005 18:24:58 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 1.9.100 (GTK+ 2.6.10; x86_64-redhat-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 05 Dec 2005 19:14:03 +0100
Michael Renzmann <netdev@nospam.otaku42.de> wrote:

> Hi.
> 
> On Mon, 2005-12-05 at 19:00 +0100, Jiri Benc wrote:
> > Why yet another attempt to write 802.11 stack? Sure, the one currently
> > in the kernel is unusable and everybody knows about it. But why not to
> > improve code opensourced by Devicescape some time ago instead of
> > inventing the wheel again and again?
> 
> Or, in case there is some unknown objection to the mentioned code: use
> the 802.11 stack that comes along with MadWifi, which provides things
> like virtual interfaces (for multiple SSID support on one physical card)
> and WPA support.
> 
> Although I'm a bit biased towards MadWifi, I'd second your suggestion to
> make use of the Devicescape code. The benefit of having a fully-blown
> 802.11 stack in the kernel that drivers can make use of has been
> discussed before, so I won't go into that yet again.
> 

Please use or extend the existing net/ieee80211 stack in 2.6.
The defacto plan is to convert all wifi drivers that need software
support to use that.

-- 
Stephen Hemminger <shemminger@osdl.org>
OSDL http://developer.osdl.org/~shemminger
