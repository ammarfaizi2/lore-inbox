Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261560AbREOVWi>; Tue, 15 May 2001 17:22:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261559AbREOVW3>; Tue, 15 May 2001 17:22:29 -0400
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:44516 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S261558AbREOVWU>; Tue, 15 May 2001 17:22:20 -0400
Date: Tue, 15 May 2001 17:22:19 -0400
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: LANANA: To Pending Device Number Registrants
Message-ID: <20010515172219.A5508@cs.cmu.edu>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.10.10105151028380.22038-100000@www.transvirtual.com> <Pine.LNX.4.21.0105151043360.2112-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <Pine.LNX.4.21.0105151043360.2112-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Tue, May 15, 2001 at 11:04:27AM -0700
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2001 at 11:04:27AM -0700, Linus Torvalds wrote:
> And using ASCII names ("eject") instead of numbers (see the "FDEJECT" and
> "CDROMEJECT" etc #defines) sure as hell makes for easier maintenance and
> avoids the whole issue of maintaining static numbers (all the same things
> that make me hate device number maintenance makes me also hate the fact
> that we need to maintain this list of ioctl numbers etc). By using
> descriptive names, the "maintenance" simple does not exist.

If people couldn't even agree on using the same ioctl number, why
would they agree on using the same ASCII name? In other words, there
will still be maintenance, it just moves the problem into a different
(and hopefully more maintainable) 'namespace'.

Jan

