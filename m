Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261410AbRFFJ3P>; Wed, 6 Jun 2001 05:29:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261459AbRFFJ3F>; Wed, 6 Jun 2001 05:29:05 -0400
Received: from sportingbet.gw.dircon.net ([195.157.147.30]:268 "HELO
	sysadmin.sportingbet.com") by vger.kernel.org with SMTP
	id <S261410AbRFFJ2s>; Wed, 6 Jun 2001 05:28:48 -0400
Date: Wed, 6 Jun 2001 10:25:14 +0100
From: Sean Hunter <sean@dev.sportingbet.com>
To: Xavier Bestel <xavier.bestel@free.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Break 2.4 VM in five easy steps
Message-ID: <20010606102514.E15199@dev.sportingbet.com>
Mail-Followup-To: Sean Hunter <sean@dev.sportingbet.com>,
	Xavier Bestel <xavier.bestel@free.fr>, linux-kernel@vger.kernel.org
In-Reply-To: <3B1D5ADE.7FA50CD0@illusionary.com> <Pine.LNX.4.33.0106051634540.8311-100000@heat.gghcwest.com> <3B1D927E.1B2EBE76@uow.edu.au> <20010605231908.A10520@illusionary.com> <991815578.30689.1.camel@nomade> <20010606095431.C15199@dev.sportingbet.com> <991818989.30690.2.camel@nomade>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <991818989.30690.2.camel@nomade>; from xavier.bestel@free.fr on Wed, Jun 06, 2001 at 11:16:27AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 06, 2001 at 11:16:27AM +0200, Xavier Bestel wrote:
> On 06 Jun 2001 09:54:31 +0100, Sean Hunter wrote:
> > > This is what Linus recommended for 2.4 (swap = 2 * RAM), saying that
> > > anything less won't do any good: 2.4 overallocates swap even if it
> > > doesn't use it all. So in your case you just have enough swap to map
> > > your RAM, and nothing to really swap your apps.
> > > 
> > 
> > For large memory boxes, this is ridiculous.  Should I have 8GB of swap?
> 
> Life is tough. If guess if you have 4GB RAM, you'd be better having no
> swap at all. Or, yes, at least 8GB.
> Or just wait for this bug to be fixed. But be patient.

This is just pure bollocks.  Virtual memory is one of the killer features of
unix. It would be a strange admission to say that our "advanced" 2.4
kernel is so advanced that now you can't use virtual memory at all on
large machines. Needing 8GB of swap to prevent a box from committing
suicide when it has a working set of less than 512M is crazy.

I am waiting patiently for the bug to be fixed. However, it is a real
embarrasment that we can't run this "stable" kernel in production yet
because somethign as fundamental as this is so badly broken.

Sean
