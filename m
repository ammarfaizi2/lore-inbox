Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264548AbRFOWWE>; Fri, 15 Jun 2001 18:22:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264547AbRFOWVo>; Fri, 15 Jun 2001 18:21:44 -0400
Received: from olsinka.site.cas.cz ([147.231.11.16]:25732 "EHLO
	twilight.suse.cz") by vger.kernel.org with ESMTP id <S264545AbRFOWVh>;
	Fri, 15 Jun 2001 18:21:37 -0400
Date: Sat, 16 Jun 2001 00:21:31 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dan Streetman <ddstreet@us.ibm.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: ps2 keyboard filter hook
Message-ID: <20010616002131.A5243@suse.cz>
In-Reply-To: <OF7CA123EC.2D473DAE-ON85256A6C.00782D85@raleigh.ibm.com> <Pine.LNX.4.10.10106151751290.28123-100000@ddstreet.raleigh.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10106151751290.28123-100000@ddstreet.raleigh.ibm.com>; from ddstreet@us.ibm.com on Fri, Jun 15, 2001 at 06:14:05PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2001 at 06:14:05PM -0400, Dan Streetman wrote:
> 
> >> Vojtech, could you comment on if the above is possible using the input
> >layer?
> >
> >Yes, and quite easily it'll fit into the input layer. Basically the way
> >to do it would be to open the PS/2 port in the filter driver (thus
> >disabling the normal keyboard driver to open it) and then register a new
> >PS/2 port which the normal keyboard driver would attach to.
> 
> Sweet!  Thanks.
> 
> I assume this (along with the linux-console stuff) won't make it into the 2.4
> kernel for a while though, until after it's been in 2.5 for a while?

It's planned for 2.5.0. If it'll make it back to 2.4.x, I can only hope.

-- 
Vojtech Pavlik
SuSE Labs
