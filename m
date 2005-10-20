Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932132AbVJTNR3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932132AbVJTNR3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 09:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932144AbVJTNR3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 09:17:29 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:26892 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932132AbVJTNR3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 09:17:29 -0400
Date: Thu, 20 Oct 2005 15:18:16 +0200
From: Jens Axboe <axboe@suse.de>
To: Chris Boot <bootc@bootc.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Reiser4 lockups (no oops)
Message-ID: <20051020131815.GI2811@suse.de>
References: <43567D80.3050304@bootc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43567D80.3050304@bootc.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19 2005, Chris Boot wrote:
> I don't get any OOPSes or BUGs or anything, not on my screen nor on my 
> serial console (although I'm not sure I have this working right--I only 
> seem to get kernel boot messages). Machine replies to pings but I can't 

Easy fix for that is probably to kill klogd on the machine. Test with eg
loading/unloading of loop, that prints a message when it loads.

-- 
Jens Axboe

