Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264944AbTBEWCl>; Wed, 5 Feb 2003 17:02:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264992AbTBEWCl>; Wed, 5 Feb 2003 17:02:41 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:60943 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S264944AbTBEWCk>;
	Wed, 5 Feb 2003 17:02:40 -0500
Date: Wed, 5 Feb 2003 14:07:55 -0800
From: Greg KH <greg@kroah.com>
To: Christoph Hellwig <hch@infradead.org>,
       "Stephen D. Smalley" <sds@epoch.ncsc.mil>, torvalds@transmeta.com,
       linux-security-module@wirex.com, linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] LSM changes for 2.5.59
Message-ID: <20030205220755.GA21652@kroah.com>
References: <200302051647.LAA05940@moss-shockers.ncsc.mil> <20030205164948.A22628@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030205164948.A22628@infradead.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2003 at 04:49:48PM +0000, Christoph Hellwig wrote:
> No it seems not pointless.  You add tons of undesigned cruft to 2.5 that
> will have to be maintained through all of 2.6. unless Linus hopefully
> pulls the plug soon enough.

I'm tired of reading this crap every time I submit a LSM patch.

I'll say it for the last time...  LSM was designed and didn't just plop
into existence.  The group has published numerous design documents both
explaining the decisions and rational behind the design and
implementation of the project.  They are available at lsm.immunix.org,
as you probably already know.  I know you don't like the implementation
we currently have, but as no one has stepped up with a different
implementation, that has been designed and tested to work for an
extremely wide range of different security models, I suggest you stop
this kind of attack.

However, concrete criticism of specific implementation details, like you
have done in the past is welcome, and encouraged.  I'll look into your
comment about coding style issues that you mentioned earlier in this
thread.

> You still haven't even submitted a single example that actually uses
> LSM into mainline.

Um, what's security/root_plug.c then?  :)

greg k-h
