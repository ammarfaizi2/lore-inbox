Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937971AbWLGOyF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937971AbWLGOyF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 09:54:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937972AbWLGOyE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 09:54:04 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:2653 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937973AbWLGOyB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 09:54:01 -0500
Date: Thu, 7 Dec 2006 14:53:48 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: David Miller <davem@davemloft.net>
Cc: dhowells@redhat.com, viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: cmpxchg() in kernel/workqueue.c breaks things
Message-ID: <20061207145348.GA1255@flint.arm.linux.org.uk>
Mail-Followup-To: David Miller <davem@davemloft.net>, dhowells@redhat.com,
	viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
	akpm@osdl.org
References: <20061207.000950.28414823.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061207.000950.28414823.davem@davemloft.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2006 at 12:09:50AM -0800, David Miller wrote:
> Also, because Alan Cox's machine (zeniv) went down, a few folks such
> as Al Viro (CC:'d) had no opportunity to comment on your changes
> before they went in.

Special thanks should be given to Vince Sanders and Leslie Mitchell for
sourcing the replacement PSU and going to the data centre at rather short
notice to resolve the problem, without whom ZenIV would still probably
be down.

I should also correct you - it was Bryce (Philip Copeland) put ZenIV
together.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
