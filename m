Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030274AbWJCQIl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030274AbWJCQIl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 12:08:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030363AbWJCQIl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 12:08:41 -0400
Received: from khc.piap.pl ([195.187.100.11]:43471 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1030274AbWJCQIk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 12:08:40 -0400
To: Ben Greear <greearb@candelatech.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Question on HDLC and raw access to T1/E1 serial streams.
References: <451DC75E.4070403@candelatech.com>
	<m3mz8hntqu.fsf@defiant.localdomain> <451EE973.10907@candelatech.com>
	<m3hcyo2qvs.fsf@defiant.localdomain>
	<45200BD7.6030509@candelatech.com>
	<m3zmcf8z8a.fsf@defiant.localdomain>
	<45213E53.6090507@candelatech.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Tue, 03 Oct 2006 18:08:38 +0200
In-Reply-To: <45213E53.6090507@candelatech.com> (Ben Greear's message of "Mon, 02 Oct 2006 09:29:07 -0700")
Message-ID: <m31wpp756h.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Greear <greearb@candelatech.com> writes:

> I would definitely want the driver/hardware to deal with the byte/bit
> boundaries.  But,
> the user-space read API could be similar to UDP (or HDLC if I
> understand it correctly),

I think so.

> Before I settle on hardware, I'd like to have some idea that the NIC
> can deal with raw
> bit-streams.

I will look at FALC docs. Most (?) sync serial processors can RX/TX
transparent data (though for E3 rates it would be better to have
some hardware support).
-- 
Krzysztof Halasa
