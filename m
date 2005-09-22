Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751205AbVIVVtb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205AbVIVVtb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 17:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751219AbVIVVtb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 17:49:31 -0400
Received: from 66-23-228-155.clients.speedfactory.net ([66.23.228.155]:35219
	"EHLO kevlar.burdell.org") by vger.kernel.org with ESMTP
	id S1751205AbVIVVtb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 17:49:31 -0400
Date: Thu, 22 Sep 2005 17:44:35 -0400
From: Sonny Rao <sonny@burdell.org>
To: Christopher Friesen <cfriesen@nortel.com>
Cc: dipankar@in.ibm.com, Al Viro <viro@ftp.linux.org.uk>,
       Roland Dreier <rolandd@cisco.com>, linux-kernel@vger.kernel.org,
       "Theodore Ts'o" <tytso@mit.edu>, bharata@in.ibm.com,
       trond.myklebust@fys.uio.no
Subject: Re: dentry_cache using up all my zone normal memory -- also seen on 2.6.14-rc2
Message-ID: <20050922214435.GA31911@kevlar.burdell.org>
References: <4331CFAD.6020805@nortel.com> <52ll1qkrii.fsf@cisco.com> <20050922031136.GE7992@ftp.linux.org.uk> <43322AE6.1080408@nortel.com> <20050922041733.GF7992@ftp.linux.org.uk> <4332CAEA.1010509@nortel.com> <20050922182719.GA4729@in.ibm.com> <4332FFF5.5060207@nortel.com> <20050922191805.GB4729@in.ibm.com> <43332400.2070606@nortel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43332400.2070606@nortel.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2005 at 03:37:04PM -0600, Christopher Friesen wrote:
> Dipankar Sarma wrote:
> 
> >Can you look at that each cpu is running (backtrace) using
> >sysrq ? That may tell us what is holding up RCU. I will look
> >at it myself later.
> 
> I'm having some trouble with sysrq over serial console.  I can trigger 
> it, and it dumps the words "SysRq : Show Regs" to the console, but the 
> actual data only goes to dmesg.
> 
> That should work for this, but does anyone have any idea whats going on 
> there?

I think your loglevel is too low, set it to seven (using sysrq if
necessary) and try again. 


