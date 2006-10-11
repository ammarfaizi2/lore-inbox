Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030802AbWJKFeD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030802AbWJKFeD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 01:34:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932440AbWJKFeB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 01:34:01 -0400
Received: from smtp.osdl.org ([65.172.181.4]:41915 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932439AbWJKFeA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 01:34:00 -0400
Date: Tue, 10 Oct 2006 22:33:57 -0700
From: Andrew Morton <akpm@osdl.org>
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: do_IRQ:No irq handler for vector (was 2.6.19-rc1-mm1)
Message-Id: <20061010223357.5bc671ba.akpm@osdl.org>
In-Reply-To: <452C7D68.8010200@shaw.ca>
References: <fa.YBZBpW3yb4mb+4lGvOyPjn9n3BE@ifi.uio.no>
	<452C7D68.8010200@shaw.ca>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Oct 2006 23:13:12 -0600
Robert Hancock <hancockr@shaw.ca> wrote:

> Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc1/2.6.19-rc1-mm1/
> 
> Seeing some strange behavior on my box with 2.6.19-rc1-mm1 on Fedora 
> Core 5. (This also has my sata_nv ADMA patch applied, but I doubt it is 
> related.) About 30 seconds or so after I finish logging into X, I get this:
> 
> do_IRQ: 0.105 No irq handler for vector
> 
> and then shortly thereafter, my USB keyboard/mouse start acting 
> strangely - keypresses get missed or doubled somehow, and mouse clicks 
> don't register. Also, on my first bootup attempt, it hardlocked the box 
> at this point.
> 
> 2.6.19-rc1 and 2.6.18-mm3 (both also with the sata_nv ADMA patch) don't 
> seem to have this problem.


yes, thanks - a few people are seeing this.  It's in mainline too.  Eric
is working it.
