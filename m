Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267957AbUH0Vsm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267957AbUH0Vsm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 17:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268860AbUH0Vpl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 17:45:41 -0400
Received: from holomorphy.com ([207.189.100.168]:36769 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268788AbUH0VnH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 17:43:07 -0400
Date: Fri, 27 Aug 2004 14:42:49 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-mm1
Message-ID: <20040827214249.GW2793@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040826014745.225d7a2c.akpm@osdl.org> <20040827043132.GJ2793@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040827043132.GJ2793@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2004 at 01:47:45AM -0700, Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc1/2.6.9-rc1-mm1/
[...]

On Thu, Aug 26, 2004 at 09:31:32PM -0700, William Lee Irwin III wrote:
> Hmm. Something odd is going on; initcall_debug doesn't seem to function
> as expected. It reports strings with "queue" as a substring instead of
> the expected function names. There may be a bootstrap ordering issue
> (though apparently benign, just initcall_debug) with kallsyms bits.

I suspect endianness; sparc64 is affected, but not x86-64. Now checking
kallsyms lookup -related results on ppc64...


-- wli
