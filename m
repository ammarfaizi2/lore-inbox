Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932086AbWCAM7d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932086AbWCAM7d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 07:59:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932106AbWCAM7d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 07:59:33 -0500
Received: from viking.sophos.com ([194.203.134.132]:39697 "EHLO
	viking.sophos.com") by vger.kernel.org with ESMTP id S932086AbWCAM7c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 07:59:32 -0500
In-Reply-To: <1141216671.3185.22.camel@laptopd505.fenrus.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       Herbert Poetzl <herbert@13thfloor.at>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [RFC] vfs: cleanup of permission()
MIME-Version: 1.0
X-Mailer: Lotus Notes Release 6.5.2 June 01, 2004
Message-ID: <OF8335F2B0.0A730216-ON80257124.0045E22D-80257124.00475BA4@sophos.com>
From: tvrtko.ursulin@sophos.com
Date: Wed, 1 Mar 2006 12:59:25 +0000
X-MIMETrack: S/MIME Sign by Notes Client on Tvrtko Ursulin/Dev/UK/Sophos(Release 6.5.2|June
 01, 2004) at 01/03/2006 12:59:25,
	Serialize by Notes Client on Tvrtko Ursulin/Dev/UK/Sophos(Release 6.5.2|June
 01, 2004) at 01/03/2006 12:59:25,
	Serialize complete at 01/03/2006 12:59:25,
	S/MIME Sign failed at 01/03/2006 12:59:25: The cryptographic key was not
 found,
	Serialize by Router on Mercury/Servers/Sophos(Release 6.5.5|November 30, 2005) at
 01/03/2006 12:59:28,
	Serialize complete at 01/03/2006 12:59:28
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@infradead.org> wrote on 01/03/2006 12:37:51:

> > And finally, please don't remove nameidata. Modules out there depend 
on it 
> 
> are those modules about to merged into the kernel? The current intent

See third paragraph of my reply.

> infrastructure isn't fulfilling what it should do well, and from what
> I've seen on the discussions it sounds that the best way forward is to
> undo the current implementation and then roll out one which caters to
> the needs of the existing users better.

That I don't know so I can't comment at the moment. I haven't seen 
anything on linux-security-modules recently?
 
> As external module, you have little say so far simply because your usage
> isn't visible. I'd urge you to quickly submit your code so that the
> things you need from this are better visible to the people who are
> thinking and working on the redesign.

I know all that, but it is a complicated matter to discuss. That's why I 
was planning to make a comprehensive announcement which would discuss most 
of the hot topics. Ideally yes, I would like to merge, but it won't happen 
now. The first thing I would like to do is establish common ground with 
other security vendors so that we could approach the problem together. 
Personaly, I am not sure whether insisting that everything should be a 
part of kernel is a right thing to do even though I think I understand all 
the up- and down-sides of both policies.

Having said all this above, I am afraid that there will be no other choice 
but to start working on the announcement asap. :)
 
> > and we at Sophos are about to release a new product which needs it as 
> > well. 
> 
> I assume we're talking about an open source product, or at least kernel
> component, here?

Of course. Kernel component might be known to some as Talpa and it is 
released under GPL.

