Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266444AbVBEWBw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266444AbVBEWBw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 17:01:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266210AbVBEWBw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 17:01:52 -0500
Received: from EASTCAMPUS-THREE-FORTY-FOUR.MIT.EDU ([18.248.6.89]:21120 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S266444AbVBEWBq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 17:01:46 -0500
Date: Sat, 5 Feb 2005 16:56:54 -0500
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: PNP and suspend/resumt
Message-ID: <20050205215654.GB3621@neo.rr.com>
Mail-Followup-To: ambx1@neo.rr.com,
	Pierre Ossman <drzeus-list@drzeus.cx>,
	LKML <linux-kernel@vger.kernel.org>
References: <4204F31E.5060702@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4204F31E.5060702@drzeus.cx>
User-Agent: Mutt/1.5.6+20040907i
From: ambx1@neo.rr.com (Adam Belay)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 05, 2005 at 05:23:58PM +0100, Pierre Ossman wrote:
> How is suspend/resume handled with PNP devices? There are no 
> suspend/resume functions registered for the pnp bus type.
> 
> Rgds
> Pierre

PnP isn't a physical abstraction, so for now if you want to set the values
in "struct device_driver" directly, go for it.

Thanks,
Adam
