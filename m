Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261397AbTITFKc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Sep 2003 01:10:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261442AbTITFKc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Sep 2003 01:10:32 -0400
Received: from holomorphy.com ([66.224.33.161]:23262 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261397AbTITFKb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Sep 2003 01:10:31 -0400
Date: Fri, 19 Sep 2003 22:11:36 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BUG at mm/memory.c:1501 in 2.6.0-test5
Message-ID: <20030920051136.GE4306@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Petr Vandrovec <VANDROVE@vc.cvut.cz>, linux-kernel@vger.kernel.org
References: <95932E0ADB@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95932E0ADB@vcnet.vc.cvut.cz>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 Sep 03 at 13:43, William Lee Irwin III wrote:
>> This is probably the reason you're not getting much in the way of a
>> response.

On Thu, Sep 18, 2003 at 11:10:06PM +0200, Petr Vandrovec wrote:
> I explicitly stated that it happened shortly after I shut down VMware UI,
> and that I spent whole day trying to find what's going on, finally
> politely asking for help, hoping that someone could have a clue
> what went wrong.

Much better. I presumed something like nvidia. Now that that's cleared
up, I'll have to find time to take a breather and peek at the vmware bits
to see if they're doing anything that might get misunderstood by the VM.

One thing to look for in vmware if you have the time/motivation
yourself is to check for dirty bits getting left in (or put into) non-
present ptes; this clashes with _PTE_FILE on i386.


-- wli
