Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264613AbTEPTEu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 15:04:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264614AbTEPTEu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 15:04:50 -0400
Received: from holomorphy.com ([66.224.33.161]:21976 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264613AbTEPTEt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 15:04:49 -0400
Date: Fri, 16 May 2003 12:17:11 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Dave Jones <davej@codemonkey.org.uk>,
       Alexander Hoogerhuis <alexh@ihatent.com>,
       Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [OOPS] 2.5.69-mm6
Message-ID: <20030516191711.GX8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Dave Jones <davej@codemonkey.org.uk>,
	Alexander Hoogerhuis <alexh@ihatent.com>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <20030516015407.2768b570.akpm@digeo.com> <87fznfku8z.fsf@lapper.ihatent.com> <20030516180848.GW8978@holomorphy.com> <20030516185638.GA19669@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030516185638.GA19669@suse.de>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 16, 2003 at 01:26:20PM +0200, Alexander Hoogerhuis wrote:
>>> This one goes in -mm5 as well, machine runs fine for a while in X, but
>>> trying to switch to a vty send the machine into the tall weeds...

On Fri, May 16, 2003 at 11:08:48AM -0700, William Lee Irwin III wrote:
>> Could you run with the radeon driver non-modular and kernel debugging
>> on? Then when it oopses could you use addr2line(1) to resolve this to
>> a line number?
>> I'm at something of a loss with respect to dealing with DRM in general.

On Fri, May 16, 2003 at 07:56:38PM +0100, Dave Jones wrote:
> Not that I'm pointing fingers, but it could be that
> reslabify-pgds-and-pmds.patch again  ? Maybe it's still not quite right?
> Might be worth backing out and retesting, just to rule it out.

Yes, if he could try that too it would help. I got a private reply
saying he'd be out of the picture for over 24 hours. I'm looking for
someone with a radeon to fill in the gap until then.


-- wli
