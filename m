Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261494AbVDNNAt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261494AbVDNNAt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 09:00:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261495AbVDNNAt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 09:00:49 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:5271 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261494AbVDNNAh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 09:00:37 -0400
Date: Sat, 9 Apr 2005 12:06:46 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Dan Stromberg <strombrg@dcs.nac.uci.edu>, linux-kernel@vger.kernel.org
Subject: Re: AOE and large filesystems?
Message-ID: <20050409100646.GA5135@openzaurus.ucw.cz>
References: <pan.2005.04.05.20.44.39.37209@dcs.nac.uci.edu> <42531A42.90508@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42531A42.90508@pobox.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Dan Stromberg wrote:
> >Some questions for the list:
> >
> >1) Is anyone on the list using AOE in production?
> >
> >2) Is anyone on the list using AOE in combination with md and/or 
> >LVM2?
> >
> >3) Is anyone on the list using AOE on a 64 bit platform?
> 
> While I think AoE is "neat", IMO you really want to use something 
> based on TCP, even on a LAN...

TCP does not work for swapping, unfortunately. And same problem
might be in dirty-page-writeout...
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

