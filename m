Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267352AbTACAi0>; Thu, 2 Jan 2003 19:38:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267353AbTACAi0>; Thu, 2 Jan 2003 19:38:26 -0500
Received: from hq.pm.waw.pl ([195.116.170.10]:59848 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id <S267352AbTACAiZ>;
	Thu, 2 Jan 2003 19:38:25 -0500
To: <linux-kernel@vger.kernel.org>
Subject: Re: Unknown error (please help direct it)
References: <20030102152438.GB12769@godzilla.fibrespeed.net>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 02 Jan 2003 23:18:00 +0100
In-Reply-To: <20030102152438.GB12769@godzilla.fibrespeed.net>
Message-ID: <m3lm23urfr.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Michael T. Babcock" <mbabcock@fibrespeed.net> writes:

> I have this in my logs from yesterday, with no clear indication as to
> what subsystem it relates to.  Please help me direct this to the
> appropriate
> persons (and CC me, if possible, in any replies).  There are no kernel
> messages
> for several minutes before or after these lines.
> 
> 13:50:28 vpn kernel:   Flags; bus-master 1, dirty 2677573(5) current 2677
> 13:50:28 vpn kernel:   Transmit list 00000000 vs. c57ad340.
> 13:50:28 vpn kernel:   0: @c57ad200  length 800005ea status 000105ea
> 13:50:28 vpn kernel:   1: @c57ad240  length 800003b2 status 000103b2

[etc]

Looks like network card driver detected something wrong with list of
packets queued for transmission.

What card and kernel is it?
-- 
Krzysztof Halasa
Network Administrator
Happy New Year!
