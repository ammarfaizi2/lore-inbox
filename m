Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262547AbSI0RVk>; Fri, 27 Sep 2002 13:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262548AbSI0RU7>; Fri, 27 Sep 2002 13:20:59 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:50445 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262547AbSI0RUr>;
	Fri, 27 Sep 2002 13:20:47 -0400
Date: Fri, 27 Sep 2002 10:24:28 -0700
From: Greg KH <greg@kroah.com>
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       linux-security-module@wirex.com
Subject: Re: [RFC] LSM changes for 2.5.38
Message-ID: <20020927172428.GB11813@kroah.com>
References: <20020927003210.A2476@sgi.com> <20020926225147.GC7304@kroah.com> <20020927174849.A32207@infradead.org> <20020927165556.GH11530@kroah.com> <20020927180118.A32610@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020927180118.A32610@infradead.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2002 at 06:01:18PM +0100, Christoph Hellwig wrote:
> On Fri, Sep 27, 2002 at 09:55:56AM -0700, Greg KH wrote:
> > For cases like the module_* hooks, and the other examples you pointed
> > out, I agree.
> > 
> > For other cases, capable() is just not fine grained enough to actually
> > know what is going on (like CAP_SYS_ADMIN).  In those cases you need an
> > extra hook to determine where in the kernel you are.
> 
> Either we make capable fine grained enough (64 or 128bit capability
> vectors, I have some old code for that around and I know SGI used that
> more than a year ago) or we replace the capable in those cases with hooks
> entirely.

I don't have a problem with either of these things, but don't see them
being completed any time soon.  Unless you have some time to work on
this?

thanks,

greg k-h
