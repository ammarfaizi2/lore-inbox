Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750704AbWFEQcg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbWFEQcg (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 12:32:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750710AbWFEQcg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 12:32:36 -0400
Received: from cantor.suse.de ([195.135.220.2]:37000 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750704AbWFEQcf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 12:32:35 -0400
Date: Mon, 5 Jun 2006 09:30:01 -0700
From: Greg KH <greg@kroah.com>
To: Fengguang Wu <fengguang.wu@gmail.com>, Andrew Morton <akpm@osdl.org>,
        linux-kernel@vger.kernel.org, Martin Peschke <mp3@de.ibm.com>
Subject: Re: statistics infrastructure
Message-ID: <20060605163001.GC26259@kroah.com>
References: <20060604135011.decdc7c9.akpm@osdl.org> <20060605010501.GA4931@mail.ustc.edu.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060605010501.GA4931@mail.ustc.edu.cn>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05, 2006 at 09:05:01AM +0800, Fengguang Wu wrote:
> On Sun, Jun 04, 2006 at 01:50:11PM -0700, Andrew Morton wrote:
> > statistics-infrastructure.patch
>  
> >  Another tough one.  It offers generic intrastructure for non-task-related
> >  instrumentation and it would really be good if someone who has an interest
> >  in this for something other than the zfcp driver could stand up and say
> >  "this works for us".
> 
> I'm having a try of it. Looks good for my case, except some fixable
> issues/bugs. Here is a sample session for querying the readahead statistics:

The last I looked at this, it seemed way too complex for what was
needed.  A lot of the filtering and other parsing stuff should be done
by a userspace tool, not the kernel.  I'll take a second look at it and
see what I can comment on.

But I don't think it's 2.6.18 material yet...

thanks,

greg k-h
