Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261862AbUEFMIV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261862AbUEFMIV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 08:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262052AbUEFMIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 08:08:21 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:19348 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261862AbUEFMIU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 08:08:20 -0400
Date: Thu, 6 May 2004 09:09:08 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Chris Wright <chrisw@osdl.org>
Cc: linux-kernel@vger.kernel.org, Manfred Spraul <manfred@colorfullife.com>,
       Andrew Morton <akpm@osdl.org>, Jakub Jelinek <jakub@redhat.com>
Subject: Re: [PATCH] per-user signal pending and message queue limits
Message-ID: <20040506120907.GB3133@logos.cnet>
References: <20040420163443.7347da48.akpm@osdl.org> <20040421203456.GC16891@logos.cnet> <40875944.4060405@colorfullife.com> <20040427145424.GA10530@logos.cnet> <408EA1DF.6050303@colorfullife.com> <20040428170932.GA14993@logos.cnet> <20040428183315.T22989@build.pdx.osdl.net> <20040429121739.GB18352@logos.cnet> <20040429125820.O21045@build.pdx.osdl.net> <20040505170811.W22989@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040505170811.W22989@build.pdx.osdl.net>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 05, 2004 at 05:08:11PM -0700, Chris Wright wrote:
> * Chris Wright (chrisw@osdl.org) wrote:
> > OK, here it is.
> 
> That last patch left the mqueue rlimit bits alone (was only an update to
> the signal side).  After looking more closely at the mqueue side I have
> the comments below:

Great, you have gone deeper analysis. This looks much better.

Thanks!
