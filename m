Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267601AbSIRQqE>; Wed, 18 Sep 2002 12:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267603AbSIRQqE>; Wed, 18 Sep 2002 12:46:04 -0400
Received: from holomorphy.com ([66.224.33.161]:5611 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267601AbSIRQqC>;
	Wed, 18 Sep 2002 12:46:02 -0400
Date: Wed, 18 Sep 2002 09:45:53 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, Andries Brouwer <aebr@win.tue.nl>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] lockless, scalable get_pid(), for_each_process() elimination, 2.5.35-BK
Message-ID: <20020918164553.GB28202@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ingo Molnar <mingo@elte.hu>,
	Linus Torvalds <torvalds@transmeta.com>,
	Andries Brouwer <aebr@win.tue.nl>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0209180906460.1913-100000@home.transmeta.com> <Pine.LNX.4.44.0209181835150.23619-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209181835150.23619-100000@localhost.localdomain>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2002 at 06:41:47PM +0200, Ingo Molnar wrote:
> i agree that this is okay, as an added mechanism. Nevertheless this does
> not eliminate the 'box locks up for seconds' (or even minutes) situation.  

The lockups I see range from hours to "it spun over the weekend, time
to pull the plug".


Bill
