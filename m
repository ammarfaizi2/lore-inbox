Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266679AbUBEUFu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 15:05:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266775AbUBEUFu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 15:05:50 -0500
Received: from mail.kroah.org ([65.200.24.183]:53404 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266679AbUBEUFs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 15:05:48 -0500
Date: Thu, 5 Feb 2004 12:05:35 -0800
From: Greg KH <greg@kroah.com>
To: Deepak Saxena <dsaxena@plexity.net>, mingo@redhat.com
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.6.2-mm1 aka "Geriatric Wombat"
Message-ID: <20040205200535.GA14646@kroah.com>
References: <20040205014405.5a2cf529.akpm@osdl.org> <20040205192328.GA25331@plexity.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040205192328.GA25331@plexity.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 05, 2004 at 12:23:28PM -0700, Deepak Saxena wrote:
> On Feb 05 2004, at 01:44, Andrew Morton was caught saying:
> > 
> > +dmapool-needs-pci.patch
> > 
> >  The dmapool code doesn't build with CONFIG_PCI=n.  But it should.  Needs
> >  work.
> 
> Hmm..that defeats the purpose of making it generic. :(

I agree.  I think the comment was that UML didn't build properly, but I
really don't see what the error would be.

Could the original submitter of this patch please send us the error
messages that this patch is supposed to fix?

thanks,

greg k-h
