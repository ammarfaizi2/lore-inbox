Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271224AbTHHBlr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 21:41:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271225AbTHHBlr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 21:41:47 -0400
Received: from [66.212.224.118] ([66.212.224.118]:11282 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S271224AbTHHBlp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 21:41:45 -0400
Date: Thu, 7 Aug 2003 21:29:46 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
X-X-Sender: zwane@montezuma.mastecende.com
To: Stuart Longland <stuartl@longlandclan.hopto.org>
Cc: Linux Lernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Problems with Yamaha opl3sa2 under 2.4.20 and ongoing PCMCIA &
 USB problems on 2.6.0-test2
In-Reply-To: <3F32417D.3090000@longlandclan.hopto.org>
Message-ID: <Pine.LNX.4.53.0308072127590.12875@montezuma.mastecende.com>
References: <3F32417D.3090000@longlandclan.hopto.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Aug 2003, Stuart Longland wrote:

> Under 2.4.20:
> 	Everything works flawlessly, except the sound card (Yamaha OPL3-SAx)
> refuses to work, the opl3sa2 driver does not recognise the card.

Hmm i wonder how that got broken..

> Is it possible to, say, backport the opl3sa2 driver to Linux 2.4.2x?

I'll fix the 2.4 one instead, there are a number of differences in the PnP 
system in 2.5 and 2.4 which would make backporting more work (with more 
likelyhood of bugs being introduced).

Thanks,
	Zwane
-- 
function.linuxpower.ca
