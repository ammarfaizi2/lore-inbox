Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267846AbUGWRfp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267846AbUGWRfp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 13:35:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267854AbUGWRfp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 13:35:45 -0400
Received: from mx1.redhat.com ([66.187.233.31]:16595 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267846AbUGWRfm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 13:35:42 -0400
Date: Fri, 23 Jul 2004 13:34:25 -0400
From: Alan Cox <alan@redhat.com>
To: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
Cc: Solar Designer <solar@openwall.com>, Alan Cox <alan@redhat.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: question about /proc/<PID>/mem in 2.4 (fwd)
Message-ID: <20040723173425.GA15472@devserv.devel.redhat.com>
References: <20040707234852.GA8297@openwall.com> <Pine.LNX.4.44.0407181336040.2374-100000@einstein.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0407181336040.2374-100000@einstein.homenet>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 18, 2004 at 01:41:34PM +0100, Tigran Aivazian wrote:
> > | 	setuidapp < /proc/self/mem
> > 
> > ... 
> > See Alan's example I've quoted above.  In this scenario, it would be
> > the program being attacked which will be checked for possession of the
> > capability... if it is SUID root, the attack will succeed.
> 
> In the above example there is nothing forbidden and the current state of 
> things doesn't prevent the program from reading it's own address space.

I meant to say exec setuidapp </proc/self/mem


