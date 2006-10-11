Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965179AbWJKIru@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965179AbWJKIru (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 04:47:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965180AbWJKIru
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 04:47:50 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:50348 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965179AbWJKIrt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 04:47:49 -0400
Subject: Re: RSS accounting (was: Re: 2.6.19-rc1-mm1)
From: Arjan van de Ven <arjan@infradead.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>, linux-mm@kvack.org,
       Nick Piggin <npiggin@suse.de>
In-Reply-To: <m11wpfohg7.fsf@ebiederm.dsl.xmission.com>
References: <20061010000928.9d2d519a.akpm@osdl.org>
	 <1160464800.3000.264.camel@laptopd505.fenrus.org>
	 <20061010004526.c7088e79.akpm@osdl.org>
	 <1160467401.3000.276.camel@laptopd505.fenrus.org>
	 <1160486087.25613.52.camel@taijtu>
	 <1160496790.3000.319.camel@laptopd505.fenrus.org>
	 <m11wpfohg7.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Wed, 11 Oct 2006 10:47:42 +0200
Message-Id: <1160556462.3000.359.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-10-10 at 17:54 -0600, Eric W. Biederman wrote:

> For processes shared pages are not special.

depends on what question you want to answer with RSS.
If the question is "workload working set size" then you are right. If
the question is "how much ram does my application cause to be used" the
answer is FAR less clear....

You seem to have an implicit definition on what RSS should mean; but
it's implicit. Mind making an explicit definition of what RSS should be
in your opinion? I think that's the biggest problem we have right now;
several people have different ideas about what it should/could be, and
as such we're not talking about the same thing. Lets first agree/specify
what it SHOULD mean, and then we can figure out what gets counted for
that ;)


