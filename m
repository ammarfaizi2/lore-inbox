Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261162AbUJYSus@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbUJYSus (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 14:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261237AbUJYStA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 14:49:00 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:37879 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261162AbUJYSr6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 14:47:58 -0400
From: Hollis Blanchard <hollisb@us.ibm.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch] HVSI reset support
Date: Mon, 25 Oct 2004 13:43:49 +0000
User-Agent: KMail/1.7
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1098376307.12020.42.camel@localhost> <Pine.LNX.4.58.0410211459360.2269@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0410211459360.2269@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410251343.49881.hollisb@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 21 October 2004 22:01, Linus Torvalds wrote:
> On Thu, 21 Oct 2004, Hollis Blanchard wrote:
> > Hi Linus, this patch adds support for when the service processor (the
> > other end of the console) resets due to a critical error; we can resume
> > the connection when it comes back. Please apply.
>
> Hmm.. Your revision numbers seem to imply that this is against something
> that is from before my latest tty update that touched that file (which
> removes the user/kernel pointer distractions).
>
> Just to make me happier, mind checking this with current -BK first?

I've retested and things are still fine. Do you need me to resend the 3 
patches? The originals should apply fine if you still have them.

-- 
Hollis Blanchard
IBM Linux Technology Center
