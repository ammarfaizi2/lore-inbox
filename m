Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136997AbREJXw5>; Thu, 10 May 2001 19:52:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136998AbREJXwr>; Thu, 10 May 2001 19:52:47 -0400
Received: from intranet.resilience.com ([209.245.157.33]:17619 "EHLO
	intranet.resilience.com") by vger.kernel.org with ESMTP
	id <S136997AbREJXwo>; Thu, 10 May 2001 19:52:44 -0400
Mime-Version: 1.0
Message-Id: <p0510030cb720d6cb4ecd@[10.128.7.49]>
In-Reply-To: <200105102320.f4ANKYu21655@habitrail.home.fools-errant.com>
In-Reply-To: <200105102320.f4ANKYu21655@habitrail.home.fools-errant.com>
Date: Thu, 10 May 2001 16:52:49 -0700
To: linux-kernel@vger.kernel.org
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: Not a typewriter
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 7:20 PM -0400 2001-05-10, Hacksaw wrote:
>  >I disagree.  "Not a typewriter" is part of Unix tradition, and ought to be
>>retained as a historical reference.  It's also an opportunity for "the
>>uninitiated" to learn a little more and move a little closer to becoming "the
>>initiated."
>
>Heaven help us when tradition is more important than clarity.
>
>Typewriter has always been wrong. I'd agree that "Not a teletypewriter" would
>suffice.
>
>On the other hand "Inappropriate ioctl for device" is also not very clear.
>
>I'd like to see "Not a serial or character device" or "Not a serial device" if
>that's more appropriate. Something like that...

ENOTTY is used by several non-serial devices (or file systems) to 
object to an unrecognized ioctl command. There's also ENOIOCTLCMD 
(apparently supposed to be a non-user errno, but i don't see where it 
gets changed to something else) and EINVAL. I'm not sure what the 
rationale is for choosing among them; perhaps someone would elucidate?
-- 
/Jonathan Lundell.
