Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751451AbWCGSlG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751451AbWCGSlG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 13:41:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751450AbWCGSlF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 13:41:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:31957 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751451AbWCGSlE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 13:41:04 -0500
From: Andi Kleen <ak@suse.de>
To: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] Document Linux's memory barriers
Date: Tue, 7 Mar 2006 12:13:46 +0100
User-Agent: KMail/1.9.1
Cc: torvalds@osdl.org, akpm@osdl.org, mingo@redhat.com,
       linux-arch@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
References: <200603071134.52962.ak@suse.de> <31492.1141753245@warthog.cambridge.redhat.com> <7621.1141756240@warthog.cambridge.redhat.com>
In-Reply-To: <7621.1141756240@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603071213.47885.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 March 2006 19:30, David Howells wrote:

> > You're not supposed to do it this way anyways. The official way to access
> > MMIO space is using read/write[bwlq]
> 
> True, I suppose. I should make it clear that these accessor functions imply
> memory barriers, if indeed they do, 

I don't think they do.

> and that you should use them rather than 
> accessing I/O registers directly (at least, outside the arch you should).

Even inside the architecture it's a good idea.

-Andi

