Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267564AbRGZCeL>; Wed, 25 Jul 2001 22:34:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267576AbRGZCeB>; Wed, 25 Jul 2001 22:34:01 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:32787 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S267564AbRGZCdn>; Wed, 25 Jul 2001 22:33:43 -0400
Message-ID: <3B5F830D.CAC71A18@zip.com.au>
Date: Thu, 26 Jul 2001 12:40:13 +1000
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.7-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Gerald Walden <thepond@charter.net>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: debug of a kernel panic leading nowhere...
In-Reply-To: <20010726015721Z267509-720+6404@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Gerald Walden wrote:
> ...
> During the rmmod of a fairly simple driver, I get a kernel
> panic which crashes the system.  I believe I have taken all
> the proper steps to attempt to debug the problem to no
> avail.
> 
> Any suggestions as to how to move further, or how to frame
> this question in a more appropriate manner for this list (or
> perhaps there is a more appropriate list that I should be
> sending this to) would greatly be appreciated.

You have the right list, although your email headers are
strange.

>From the backtrace it appears that perhaps a pending timer has not
been correctly removed prior to module removal, but that's really
just a guess - the backtrace isn't clear.

Is the problem repeatable?  What driver is being removed?


-
