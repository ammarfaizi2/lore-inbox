Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316606AbSEPI7r>; Thu, 16 May 2002 04:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316608AbSEPI7q>; Thu, 16 May 2002 04:59:46 -0400
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:2313 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316606AbSEPI7q>; Thu, 16 May 2002 04:59:46 -0400
Date: Thu, 16 May 2002 09:59:40 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre8aa3
Message-ID: <20020516095940.A5912@flint.arm.linux.org.uk>
In-Reply-To: <20020516020134.GC1025@dualathlon.random> <Pine.LNX.4.44L.0205152303500.32261-100000@imladris.surriel.com> <20020516023238.GE1025@dualathlon.random> <20020516093630.B5540@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2002 at 09:36:30AM +0100, Russell King wrote:
> Have you thought about reading Documentation/initrd.txt and following
> the described method?  (last modified December 2000 according to the
> comments and the mtime on the file).
> 
> The method you're using has therefore been marked "obsolete" for almost
> two and a half years:

Of course that's one and a half.  initrd.txt changed in 2.4.0-test12
to be exact.

However, we shouldn't break the old initrd method in 2.4 - that's
what 2.5 is for, but ext3 is a new feature introduced after in 2.4.9.

So, the question becomes - is it reasonable to expect new features
introduced in a stable kernel series to work with obsolete methods
that have already been replaced with far better solutions.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

