Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310154AbSCAXFy>; Fri, 1 Mar 2002 18:05:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310155AbSCAXFo>; Fri, 1 Mar 2002 18:05:44 -0500
Received: from ns.suse.de ([213.95.15.193]:32005 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S310154AbSCAXFg>;
	Fri, 1 Mar 2002 18:05:36 -0500
Date: Sat, 2 Mar 2002 00:05:35 +0100
From: Andi Kleen <ak@suse.de>
To: Julian Anastasov <ja@ssi.bg>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, kain@kain.org
Subject: Re: OOPS: Multipath routing 2.4.17
Message-ID: <20020302000535.B16807@wotan.suse.de>
In-Reply-To: <p73sn7jkixm.fsf@oldwotan.suse.de> <Pine.LNX.4.44.0203020050220.1706-100000@u.domain.uli>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0203020050220.1706-100000@u.domain.uli>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 02, 2002 at 01:01:25AM +0000, Julian Anastasov wrote:
> 
> 	How oops is reached:

[... see my other crossing mail...]
> 	If I understand correctly the locking (please correct me),
> we can have many threads at the same time:
> 
> - many in ip_route_* calling fib_select_multipath
> 
> - one in rtnetlink playing with nh_*

Yes, that's correct.

-Andi

