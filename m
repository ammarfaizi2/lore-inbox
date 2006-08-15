Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030207AbWHOKy2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030207AbWHOKy2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 06:54:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030218AbWHOKy2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 06:54:28 -0400
Received: from gwmail.nue.novell.com ([195.135.221.19]:43401 "EHLO
	emea5-mh.id5.novell.com") by vger.kernel.org with ESMTP
	id S1030207AbWHOKy1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 06:54:27 -0400
Message-Id: <44E1C40F.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Tue, 15 Aug 2006 12:54:39 +0200
From: "Jan Beulich" <jbeulich@novell.com>
To: "Andi Kleen" <ak@muc.de>
Cc: "Chuck Ebbert" <76306.1226@compuserve.com>,
       "Jesper Juhl" <jesper.juhl@gmail.com>, "Andrew Morton" <akpm@osdl.org>,
       "Dave Jones" <davej@redhat.com>, "Andi Kleen" <ak@suse.de>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: Re: [patch] i386: fix one case of stuck dwarf2 unwinder II
References: <200608061212_MC3-1-C747-C2AD@compuserve.com>
 <44D70F42.76E4.0078.0@novell.com> <200608071004.37849.ak@suse.de>
 <44E1BF37.76E4.0078.0@novell.com> <20060815124709.e62d9c57.ak@muc.de>
In-Reply-To: <20060815124709.e62d9c57.ak@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> which I'd like to
>> continue to reflect/catch through arch_unw_user_mode().
>
>Ok, but does it work now? I thought it didn't.
>I've also seen a stuck on the x86-64 sysenter path on x86-64.

That's the next thing for me to look into.

Jan
