Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262182AbUK0ESi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262182AbUK0ESi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 23:18:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262174AbUK0D7Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 22:59:24 -0500
Received: from zeus.kernel.org ([204.152.189.113]:42947 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262447AbUKZTan (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:30:43 -0500
Date: Thu, 25 Nov 2004 19:07:25 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Suspend 2 merge: 10/51: Exports for suspend built as modules.
Message-ID: <20041125180725.GB1417@openzaurus.ucw.cz>
References: <1101292194.5805.180.camel@desktop.cunninghams> <1101294252.5805.228.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101294252.5805.228.camel@desktop.cunninghams>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The sys_ functions are exported because a while ago, people suggested I
> use /dev/console to output text that doesn't need to be logged, and I
> also use /dev/splash for the bootsplash support. These functions were

Well, we don't do ascii-art on kernel boot and I do not see why we should do it
on suspend. Distributions will love bootsplash integration, but it should stay as a separate
patch.

See swsusp1... it has percentage printing, and I think it should
be possible to make it look good enough.
	
Why do you need sys_mkdir?

			Pavel

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

