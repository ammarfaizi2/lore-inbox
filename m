Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270734AbTHSPdY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 11:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270716AbTHSPdX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 11:33:23 -0400
Received: from pizda.ninka.net ([216.101.162.242]:48777 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S272375AbTHSPdB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 11:33:01 -0400
Date: Tue, 19 Aug 2003 08:22:27 -0700
From: "David S. Miller" <davem@redhat.com>
To: Ben Greear <greearb@candelatech.com>
Cc: davidsen@tmr.com, willy@w.ods.org, alan@lxorguk.ukuu.org.uk,
       carlosev@newipnet.com, lamont@scriptkiddie.org, bloemsaa@xs4all.nl,
       marcelo@conectiva.com.br, netdev@oss.sgi.com, linux-net@vger.kernel.org,
       layes@loran.com, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
Message-Id: <20030819082227.5ef3b7ed.davem@redhat.com>
In-Reply-To: <3F41979C.3070408@candelatech.com>
References: <Pine.LNX.3.96.1030818171100.2101C-100000@gatekeeper.tmr.com>
	<3F41979C.3070408@candelatech.com>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Aug 2003 20:21:00 -0700
Ben Greear <greearb@candelatech.com> wrote:

> I never did hear a response to my comment that this
> was inadequate in this age of vlans...

Just define a rtnetlink attribute to extend the ID
number, that's all.  It's not hard work and it eliminates
the 8-bit limit.
