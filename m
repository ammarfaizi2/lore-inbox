Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319538AbSIGW6e>; Sat, 7 Sep 2002 18:58:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319539AbSIGW6e>; Sat, 7 Sep 2002 18:58:34 -0400
Received: from holomorphy.com ([66.224.33.161]:8888 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S319538AbSIGW6d>;
	Sat, 7 Sep 2002 18:58:33 -0400
Date: Sat, 7 Sep 2002 16:01:01 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Paolo Ciarrocchi <ciarrocchi@linuxmail.org>, linux-kernel@vger.kernel.org
Subject: Re: LMbench2.0 results
Message-ID: <20020907230101.GJ888@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>,
	Paolo Ciarrocchi <ciarrocchi@linuxmail.org>,
	linux-kernel@vger.kernel.org
References: <20020907121854.10290.qmail@linuxmail.org> <3D7A2768.E5C85EB@digeo.com> <20020907200334.GI888@holomorphy.com> <3D7A87F1.F3D0865C@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <3D7A87F1.F3D0865C@digeo.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 07, 2002 at 09:20:56AM -0700, Andrew Morton wrote:
>>> The fork/exec/mmap slowdown is the rmap overhead.  I have some stuff
>>> which partialy improves it.

William Lee Irwin III wrote:
>> Hmm, Where does it enter the mmap() path? PTE instantiation is only done
>> for the VM_LOCKED case IIRC. Otherwise it should be invisible.

On Sat, Sep 07, 2002 at 04:12:49PM -0700, Andrew Morton wrote:
> Oh, is that just the mmap() call itself?

I'm not actually sure what lmbench is doing.


William Lee Irwin III wrote:
>> Perhaps testing with overcommit on would be useful.

On Sat, Sep 07, 2002 at 04:12:49PM -0700, Andrew Morton wrote:
> Well yes - the new overcommit code was a significant hit on the 16ways
> was it not?  You have some numbers on that?

I don't remember the before/after numbers, but I can collect some.


Cheers,
Bill
