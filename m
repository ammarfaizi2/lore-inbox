Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284390AbRLENoJ>; Wed, 5 Dec 2001 08:44:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284393AbRLENn7>; Wed, 5 Dec 2001 08:43:59 -0500
Received: from ns.suse.de ([213.95.15.193]:6154 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S284390AbRLENnp>;
	Wed, 5 Dec 2001 08:43:45 -0500
Date: Wed, 5 Dec 2001 14:43:42 +0100
From: Andi Kleen <ak@suse.de>
To: Jyotheeswara Rao Kurma <jyotheeswara.rao@wipro.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: netlink socket help
Message-ID: <20011205144342.A675@wotan.suse.de>
In-Reply-To: <3ab3637593.375933ab36@wipro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ab3637593.375933ab36@wipro.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2001 at 04:10:58PM +0500, Jyotheeswara Rao Kurma wrote:
> 
> > > How to get kernel route table ( not cache ) into user space , using
> > > netlink sockets, i tried with NLM_F_ROOT option. but it is 
> > giving the 
> > > route cache . 
> > 
> > Don't set the RTM_F_CLONED flag in the request.
> > 
> 
>   But still getting entries more than what route/netstat  command is 
>   showing.  Any thing else ? 

route/netsta don't show the whole picture. they are just for compatibility
and just show what can be expressed in the old ioctls. The in kernel
routing table is more rich. 


-Andi
