Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261674AbTCVAtd>; Fri, 21 Mar 2003 19:49:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261675AbTCVAtd>; Fri, 21 Mar 2003 19:49:33 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:46856 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261674AbTCVAtc>;
	Fri, 21 Mar 2003 19:49:32 -0500
Date: Fri, 21 Mar 2003 17:00:37 -0800
From: Greg KH <greg@kroah.com>
To: Junfeng Yang <yjf@stanford.edu>, linux-kernel@vger.kernel.org,
       mc@cs.stanford.edu
Subject: Re: [CHECKER] potential dereference of user pointer errors
Message-ID: <20030322010036.GB18359@kroah.com>
References: <200303041112.h24BCRW22235@csl.stanford.edu> <Pine.GSO.4.44.0303202226230.24869-100000@elaine24.Stanford.EDU> <20030321161550.D646@figure1.int.wirex.com> <20030322003251.GA18359@kroah.com> <20030321164708.F646@figure1.int.wirex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030321164708.F646@figure1.int.wirex.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 21, 2003 at 04:47:08PM -0800, Chris Wright wrote:
> * Greg KH (greg@kroah.com) wrote:
> > 
> > Ugh, that's pretty bad.  That whole chunk of debug code should just be
> > replaced with a call to usb_serial_debug_data() like the other
> > usb-serial drivers do.
> > 
> > Patches welcomed :)
> 
> Something like this?

Looks good, I've added it to my trees.

thanks,

greg k-h
