Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136748AbREAWv2>; Tue, 1 May 2001 18:51:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136749AbREAWvK>; Tue, 1 May 2001 18:51:10 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:43020
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S136748AbREAWuy>; Tue, 1 May 2001 18:50:54 -0400
Date: Tue, 01 May 2001 18:44:45 -0400
From: Chris Mason <mason@suse.com>
To: David <david@blue-labs.org>, Frank de Lange <frank@unternet.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: * Re: Severe trashing in 2.4.4
Message-ID: <69340000.988757085@tiny>
In-Reply-To: <3AEF34AE.3070601@blue-labs.org>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tuesday, May 01, 2001 03:11:58 PM -0700 David <david@blue-labs.org>
wrote:

> Can't say for a definite fact that it was reiserfs but I can say for a
> definite fact that something fishy happens sometimes.
> 
> If I have a text file open, something.html comes to mind, If I edit it
> and save it in one rxvt and open it in another rxvt, my changes may not
> be there.  If I save it *again* or exit the editing process, I will see
> the changes in the second term.  No, I'm not accidently forgetting to
> save it, I know for a fact that I saved it and the first terminal shows
> the non-modified state with the changes and the second term shows the
> previous data.
> 
> Somewhere something is stuck in cache and what's on disk isn't what's in
> cache and a second process for some reason gets what is on disk and not
> what is in cache.
> 
> It happens infrequently but it -does- happen.

Does it happen with -o notail?  Which editor?

-chris



