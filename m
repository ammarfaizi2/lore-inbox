Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264918AbUE0SBW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264918AbUE0SBW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 14:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264919AbUE0SBV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 14:01:21 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:3550 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264918AbUE0SBU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 14:01:20 -0400
Date: Thu, 27 May 2004 19:01:19 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: FabF <fabian.frederick@skynet.be>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.7-rc1-mm1] lp int copy_to_user replaced
Message-ID: <20040527180118.GQ12308@parcelfarce.linux.theplanet.co.uk>
References: <1085679127.2070.21.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1085679127.2070.21.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2004 at 07:32:08PM +0200, FabF wrote:
> Andrew,
> 
> 	Here's a patch to have standard __put_user for integer transfers in lp
> driver.Is it correct ?

What the hell for?  copy_to_user()/copy_from_user() is perfectly OK here.
