Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261718AbUJ1Pct@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261718AbUJ1Pct (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 11:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261693AbUJ1Pad
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 11:30:33 -0400
Received: from out009pub.verizon.net ([206.46.170.131]:50608 "EHLO
	out009.verizon.net") by vger.kernel.org with ESMTP id S261728AbUJ1PZ1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 11:25:27 -0400
Message-ID: <41810F66.90308@verizon.net>
Date: Thu, 28 Oct 2004 11:25:26 -0400
From: Jim Nelson <james4765@verizon.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthew Wilcox <matthew@wil.cx>
CC: kernel-janitors@lists.osdl.org, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: [KJ] [PATCH 7/9] to arch/sparc/Kconfig
References: <20041028150029.2776.69333.50087@localhost.localdomain> <20041028150111.2776.47585.86377@localhost.localdomain> <20041028151336.GA10769@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20041028151336.GA10769@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at out009.verizon.net from [209.158.211.53] at Thu, 28 Oct 2004 10:25:26 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox wrote:
> On Thu, Oct 28, 2004 at 10:01:12AM -0500, james4765@verizon.net wrote:
> 
>>Description: Add default for SUN4 in arch/sparc/Kconfig.
>>Apply against 2.6.9.
> 
> 
> The default is already "no".  This patch seems pointless.
> 

Err, you're right.  Unless it is better to have a default on all configuration items.

That'd fix the "# THIS_OPTION is not set" notes in .config, but that's a bit of 
heavy lifting, going through all of the Kconfig files.

Opinions?
