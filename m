Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932281AbVHWAUL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932281AbVHWAUL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 20:20:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932252AbVHWAUK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 20:20:10 -0400
Received: from mx1.suse.de ([195.135.220.2]:49109 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932281AbVHWAUJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 20:20:09 -0400
Date: Tue, 23 Aug 2005 02:20:07 +0200
From: Andi Kleen <ak@suse.de>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@osdl.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: [patch 2.6.13-rc6] i386: fix incorrect FP signal delivery
Message-ID: <20050823022007.0b7603c1@basil.nowhere.org>
In-Reply-To: <200508221945_MC3-1-A7EF-CB11@compuserve.com>
References: <200508221945_MC3-1-A7EF-CB11@compuserve.com>
X-Mailer: Sylpheed-Claws 1.0.3 (GTK+ 1.2.10; x86_64-suse-linux)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Aug 2005 19:43:57 -0400
Chuck Ebbert <76306.1226@compuserve.com> wrote:

>   This patch fixes a problem with incorrect floating-point exception
> signal delivery on i386 kernels.  In some cases, an error code of zero
> is delivered instead of the correct code, as the output from my test
> program shows:

...

How about you describe what you actually changed and why so that not 
every reviewer has to look up all the bits in the manual?

-Andi

