Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266919AbRGYLMo>; Wed, 25 Jul 2001 07:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268556AbRGYLMe>; Wed, 25 Jul 2001 07:12:34 -0400
Received: from anchor-post-34.mail.demon.net ([194.217.242.92]:17677 "EHLO
	anchor-post-34.mail.demon.net") by vger.kernel.org with ESMTP
	id <S266919AbRGYLMU>; Wed, 25 Jul 2001 07:12:20 -0400
Date: Wed, 25 Jul 2001 12:12:16 +0100
From: "Robert J.Dunlop" <rjd@xyzzy.clara.co.uk>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Barry Wu <wqb123@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: about serial console problem
Message-ID: <20010725121216.A2481@xyzzy.clara.co.uk>
In-Reply-To: <20010723065212.31153.qmail@web13901.mail.yahoo.com> <m17kwyhyuz.fsf@frodo.biederman.org> <20010724232909.A27546@xyzzy.clara.co.uk> <m1r8v5gzm1.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <m1r8v5gzm1.fsf@frodo.biederman.org>; from ebiederm@xmission.com on Wed, Jul 25, 2001 at 02:52:06AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Wed, Jul 25,  Eric W. Biederman wrote:
> "Robert J.Dunlop" <rjd@xyzzy.clara.co.uk> writes:
> > Actually more and more have been implementing
> > it as we go through 2.4.x, depends when your particular driver got caught.
> 
> Do you know the history on how/why ~CREAD support started showing in
> in the linux kernels.  I'd like to understand what is going on.

Sorry! I've red herringed you here. Most drivers were fixed way back in
2.2.x or before. From the Changelog we have:

  Fri Nov  8 20:19:50 1996  Theodore Ts'o  <tytso@rsts-11.mit.edu>
    * serial.c (change_speed): Add support for CREAD, as required by POSIX

I just happed to notice the late change on a couple of third party drivers
and jumped to the wrong conclusion.

-- 
        Bob Dunlop                      FarSite Communications
        rjd@xyzzy.clara.co.uk           bob.dunlop@farsite.co.uk
        www.xyzzy.clara.co.uk           www.farsite.co.uk
