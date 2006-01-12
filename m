Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030463AbWALQQX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030463AbWALQQX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 11:16:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030459AbWALQQX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 11:16:23 -0500
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:24765 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S1030458AbWALQQT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 11:16:19 -0500
To: Greg KH <greg@kroah.com>
Cc: Adrian Bunk <bunk@stusta.de>, Linus Torvalds <torvalds@osdl.org>,
       "Brown, Len" <len.brown@intel.com>,
       "David S. Miller" <davem@davemloft.net>, linux-acpi@vger.kernel.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org, git@vger.kernel.org
Subject: Re: git pull on Linux/ACPI release tree
References: <F7DC2337C7631D4386A2DF6E8FB22B3005A13505@hdsmsx401.amr.corp.intel.com>
	<Pine.LNX.4.64.0601081111190.3169@g5.osdl.org>
	<20060108230611.GP3774@stusta.de>
	<Pine.LNX.4.64.0601081909250.3169@g5.osdl.org>
	<20060110201909.GB3911@stusta.de> <20060112013706.GA3339@kroah.com>
From: Catalin Marinas <catalin.marinas@arm.com>
Date: Thu, 12 Jan 2006 16:10:51 +0000
In-Reply-To: <20060112013706.GA3339@kroah.com> (Greg KH's message of "Wed,
 11 Jan 2006 17:37:06 -0800")
Message-ID: <tnxirspo29g.fsf@arm.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 12 Jan 2006 16:10:58.0494 (UTC) FILETIME=[C63935E0:01C61792]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> wrote:
> On Tue, Jan 10, 2006 at 09:19:09PM +0100, Adrian Bunk wrote:
>> 
>> I am using the workaround of carrying the patches in a mail folder, 
>> applying them in a batch, and not pulling from your tree between 
>> applying a batch of patches and you pulling from my tree.
>
> Ick, I'd strongly recommend using quilt for this.  It works great for
> just this kind of workflow.

Or StGIT :-). Similar workflow (and similar commands) but better
integrated with GIT and better at dealing with conflicts since it uses
a three-way merge when pushing patches rather than applying them with
"patch".

-- 
Catalin
