Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266186AbUH0P2f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266186AbUH0P2f (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 11:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266155AbUH0P23
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 11:28:29 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:16094 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266186AbUH0PZw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 11:25:52 -0400
Date: Fri, 27 Aug 2004 16:25:51 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: John Cherry <cherry@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 2 New compile/sparse warnings (nightly build)
Message-ID: <20040827152551.GI21964@parcelfarce.linux.theplanet.co.uk>
References: <1093619350.2467.17.camel@cherrybomb.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093619350.2467.17.camel@cherrybomb.pdx.osdl.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2004 at 08:09:10AM -0700, John Cherry wrote:
> Summary:
>    New warnings = 2
>    Fixed warnings = 8
 
Hmm...  What .config are you using?  There was a bunch of sound/oss
check_region() removals, etc.

Here I'm running builds on allmodconfig and allomodconfig with added
'SMP depends on BROKEN' to catch the BROKEN_ON_SMP drivers.
