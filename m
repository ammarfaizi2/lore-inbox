Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288552AbSAHXOS>; Tue, 8 Jan 2002 18:14:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288557AbSAHXOJ>; Tue, 8 Jan 2002 18:14:09 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:28174 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S288552AbSAHXN5>;
	Tue, 8 Jan 2002 18:13:57 -0500
Date: Tue, 8 Jan 2002 15:11:47 -0800
From: Greg KH <greg@kroah.com>
To: jtv <jtv@xs4all.nl>
Cc: Vladimir Kondratiev <vladimir.kondratiev@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: __FUNCTION__
Message-ID: <20020108231147.GA16313@kroah.com>
In-Reply-To: <3C3B664B.3060103@intel.com> <20020108220149.GA15816@kroah.com> <20020108235649.A26154@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020108235649.A26154@xs4all.nl>
User-Agent: Mutt/1.3.25i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Tue, 11 Dec 2001 20:57:04 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2002 at 11:56:49PM +0100, jtv wrote:
> 
> Don't have a C99 spec, but here's what info gcc has to say about it:
> 
> [...description of "function names" extension as currently found in gcc...]
> 
>    Note that these semantics are deprecated, and that GCC 3.2 will
> handle `__FUNCTION__' and `__PRETTY_FUNCTION__' the same way as
> `__func__'.  `__func__' is defined by the ISO standard C99:

Any reason _why_ they would want to break tons of existing code in this
manner?  Just the fact that the __func__ symbol is there to use?

Since the C99 spec does not state anything about __FUNCTION__, changing
it from the current behavior does not seem like a wise thing to do.

Any pointers to someone to complain to, or is there no chance for
reversal?

greg k-h
