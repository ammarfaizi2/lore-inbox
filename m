Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264541AbRFOWTo>; Fri, 15 Jun 2001 18:19:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264542AbRFOWTe>; Fri, 15 Jun 2001 18:19:34 -0400
Received: from ss06.nc.us.ibm.com ([32.97.136.236]:59372 "EHLO
	ddstreet.raleigh.ibm.com") by vger.kernel.org with ESMTP
	id <S264541AbRFOWTX>; Fri, 15 Jun 2001 18:19:23 -0400
Date: Fri, 15 Jun 2001 18:14:05 -0400 (EDT)
From: Dan Streetman <ddstreet@us.ibm.com>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: ps2 keyboard filter hook
In-Reply-To: <OF7CA123EC.2D473DAE-ON85256A6C.00782D85@raleigh.ibm.com>
Message-ID: <Pine.LNX.4.10.10106151751290.28123-100000@ddstreet.raleigh.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> Vojtech, could you comment on if the above is possible using the input
>layer?
>
>Yes, and quite easily it'll fit into the input layer. Basically the way
>to do it would be to open the PS/2 port in the filter driver (thus
>disabling the normal keyboard driver to open it) and then register a new
>PS/2 port which the normal keyboard driver would attach to.

Sweet!  Thanks.

I assume this (along with the linux-console stuff) won't make it into the 2.4
kernel for a while though, until after it's been in 2.5 for a while?

Thanks again!

-- 
Dan Streetman
ddstreet@us.ibm.com
--------------------------------------------------
186,282 miles per second:
It isn't just a good idea, it's the law!

