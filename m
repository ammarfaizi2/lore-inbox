Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262016AbVGJSYn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262016AbVGJSYn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 14:24:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262010AbVGJSWq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 14:22:46 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:19658 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S262012AbVGJSWO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 14:22:14 -0400
Subject: Re: share/private/slave a subtree - define vs enum
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Bryan Henderson <hbryan@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       bfields@fieldses.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, linuxram@us.ibm.com, mike@waychison.com,
       Miklos Szeredi <miklos@szeredi.hu>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <Pine.LNX.4.61.0507082154090.3728@scrub.home>
References: <OFB01287B5.D35EDB80-ON88257038.005DEE97-88257038.005EDB8B@us.ibm.com>
	 <courier.42CEC422.00001C6C@courier.cs.helsinki.fi>
	 <Pine.LNX.4.61.0507082108530.3728@scrub.home>
	 <1120851221.9655.17.camel@localhost>
	 <Pine.LNX.4.61.0507082154090.3728@scrub.home>
Date: Sun, 10 Jul 2005 21:21:42 +0300
Message-Id: <1121019702.20821.17.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.2.1.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roman,

At some point in time, I wrote:
> > Roman, it is not as if I get to decide for the patch submitters. I
> > comment on any issues _I_ have with the patch and the authors fix
> > whatever they want (or what the maintainers ask for).

On Fri, 2005-07-08 at 21:59 +0200, Roman Zippel wrote:
> The point of a review is to comment on things that _need_ fixing. Less 
> experienced hackers take this a requirement for their drivers to be 
> included.

Hmm. So we disagree on that issue as well. I think the point of review
is to improve code and help others conform with the existing coding
style which is why I find it strange that you're suggesting me to limit
my comments to a subset you agree with.

Would you please be so kind to define your criteria for things that
"need fixing" so we could see if can reach some sort of an agreement on
this. My list is roughly as follows:

  - Erroneous use of kernel API
  - Bad coding style
  - Layering violations
  - Duplicate code
  - Hard to read code

			Pekka

