Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262528AbSI0Qaj>; Fri, 27 Sep 2002 12:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262529AbSI0Qaj>; Fri, 27 Sep 2002 12:30:39 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:37389 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262528AbSI0Qai>;
	Fri, 27 Sep 2002 12:30:38 -0400
Date: Fri, 27 Sep 2002 09:34:19 -0700
From: Greg KH <greg@kroah.com>
To: Stephen Smalley <sds@tislabs.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       linux-security-module@wirex.com
Subject: Re: [RFC] LSM changes for 2.5.38
Message-ID: <20020927163419.GA11530@kroah.com>
References: <20020927003210.A2476@sgi.com> <Pine.GSO.4.33.0209270743170.22771-100000@raven>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.33.0209270743170.22771-100000@raven>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2002 at 08:09:50AM -0400, Stephen Smalley wrote:
> 
> > Also is there a _real_ need to pass in all the arguments?
> 
> Define _real_.  It is true that none of the existing open source security
> modules presently use this particular hook.  SELinux doesn't presently use
> it, but it seems reasonable to support finer-grained control over ioperm()
> than the all-or-nothing CAP_SYS_RAWIO.  Is the criteria that every hook
> and every parameter to every hook must be used by an existing open source
> security module?  If so, then yes, this hook can be dropped.

Yes, I think that is the criteria for any security hook.  So it (and
others) should be dropped.

thanks,

greg k-h
