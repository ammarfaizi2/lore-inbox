Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030284AbWFOMDi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030284AbWFOMDi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 08:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030283AbWFOMDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 08:03:38 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:5762 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030279AbWFOMDh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 08:03:37 -0400
Date: Thu, 15 Jun 2006 13:03:36 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       linux-m68k@vger.kernel.org
Subject: Re: [PATCH] m68k: bogus constraints in signal.h
Message-ID: <20060615120336.GQ27946@ftp.linux.org.uk>
References: <20060615111126.GJ27946@ftp.linux.org.uk> <Pine.LNX.4.64.0606151343200.17704@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606151343200.17704@scrub.home>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2006 at 01:46:55PM +0200, Roman Zippel wrote:
> Hi,
> 
> On Thu, 15 Jun 2006, Al Viro wrote:
> 
> > bfset and friends need "o", not "m" - they don't work with autodecrement
> > memory arguments.  bitops.h had it fixed, signal.h hadn't...
> 
> I have a better version for this one pending, which I have queued for 
> 2.6.18.

Could you post it?
