Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290792AbSBFUfq>; Wed, 6 Feb 2002 15:35:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290797AbSBFUfh>; Wed, 6 Feb 2002 15:35:37 -0500
Received: from bitmover.com ([192.132.92.2]:22979 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S290792AbSBFUfb>;
	Wed, 6 Feb 2002 15:35:31 -0500
Date: Wed, 6 Feb 2002 12:35:27 -0800
From: Larry McVoy <lm@bitmover.com>
To: Christoph Hellwig <hch@ns.caldera.de>
Cc: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: linux-2.5.4-pre1 - bitkeeper testing
Message-ID: <20020206123527.R7674@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Christoph Hellwig <hch@ns.caldera.de>,
	Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020206000343.I14622@work.bitmover.com> <200202061935.g16JZLh18377@ns.caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200202061935.g16JZLh18377@ns.caldera.de>; from hch@ns.caldera.de on Wed, Feb 06, 2002 at 08:35:21PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Btw, is there a generic way to move repos cloned from Ted's (now
> orphaned?) 2.4 tree to Linus' official one?

You can export the changes you want as a patch and if you ask, we'll send
you a script which also exports your checkin comments in Linus' nifty
new email->BK converter.  The format that we like (I believe, Wayne/Linus
will correct errors) is:

### Change the comments to ChangeSet below
These are the changeset comments, i.e, the email message for the patch.

### Change the comments to include/asm/whatever.h below
The comments for include/asm/whatever.h

In other words

printf("### Change the comments to %s below\n", filename);

And then it can be imported directly.

To create an extra script to do this for a bk export -tpatch is straightforward.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
