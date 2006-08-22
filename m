Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751356AbWHVIbj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751356AbWHVIbj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 04:31:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751344AbWHVIbj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 04:31:39 -0400
Received: from gwmail.nue.novell.com ([195.135.221.19]:10944 "EHLO
	emea5-mh.id5.novell.com") by vger.kernel.org with ESMTP
	id S1751356AbWHVIbj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 04:31:39 -0400
Message-Id: <44EADD1A.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Tue, 22 Aug 2006 10:31:54 +0200
From: "Jan Beulich" <jbeulich@novell.com>
To: "Andi Kleen" <ak@suse.de>
Cc: "J. Bruce Fields" <bfields@fieldses.org>, "Andrew Morton" <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>, "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: boot failure, "DWARF2 unwinder stuck at 0xc0100199"
References: <20060820013121.GA18401@fieldses.org>
 <20060821212043.332fdd0f.akpm@osdl.org> <44EAD613.76E4.0078.0@novell.com>
 <200608221022.59255.ak@suse.de>
In-Reply-To: <200608221022.59255.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >Guys, this unwinder change has been quite problematic.  We really cannot
>> >let this badness out into 2.6.18 - it degrades our ability to debug every
>> >subsystem in the entire kernel.  Would marking it CONFIG_BROKEN get us back
>> >to 2.6.17 behaviour?
>> 
>> I'd prefer pushing into 2.6.18 some of the patches currently scheduled for
>> 2.6.19 over marking it CONFIG_BROKEN. But that's clearly not my decision.
>
>Hmm, which patches did you want? I got a double digit number of unwind
>related patches already, some of them quite intrusive, and all of them would be clearly
>too much. My preference for 2.6.18 would be really only absolutely critical stuff
>because I'm paranoid of breaking more.

I was thinking of the fixes to the fallback logic and the bottom-of-stack annotations.

Jan
