Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932334AbWFNVRm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932334AbWFNVRm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 17:17:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932352AbWFNVRm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 17:17:42 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:56983 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932334AbWFNVRl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 17:17:41 -0400
Subject: Re: [RFC] the /proc/filecache interface
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Fengguang Wu <fengguang.wu@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Lubos Lunak <l.lunak@suse.cz>,
       Dirk Mueller <dmueller@suse.de>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060612075130.GA5432@mail.ustc.edu.cn>
References: <20060612075130.GA5432@mail.ustc.edu.cn>
Content-Type: text/plain
Date: Wed, 14 Jun 2006 14:19:30 -0700
Message-Id: <1150319970.12768.58.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-12 at 15:51 +0800, Fengguang Wu wrote:
> Hello,
> 
> The /proc/filecache support has been half done. And I'd like to hear
> early comments on the interface.
> 

Wu,

Interesting work. But I am worried that, this is getting over-designed.
Lets go back to basics - what is the actual problem we are trying to
solve here ? What are mininum requirements ? How does it help solve
the problem ? Who & How one uses this ? Yes. I understand - these
just provide stats on filecache, but we can provide all the nitty
details - which are not really relevant or useful.

Don't get me wrong - I really need better understanding of whats there
in pagecache. Infact, I need a better way to control how much filecache
in pagecache. 

(BTW, I like your patch for "educational" purposes - but I am not
sure how useful it is for practical purpose).

Thanks,
Badari

