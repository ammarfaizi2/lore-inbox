Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264630AbSJTTat>; Sun, 20 Oct 2002 15:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264632AbSJTTat>; Sun, 20 Oct 2002 15:30:49 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:34520 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S264630AbSJTTar>;
	Sun, 20 Oct 2002 15:30:47 -0400
Date: Sun, 20 Oct 2002 21:36:52 +0200
From: bert hubert <ahu@ds9a.nl>
To: Rasmus Andersen <rasmus@jaquet.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Error in get_swap_page? (2.5.44)
Message-ID: <20021020193652.GC26384@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Rasmus Andersen <rasmus@jaquet.dk>, linux-kernel@vger.kernel.org
References: <20021020213217.A17457@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021020213217.A17457@jaquet.dk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 20, 2002 at 09:32:17PM +0200, Rasmus Andersen wrote:

> Unless I am mistaken, we return stuff (entry) from the local 
> stack in swapfile.c::get_swap_page. Am I mistaken?

Yes. This just returns a struct by value over the stack, which is frowned
upon in some circles, but is not an error per se.

Regards,

bert

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
