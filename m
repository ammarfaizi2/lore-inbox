Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751395AbVLESO4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751395AbVLESO4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 13:14:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751403AbVLESO4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 13:14:56 -0500
Received: from legolas.otaku42.de ([217.24.0.78]:8596 "EHLO legolas.otaku42.de")
	by vger.kernel.org with ESMTP id S1751395AbVLESOz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 13:14:55 -0500
Subject: Re: Broadcom 43xx first results
From: Michael Renzmann <netdev@nospam.otaku42.de>
Reply-To: netdev@nospam.otaku42.de
To: Jiri Benc <jbenc@suse.cz>
Cc: mbuesch@freenet.de, linux-kernel@vger.kernel.org,
       bcm43xx-dev@lists.berlios.de, NetDev <netdev@vger.kernel.org>
In-Reply-To: <20051205190038.04b7b7c1@griffin.suse.cz>
References: <E1Eiyw4-0003Ab-FW@www1.emo.freenet-rz.de>
	 <20051205190038.04b7b7c1@griffin.suse.cz>
Content-Type: text/plain
Date: Mon, 05 Dec 2005 19:14:03 +0100
Message-Id: <1133806444.4498.35.camel@gimli>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Mon, 2005-12-05 at 19:00 +0100, Jiri Benc wrote:
> Why yet another attempt to write 802.11 stack? Sure, the one currently
> in the kernel is unusable and everybody knows about it. But why not to
> improve code opensourced by Devicescape some time ago instead of
> inventing the wheel again and again?

Or, in case there is some unknown objection to the mentioned code: use
the 802.11 stack that comes along with MadWifi, which provides things
like virtual interfaces (for multiple SSID support on one physical card)
and WPA support.

Although I'm a bit biased towards MadWifi, I'd second your suggestion to
make use of the Devicescape code. The benefit of having a fully-blown
802.11 stack in the kernel that drivers can make use of has been
discussed before, so I won't go into that yet again.

Bye, Mike

