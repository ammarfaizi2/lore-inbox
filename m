Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261208AbVBGR2z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261208AbVBGR2z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 12:28:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261203AbVBGR2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 12:28:55 -0500
Received: from peabody.ximian.com ([130.57.169.10]:5550 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261208AbVBGR2G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 12:28:06 -0500
Subject: Re: 2.6.11-rc2-mm1
From: Robert Love <rml@novell.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, ttb@tentacle.dhs.org
In-Reply-To: <20050207115736.GB22948@elte.hu>
References: <20050124021516.5d1ee686.akpm@osdl.org>
	 <20050124121729.GA29392@infradead.org>  <20050207115736.GB22948@elte.hu>
Content-Type: text/plain
Date: Mon, 07 Feb 2005 12:30:20 -0500
Message-Id: <1107797420.24154.25.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-02-07 at 12:57 +0100, Ingo Molnar wrote:

Hello, Ingo.

> > Also ioctl is not an acceptable interface for adding new core
> > functionality.
> 
> seconded. Robert?

Well, I don't share the hatred for ioctl, at least compared to another
type unsafe interface like write().

But John and I are open to doing whatever is the consensus.  If there is
an agreed alternative, and that is the requirement for merging, I'll do
it.

I'd like to keep the user-space interface and simple, and absolutely
want to keep the single file descriptor approach.  How the fd is
obtained is up for discussion.

Ingo, what do you prefer?

Best,

	Robert Love


