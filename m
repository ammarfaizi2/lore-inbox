Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265818AbRFYA1s>; Sun, 24 Jun 2001 20:27:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265817AbRFYA1i>; Sun, 24 Jun 2001 20:27:38 -0400
Received: from munchkin.spectacle-pond.org ([209.192.197.45]:22547 "EHLO
	munchkin.spectacle-pond.org") by vger.kernel.org with ESMTP
	id <S265818AbRFYA1Y>; Sun, 24 Jun 2001 20:27:24 -0400
Date: Sun, 24 Jun 2001 20:26:54 -0400
From: Michael Meissner <meissner@spectacle-pond.org>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: sizeof problem in kernel modules
Message-ID: <20010624202654.B30355@munchkin.spectacle-pond.org>
In-Reply-To: <19093.993348744@ocs3.ocs-net> <Pine.LNX.3.95.1010623224028.22442A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.3.95.1010623224028.22442A-100000@chaos.analogic.com>; from root@chaos.analogic.com on Sat, Jun 23, 2001 at 10:43:14PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 23, 2001 at 10:43:14PM -0400, Richard B. Johnson wrote:
> Previous to the "Draft" "Proposal" of C98, there were no such
> requirements. And so-called ANSI -C specifically declined to
> define any order within structures.

As one of the founding members of the X3J11 ANSI committee, and having served
on the committee for 10 1/2 years, I can state categorically that Appendix A of
the original K&R (which was one of the 3 base documents for ANSI C) had the
requirement that non-bitfield fields are required to have monotonically
increasing addresses (bitfields don't have addresses, and different compiler
ABIs do lay them out in different fashions within the words).  C89 never
changed the wording that mandates this.

-- 
Michael Meissner, Red Hat, Inc.  (GCC group)
PMB 198, 174 Littleton Road #3, Westford, Massachusetts 01886, USA
Work:	  meissner@redhat.com		phone: +1 978-486-9304
Non-work: meissner@spectacle-pond.org	fax:   +1 978-692-4482
