Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132718AbRC2LqE>; Thu, 29 Mar 2001 06:46:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132720AbRC2Lp5>; Thu, 29 Mar 2001 06:45:57 -0500
Received: from zeus.kernel.org ([209.10.41.242]:58848 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S132718AbRC2LpW>;
	Thu, 29 Mar 2001 06:45:22 -0500
To: <linux-kernel@vger.kernel.org>
Subject: Re: RFC: configuring net interfaces
In-Reply-To: <m3itkuq6xt.fsf@intrepid.pm.waw.pl>
	<20010328182729.A16067@se1.cogenit.fr>
	<m34rwd8pj2.fsf@intrepid.pm.waw.pl>
	<20010329112547.A23947@se1.cogenit.fr>
Content-Type: text/plain; charset=US-ASCII
From: Krzysztof Halasa <khc@intrepid.pm.waw.pl>
Date: 29 Mar 2001 13:07:58 +0200
In-Reply-To: Francois Romieu's message of "Thu, 29 Mar 2001 11:25:47 +0200"
Message-ID: <m33dbw7rzl.fsf@intrepid.pm.waw.pl>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Francois Romieu <romieu@cogenit.fr> writes:

> Parameters for retransmission of a trame specified in Q922. t200 is the
> timeout value and n200 the maximal number of retransmissions. They can
> be negocied and default to t200=1,5s, n200=3.

Hmm... I've taken a look at it, but it seems to me that they are only
used with "acknowledged multiple frame operation". Isn't it for ISDN only?
With Frame Relay, we rather use unacknowledged transfers and UI frames.

Of course, if we have an implementation using t200, n200 or other
parameters, they should be added to the structure.
-- 
Krzysztof Halasa
Network Administrator
