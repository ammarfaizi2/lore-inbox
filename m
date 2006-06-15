Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750762AbWFOBCx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762AbWFOBCx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 21:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750795AbWFOBCx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 21:02:53 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:29619 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S1750762AbWFOBCw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 21:02:52 -0400
Message-ID: <350333369.20847@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Thu, 15 Jun 2006 09:03:16 +0800
From: Fengguang Wu <fengguang.wu@gmail.com>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Lubos Lunak <l.lunak@suse.cz>,
       Dirk Mueller <dmueller@suse.de>, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC] the /proc/filecache interface
Message-ID: <20060615010316.GB5013@mail.ustc.edu.cn>
Mail-Followup-To: Fengguang Wu <fengguang.wu@gmail.com>,
	Badari Pulavarty <pbadari@us.ibm.com>,
	lkml <linux-kernel@vger.kernel.org>, Lubos Lunak <l.lunak@suse.cz>,
	Dirk Mueller <dmueller@suse.de>, Andrew Morton <akpm@osdl.org>
References: <20060612075130.GA5432@mail.ustc.edu.cn> <1150319970.12768.58.camel@dyn9047017100.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1150319970.12768.58.camel@dyn9047017100.beaverton.ibm.com>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2006 at 02:19:30PM -0700, Badari Pulavarty wrote:
> Interesting work. But I am worried that, this is getting over-designed.
> Lets go back to basics - what is the actual problem we are trying to
> solve here ? What are mininum requirements ? How does it help solve
> the problem ? Who & How one uses this ? Yes. I understand - these
> just provide stats on filecache, but we can provide all the nitty
> details - which are not really relevant or useful.
> 
> Don't get me wrong - I really need better understanding of whats there
> in pagecache. Infact, I need a better way to control how much filecache
> in pagecache. 
> 
> (BTW, I like your patch for "educational" purposes - but I am not
> sure how useful it is for practical purpose).

Badari,

Thanks for the comment. The interface does provides some more details
than I will actually need. The intention is to show the possibilities
in the first place, and trim down / expand a bit based on feedbacks.

For the GUI pre-caching stuffs I'm working on, the following features
will be essential ones:
        - file list view
                - sorted roughly on the first access time
                - the size/cached/dev/file attributes
        - page list view
                - the idx/len/state attributes
                - the referenced/active/mmap page flags

Thanks,
Wu
