Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbUCaJQA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 04:16:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261879AbUCaJQA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 04:16:00 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:51410 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261875AbUCaJP4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 04:15:56 -0500
Date: Tue, 30 Mar 2004 22:11:24 +0200
From: Pavel Machek <pavel@suse.cz>
To: Nigel Cunningham <ncunningham@users.sourceforge.net>
Cc: Arkadiusz Miskiewicz <arekm@pld-linux.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Suspend development list <swsusp-devel@lists.sourceforge.net>
Subject: Re: [Swsusp-devel] [PATCH 2.6]: suspend to disk only available if non-modular IDE
Message-ID: <20040330201123.GE3084@openzaurus.ucw.cz>
References: <200403282136.55435.arekm@pld-linux.org> <1080517040.2223.3.camel@laptop-linux.wpcb.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1080517040.2223.3.camel@laptop-linux.wpcb.org.au>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Applied to 2.4 and 2.6.

Bad idea. For swsusp2 the patch is bad because it can resume from 
after initrd (IIRC). For swsusp1 patch is bad
because it should be able to resume
from usb mass storage drive.

				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

