Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275096AbTHRVKC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 17:10:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275097AbTHRVKC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 17:10:02 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:30731
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S275096AbTHRVJ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 17:09:59 -0400
Date: Mon, 18 Aug 2003 14:09:58 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: reiser@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: 2.4.22-pre lockups (now decoded oops for pre10)
Message-ID: <20030818210958.GH10320@matchmail.com>
Mail-Followup-To: Stephan von Krawczynski <skraw@ithnet.com>,
	reiser@namesys.com, linux-kernel@vger.kernel.org
References: <3F325198.2010301@namesys.com> <20030807153257.1f2f80b0.skraw@ithnet.com> <20030818202949.GD10320@matchmail.com> <20030818223946.182b0aab.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030818223946.182b0aab.skraw@ithnet.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 18, 2003 at 10:39:46PM +0200, Stephan von Krawczynski wrote:
> On Mon, 18 Aug 2003 13:29:49 -0700
> Mike Fedyk <mfedyk@matchmail.com> wrote:
> 
> > > I'd say "two things differ", without trailing "s". I am not even sure if
> > > "bitmaps" shouldn't be singular "bitmap" instead.
> > 
> > "bitmaps" with your changes would be correct.
> > 
> > Though, just turn "bitmaps" into "bitmap" and it should be fine.  I can't
> > really think of a phrase specific enough for the error message without
> > adding enough text to make it two lines, which wouldn't be good.
> > 
> > "Comparing bitmaps.. vpf-10640: The on-disk and the correct bitmap differs"
> 
> Hm, but:
> 
> "a and b differ"

1) "Comparing bitmaps.. vpf-10640: The on-disk and correct bitmap differ"

> "a differs from b"

2) "Comparing bitmaps.. vpf-10640: The on-disk differs from the correct bitmap"

> 
> or not?
> 
> Alternatives:
> 
> "a and b are different"

3) "Comparing bitmaps.. vpf-10640: The on-disk and correct are different"

> 
> But if you use "are" here, you cannot use "differs" above, right?
> 

Yes.

I kinda like (1), or the origional changed to "bitmap" instead of
"bitmaps".

Mike
