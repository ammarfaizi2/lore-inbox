Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751317AbWA0GvZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317AbWA0GvZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 01:51:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751358AbWA0GvZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 01:51:25 -0500
Received: from relay02.pair.com ([209.68.5.16]:17417 "HELO relay02.pair.com")
	by vger.kernel.org with SMTP id S1751317AbWA0GvY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 01:51:24 -0500
X-pair-Authenticated: 67.163.102.102
From: Chase Venters <chase.venters@clientec.com>
Organization: Clientec, Inc.
To: Kalin KOZHUHAROV <kalin@thinrope.net>
Subject: Re: libata errors in 2.6.15.1 ICH6 AHCI (SATA drive WD740GD)
Date: Fri, 27 Jan 2006 00:50:58 -0600
User-Agent: KMail/1.9
Cc: linux-kernel@vger.kernel.org
References: <drc9qt$mk4$1@sea.gmane.org>
In-Reply-To: <drc9qt$mk4$1@sea.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601270051.20329.chase.venters@clientec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 26 January 2006 23:07, Kalin KOZHUHAROV wrote:
> Hi there.
>
> I am reiterating this, while trying to diagnose the problem.
> It is a DIY box with Asus P5GDC-V Deluxe motherboard with Marvel 88E8053 GB
> ethernet (for info see [1]) and WD740GD (10k RPM) harddisk.
>

Funny. I've been having problems at least since 2.6.13 (perhaps before; my 
memory is broken) with my Asus P5GDC-V Deluxe and 4 WD drives. I've seen DMA 
timeouts on my serial console, followed by an immediate kernel freeze in 
which Magic SysRQ doesn't even respond.

I have yet to experience the freezing behavior on 2.6.15 (though I think I may 
have seen errors in dmesg at one point), but then again, I've been a victim 
of a slab leak which means I haven't maintained much of an uptime under 
2.6.15.

I'm working on debugging the slab leak at the moment... unfortunately, I don't 
know enough about SATA to really debug this issue. Bisecting would take 
forever because it usually takes several days before I ever experience a 
random freeze.

Nevertheless, if anyone has any pointers, I'd really like to start to wring 
some of these bugs out of my kernel. 

>
> Kalin.

Cheers,
Chase
