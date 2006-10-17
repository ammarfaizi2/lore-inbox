Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751020AbWJQN7N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751020AbWJQN7N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 09:59:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751021AbWJQN7N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 09:59:13 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:58281 "EHLO
	out1.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1751019AbWJQN7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 09:59:11 -0400
X-Sasl-enc: aNzAnebvnCm3vzh/C4E41uq0ZJj2XNDo2jYUJHrF+kys 1161093552
Subject: Re: BUG dcache.c:613 during autofs unmounting in 2.6.19rc2
From: Ian Kent <raven@themaw.net>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <1161093310.4937.37.camel@localhost>
References: <200610161658.58288.ak@suse.de>
	 <1161058535.11489.6.camel@localhost>  <200610171250.56522.ak@suse.de>
	 <1161093310.4937.37.camel@localhost>
Content-Type: text/plain
Date: Tue, 17 Oct 2006 21:59:04 +0800
Message-Id: <1161093544.4937.41.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-10-17 at 21:55 +0800, Ian Kent wrote:
> > Well it always worked this way in earlier kernels and even if the
> > wrong module was suddenly used for some reason it shouldn't BUG.
> > So something is broken.
> 
> True.
> 
> There have been some changes in this area (David Howells made some
> changes which affected autofs4) and I'm not sure that the autofs module
> was reviewed. I didn't look closely at it at the time, I guess I should
> have. Sorry.
> 
> It will take a while longer to work out if the autofs if open to the
> same issue resulting from Davids change.

Oh forgot .. I know it may be hard to do but could you try and confirm
whether it was autofs or autofs4. They are very different and I don't
want to stare at code trying to work out what's wrong if it's not
broken.

> 
> Ian
> 

