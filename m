Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264132AbRFFT74>; Wed, 6 Jun 2001 15:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264130AbRFFT7q>; Wed, 6 Jun 2001 15:59:46 -0400
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:34063 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S264124AbRFFT7e>; Wed, 6 Jun 2001 15:59:34 -0400
Date: Wed, 6 Jun 2001 21:57:25 +0200
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Bohdan Vlasyuk <bohdan@kivc.vstu.vinnica.ua>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: isolating process..
Message-ID: <20010606215725.H27260@arthur.ubicom.tudelft.nl>
In-Reply-To: <20010605123755.B5998@kivc.vstu.vinnica.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010605123755.B5998@kivc.vstu.vinnica.ua>; from bohdan@kivc.vstu.vinnica.ua on Tue, Jun 05, 2001 at 12:37:55PM +0300
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2001 at 12:37:55PM +0300, Bohdan Vlasyuk wrote:
> Is it possible by any means to isolate any given process, so that
> it'll be unable to crash system. Suppose all the process needs is
> stdin, stdout, and CPU time. Can Linux guarantee that given process
> won't hurt system stability ? Let us soppose that we have ideal CPU
> without mistakes. How can I limit CPU time/Mem Usage for given
> process?

You just gave a nice description what an OS kernel should do :)

> Please, supply ANY suggestions.
> 
> My ideas:
> 
> create some user, and decrease his ulimits up to miminum of 1 process,
> 0 core size, appropriate memory/ etc.

That's indeed the way to do it.


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
