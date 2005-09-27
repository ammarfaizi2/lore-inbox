Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750866AbVI0OEh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750866AbVI0OEh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 10:04:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750920AbVI0OEh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 10:04:37 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:20381 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S1750866AbVI0OEg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 10:04:36 -0400
Date: Tue, 27 Sep 2005 10:04:34 -0400
To: Grant Coady <grant_lkml@dodo.com.au>
Cc: Rog?rio Brito <rbrito@ime.usp.br>, linux-kernel@vger.kernel.org
Subject: Re: Strange disk corruption with Linux >= 2.6.13
Message-ID: <20050927140434.GL28578@csclub.uwaterloo.ca>
References: <20050927111038.GA22172@ime.usp.br> <9ncij11fqb4l70qrhb0a8nri5moohnkaaf@4ax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ncij11fqb4l70qrhb0a8nri5moohnkaaf@4ax.com>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2005 at 09:57:52PM +1000, Grant Coady wrote:
> Probably not, I had a similar problem recently and for a test case 
> copied a .iso image file then compared it to original (cp + cmp), 
> turned out to be bad memory, and yes, memtest86 did not find the 
> problem.  Check mobo datasheet if 2+ double-sided memory allowed, 
> you may need to stay at 1GB to reduce bus loading.

The board is allowed 1.5GB using 3 x 512M.  I believe the 512M modules
must be double sided to work but I am not 100% sure of that.

It is also generally unstable if set to anything over PC100 memory speed
in my experience (my machine has the same board).  The memory speed
detection doesn't work properly.  I have found it perfectly stable when
set to PC100 in bios and using PC133 memory.  It seems to prefer having
the extra margin.

I have never personally had more than 2 x 256M on mine.

Len Sorensen
