Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264385AbTLGJhb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 04:37:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264388AbTLGJhb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 04:37:31 -0500
Received: from holomorphy.com ([199.26.172.102]:32984 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264385AbTLGJha (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 04:37:30 -0500
Date: Sun, 7 Dec 2003 01:36:22 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: Mark Symonds <mark@symonds.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.23 hard lock, 100% reproducible.
Message-ID: <20031207093622.GW8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Keith Owens <kaos@ocs.com.au>, Mark Symonds <mark@symonds.net>,
	linux-kernel@vger.kernel.org
References: <20031207090723.GV8039@holomorphy.com> <29654.1070788614@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29654.1070788614@ocs3.intra.ocs.com.au>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 07, 2003 at 01:04:41AM -0800, Mark Symonds wrote:
>> I'm not a kernel developer, but here goes: 
>> puggy:/usr/src/linux/2.4.23# addr2line c02363dd -e vmlinux
>> ??:0

On Sun, Dec 07, 2003 at 08:16:54PM +1100, Keith Owens wrote:
> addr2line requires compiling with -g.  You can also do
>   ksymoops -m /path/to/your/System.map -A c02363dd
> which does not require a recompile.

That certainly would have been faster; I'll suggest that first next
time (though addr2line has the small advantage of handing back a line
number).


-- wli
