Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262086AbTHYS4p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 14:56:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262091AbTHYS4p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 14:56:45 -0400
Received: from inet-mail1.oracle.com ([148.87.2.201]:37262 "EHLO
	inet-mail1.oracle.com") by vger.kernel.org with ESMTP
	id S262086AbTHYS4n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 14:56:43 -0400
Date: Mon, 25 Aug 2003 11:56:19 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] limit some config options per arch.
Message-ID: <20030825185618.GA26255@ca-server1.us.oracle.com>
Mail-Followup-To: "Randy.Dunlap" <rddunlap@osdl.org>,
	Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
References: <20030825111854.5c4afdac.rddunlap@osdl.org.suse.lists.linux.kernel> <p73smnp4mbr.fsf@oldwotan.suse.de> <20030825113820.135217a7.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030825113820.135217a7.rddunlap@osdl.org>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 25, 2003 at 11:38:20AM -0700, Randy.Dunlap wrote:
> | >  config HANGCHECK_TIMER
> | >  	tristate "Hangcheck timer"
> | > +	depends on X86
> | 
> | AFAIK that's not x86 specific. It should work on other architecture too.
> 
> from willy@debian.org:
> This looks x86-specific to me,
> monotonic_clock() is in arch/i386 and arch/x86_64 only.

	That's only becuase we haven't got implementations yet.  It's
surely supposed to work on all platforms eventually.

Joel

-- 

"If you took all of the grains of sand in the world, and lined
 them up end to end in a row, you'd be working for the government!"
	- Mr. Interesting

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
