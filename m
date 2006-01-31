Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751280AbWAaRRU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751280AbWAaRRU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 12:17:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751281AbWAaRRU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 12:17:20 -0500
Received: from ookhoi.xs4all.nl ([213.84.114.66]:37774 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S1751280AbWAaRRT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 12:17:19 -0500
Date: Tue, 31 Jan 2006 18:17:23 +0100
From: Sander <sander@humilis.net>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: Sander <sander@humilis.net>, linux-kernel@vger.kernel.org,
       jgarzik@pobox.com
Subject: Re: [OT] 8-port AHCI SATA Controller?
Message-ID: <20060131171723.GA6178@favonius>
Reply-To: sander@humilis.net
References: <20060131115343.GA2580@favonius> <20060131163928.GE18972@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060131163928.GE18972@csclub.uwaterloo.ca>
X-Uptime: 18:06:22 up  7:50, 21 users,  load average: 0.18, 0.15, 0.09
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lennart Sorensen wrote (ao):
> On Tue, Jan 31, 2006 at 12:53:43PM +0100, Sander wrote:
> > I'm looking for an 8-port SATA controller based on the AHCI chipset, as
> > according to http://linux.yyz.us/sata/sata-status.html#vendor_support
> > this chipset is completely open.
> 
> Hmm, I am not sure what the specs of AHCI are. Not sure if it supports
> 2 or 4 or more ports.

According to page 7 of the 
"Serial ATA Advanced Host Controller Interface Revision 1.1"
(available at http://www.intel.com/technology/serialata/ahci.htm), AHCI
supports up to 32 ports.

For example, Silicon Image 3124 also looks good on paper, but only
supports up to 4 ports.

> The only controllers I have seen that run more than 4 ports, are some
> raid cards, such as 3ware and areca. 3ware has had linux support for
> years, and areca is getting there. Both of those make 12+ port cards,
> which can run in JBOD mode.

Yeah, I know, but because of their real 'hardware' raid, these cards are
three times more expensive per port. And I just need JBOD.

Thanks for your time. Kind regards, Sander

-- 
Humilis IT Services and Solutions
http://www.humilis.net
