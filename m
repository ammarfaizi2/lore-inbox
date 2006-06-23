Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932913AbWFWHbl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932913AbWFWHbl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 03:31:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932914AbWFWHbl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 03:31:41 -0400
Received: from rwcrmhc15.comcast.net ([216.148.227.155]:65513 "EHLO
	rwcrmhc15.comcast.net") by vger.kernel.org with ESMTP
	id S932913AbWFWHbk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 03:31:40 -0400
Message-ID: <449B98D1.3010005@namesys.com>
Date: Fri, 23 Jun 2006 00:31:29 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nate Diller <nate.diller@gmail.com>
CC: Nick Piggin <npiggin@suse.de>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       David Howells <dhowells@redhat.com>,
       Christoph Lameter <christoph@lameter.com>,
       Martin Bligh <mbligh@google.com>, Linus Torvalds <torvalds@osdl.org>,
       "E. Gryaznova" <grev@namesys.com>
Subject: Re: [PATCH] mm/tracking dirty pages: update get_dirty_limits for
 mmap tracking
References: <5c49b0ed0606211001s452c080cu3f55103a130b78f1@mail.gmail.com>	 <20060621180857.GA6948@wotan.suse.de> <5c49b0ed0606211525i57628af5yaef46ee4e1820339@mail.gmail.com>
In-Reply-To: <5c49b0ed0606211525i57628af5yaef46ee4e1820339@mail.gmail.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nate, you should note that A: increasing to 80% was my idea, and B: the
data from the benchmarks provide no indication that it is a good idea.

That said, it is very possible that C: the benchmark is flawed, because
the variance is so high that I am suspicious that something is wrong
with the benchmark, and D: that the implementation is flawed in some way
we don't yet see.

All that said, I cannot say that we have anything here that suggests the
change is a good change.   My intuition says it should be a good change,
but the data does not.  Not yet. 

Hans
