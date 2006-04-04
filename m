Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932209AbWDDOWd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932209AbWDDOWd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 10:22:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932210AbWDDOWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 10:22:32 -0400
Received: from mail.gondor.com ([212.117.64.182]:3333 "EHLO moria.gondor.com")
	by vger.kernel.org with ESMTP id S932209AbWDDOWc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 10:22:32 -0400
Date: Tue, 4 Apr 2006 16:21:43 +0200
From: Jan Niehusmann <jan@gondor.com>
To: Andreas Gruenbacher <agruen@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Dave Jones <davej@redhat.com>,
       Paul Fulghum <paulkf@microgate.com>, linux-kernel@vger.kernel.org
Subject: Re: yet more slab corruption.
Message-ID: <20060404142143.GA5159@knautsch.gondor.com>
References: <20060307235940.GA16843@redhat.com> <20060307231414.34c3b3a4.akpm@osdl.org> <200604041544.01656.agruen@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604041544.01656.agruen@suse.de>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2006 at 03:44:01PM +0200, Andreas Gruenbacher wrote:
> We have two similar bug reports to 
> https://bugzilla.redhat.com/bugzilla/184310, slab corruption in an object 
> freed by release_mem:
> 
> 	https://bugzilla.novell.com/151111 (i386)
> 	https://bugzilla.novell.com/154601 (x86_64)
> 
> So this bug seems to trigger on different architectures, and with different 
> hardware.

I also got a few of these, just reported in a different thread, 
see http://lkml.org/lkml/2006/4/4/86 for details.

Jan
