Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269295AbUIYJo7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269295AbUIYJo7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 05:44:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269296AbUIYJo7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 05:44:59 -0400
Received: from holomorphy.com ([207.189.100.168]:28902 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269295AbUIYJo4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 05:44:56 -0400
Date: Sat, 25 Sep 2004 02:44:45 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Jon Masters <jonmasters@gmail.com>
Cc: Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: Add wait_event_timeout()
Message-ID: <20040925094445.GK9106@holomorphy.com>
References: <20040925091359.GA4431@dyn-67.arm.linux.org.uk> <35fb2e590409250242dd353d9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35fb2e590409250242dd353d9@mail.gmail.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Sep 2004 10:13:59 +0100, Russell King <rmk@arm.linux.org.uk> wrote:
>> There appears to be one case missing from the wait_event() family -
>> the uninterruptible timeout wait.  The following patch adds this.

On Sat, Sep 25, 2004 at 10:42:15AM +0100, Jon Masters wrote:
> Any reason it's called wait_event_timeout then rather than
> wait_event_uninterruptible_timeout?

Anything interruptible is explicitly tagged as such; the "default",
sadly enough, is uninterruptible.


-- wli
