Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751170AbWFOAsi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbWFOAsi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 20:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751193AbWFOAsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 20:48:38 -0400
Received: from 58.105.229.78.optusnet.com.au ([58.105.229.78]:48825 "EHLO
	adsl-kenny.stuart.id.au") by vger.kernel.org with ESMTP
	id S1750971AbWFOAsh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 20:48:37 -0400
Subject: Re: [PATCH 2/2] NET: Accurate packet scheduling for ATM/ADSL
	(userspace)
From: Russell Stuart <russell-tcatm@stuart.id.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Stephen Hemminger <shemminger@osdl.org>,
       Jamal Hadi Salim <hadi@cyberus.ca>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <1150282625.3490.23.camel@localhost.localdomain>
References: <1150278040.26181.37.camel@localhost.localdomain>
	 <1150282625.3490.23.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 15 Jun 2006 10:47:29 +1000
Message-Id: <1150332449.8605.40.camel@ras.pc.brisbane.lube>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-06-14 at 11:57 +0100, Alan Cox wrote:
> The other problem I see with this code is it is very tightly tied to ATM
> cell sizes, not to solving the generic question of packetisation.

Others have made this point also.  I can't speak for Jesper,
but I did consider making it generic.  The issue was that 
doing so would add more code, but I don't personally know 
of any real world situation that would use the generic 
solution.  I didn't fancy the thought of arguing on these
lists for code that no one would actually use.

If someone could put up their hand and say "Hey, I need
this," then expanding the patch to accommodate them would
be a pleasure.  I like generic code too.


Russell

