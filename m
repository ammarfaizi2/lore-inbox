Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132895AbRDPJjC>; Mon, 16 Apr 2001 05:39:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132898AbRDPJiw>; Mon, 16 Apr 2001 05:38:52 -0400
Received: from [196.38.105.82] ([196.38.105.82]:42756 "EHLO www.webtrac.co.za")
	by vger.kernel.org with ESMTP id <S132895AbRDPJit>;
	Mon, 16 Apr 2001 05:38:49 -0400
Date: Mon, 16 Apr 2001 11:37:24 +0200
From: Craig Schlenter <craig@webtelecoms.co.za>
To: Rok Papez <rok.papez@kiss.uni-lj.si>
Cc: linux-kernel@vger.kernel.org
Subject: Re: TCP/IP problem on 2.2.18. Very big delay when pinging *local* interface (5x NIC, 18x IP).
Message-ID: <20010416113724.A30745@webtelecoms.co.za>
In-Reply-To: <01041611164102.00759@strader>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <01041611164102.00759@strader>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 16, 2001 at 11:03:33AM +0200, Rok Papez wrote:
> Hi!
> 
> Running 5x 3c905 NICs with 18 IPs
> 
> Summary:
> When I boot Linux and ping a *local* IP address, it has a
> very big delay. Flood ping works without a glitch, normal 
> ping exhibits a big delay at the start but will eventualy
> start working normally.

try ping -n IP_ADDRESS. Chances are your reverse DNS is unhappy for the
IP's in question.

--C
