Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262078AbTJILa5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 07:30:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262081AbTJILa4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 07:30:56 -0400
Received: from colin2.muc.de ([193.149.48.15]:56338 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S262078AbTJILa4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 07:30:56 -0400
Date: 9 Oct 2003 13:31:11 +0200
Date: Thu, 9 Oct 2003 13:31:11 +0200
From: Andi Kleen <ak@colin2.muc.de>
To: Muli Ben-Yehuda <mulix@mulix.org>
Cc: Andi Kleen <ak@muc.de>, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, bos@serpentine.com
Subject: Re: [PATCH] Fix mlockall for PROT_NONE mappings
Message-ID: <20031009113111.GA48461@colin2.muc.de>
References: <20031009104218.GA1935@averell> <20031009104918.GB4699@actcom.co.il> <20031009112245.GA59762@colin2.muc.de> <20031009112458.GE4699@actcom.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031009112458.GE4699@actcom.co.il>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I agree that improved readability is not "essential". Do you agree
> that it's preferable?  

I don't think this version is particularly unreadable or that your
change would improve it very much.
(to make any sense of a function with 6+ arguments you have to look
at the function definition, no way around that, and there is a comment
that explains it there), so I don't think the change is particularly
important.

-Andi
