Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283390AbRLMOJ6>; Thu, 13 Dec 2001 09:09:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283680AbRLMOJs>; Thu, 13 Dec 2001 09:09:48 -0500
Received: from hermes.toad.net ([162.33.130.251]:57482 "EHLO hermes.toad.net")
	by vger.kernel.org with ESMTP id <S283390AbRLMOJa>;
	Thu, 13 Dec 2001 09:09:30 -0500
Subject: Re: USB not processing APM suspend event properly?
From: Thomas Hood <jdthood@mail.com>
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011213103652.A8007@flint.arm.linux.org.uk>
In-Reply-To: <1008205428.3108.0.camel@thanatos> 
	<20011213103652.A8007@flint.arm.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 13 Dec 2001 09:10:18 -0500
Message-Id: <1008252621.937.0.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2001-12-13 at 05:36, Russell King wrote:
> On Wed, Dec 12, 2001 at 08:03:48PM -0500, Thomas Hood wrote:
> > But do you agree that the present code does NOT do this?
>
> Ok, thinking about this obfuscated code more, it would appear so.  It
> would also appear that when the suspend request comes from the APM bios,
> the ioctl() method will not call send_event() at all - instead it comes
> from check_events().

Yes.

> However, as I said previously, this is a minor issue.  I'd rather the
> major problem was fixed.

I agree entirely.  I think that this change should be made.
The question is 'When?'.  Is this too big a change to make
in 2.4?

Thomas

