Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262208AbSJVFOQ>; Tue, 22 Oct 2002 01:14:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262209AbSJVFOQ>; Tue, 22 Oct 2002 01:14:16 -0400
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:5898 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262208AbSJVFOQ>;
	Tue, 22 Oct 2002 01:14:16 -0400
Date: Mon, 21 Oct 2002 22:19:14 -0700
From: Greg KH <greg@kroah.com>
To: Lucio Maciel <abslucio@terra.com.br>
Cc: Rik van Riel <riel@conectiva.com.br>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: System call wrapping
Message-ID: <20021022051914.GF3076@kroah.com>
References: <Pine.LNX.4.44L.0210211812240.22993-100000@imladris.surriel.com> <1035232394.21145.8.camel@walker>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1035232394.21145.8.camel@walker>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2002 at 05:33:14PM -0300, Lucio Maciel wrote:
> On Mon, 2002-10-21 at 17:14, Rik van Riel wrote:
> > 
> > Maybe you could use the Linux Security Module hooks for
> > open() and exec() to pass a request to your virus scan
> > software ?
> > 
> > Note that this kernel module needs to be GPL, due to the
> > fact that it's a derived work of the kernel itself. This
> > only applies to the kernel module that asks the virus
> > scanner to check the files for virusses, not necessarily
> > the virus scanner itself.
> > 
> > Rik
> > -- 
> Hello...
> 
> Where can i find some information or documentation about this ????

lsm.immunix.org, or look in the Documentation/DocBook/lsm.* file

greg k-h
