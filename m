Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316598AbSFKVXm>; Tue, 11 Jun 2002 17:23:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316757AbSFKVXl>; Tue, 11 Jun 2002 17:23:41 -0400
Received: from ns.suse.de ([213.95.15.193]:24845 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S316598AbSFKVXl>;
	Tue, 11 Jun 2002 17:23:41 -0400
Date: Tue, 11 Jun 2002 23:23:06 +0200
From: Andi Kleen <ak@suse.de>
To: jt@hpl.hp.com
Cc: Andi Kleen <ak@suse.de>, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org
Subject: Re: Multicast netlink for non-root process
Message-ID: <20020611232306.A30205@wotan.suse.de>
In-Reply-To: <20020611134418.A22893@bougret.hpl.hp.com.suse.lists.linux.kernel> <p737kl5cyw1.fsf@oldwotan.suse.de> <20020611141330.A22927@bougret.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2002 at 02:13:30PM -0700, Jean Tourrilhes wrote:
> On Tue, Jun 11, 2002 at 11:02:22PM +0200, Andi Kleen wrote:
> > 
> > There used to be a reason for it (ask Alexey for details), but it has gone.
> > It should be safe now to remove it I think.
> > 
> > -Andi
> 
> 	Ok, so let's ask Alexey ;-)

I think the reason was that at some point there was no proper receive
buffer management in place for netlink multicast. But that should be long fixed.

-Andi
