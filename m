Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751218AbWEIWYI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218AbWEIWYI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 18:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751225AbWEIWYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 18:24:07 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:38661 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751218AbWEIWYH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 18:24:07 -0400
Date: Wed, 10 May 2006 00:24:10 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Ram Pai <linuxram@us.ibm.com>
Cc: Andreas Gruenbacher <agruen@suse.de>, Greg KH <greg@kroah.com>,
       Jan Beulich <jbeulich@novell.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Check for license compliance at build time
Message-ID: <20060509222410.GB12810@mars.ravnborg.org>
References: <445F0B6F.76E4.0078.0@novell.com> <20060509042500.GA4226@kroah.com> <1147154238.7203.62.camel@localhost> <200605091931.49216.agruen@suse.de> <1147208158.7203.107.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1147208158.7203.107.camel@localhost>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2006 at 01:55:58PM -0700, Ram Pai wrote:
> On Tue, 2006-05-09 at 19:31 +0200, Andreas Gruenbacher wrote:
> > This patch on to of Ram Pai's modpost.diff patch at 
> > http://sudhaa.com/~ram/misc/kernelpatch implements license compliance testing 
> > in modpost. This prevents kbuild from producing modules that won't load.
> 
> Yes, I like this patch. Its a early warning system for a module having
> no chance of getting inserted into the kernel.
> 
> Sam : do you want all these patches submitted togather? 
Yes - please do. I have the originals queued up but it would be helpfull
to get it as a new serie.

And integrate the fix from Andreas so it is not a separate commit.

	Sam
