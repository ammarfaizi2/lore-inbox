Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318141AbSGWRql>; Tue, 23 Jul 2002 13:46:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318143AbSGWRql>; Tue, 23 Jul 2002 13:46:41 -0400
Received: from holomorphy.com ([66.224.33.161]:56972 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S318141AbSGWRqk>;
	Tue, 23 Jul 2002 13:46:40 -0400
Date: Tue, 23 Jul 2002 10:49:42 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Paul Larson <plars@austin.ibm.com>
Cc: Rik van Riel <riel@conectiva.com.br>, lkml <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org, haveblue@us.ibm.com
Subject: Re: [OOPS] 2.5.27 - __free_pages_ok()
Message-ID: <20020723174942.GL919@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Paul Larson <plars@austin.ibm.com>,
	Rik van Riel <riel@conectiva.com.br>,
	lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
	haveblue@us.ibm.com
References: <Pine.LNX.4.44L.0207221704120.3086-100000@imladris.surriel.com> <1027377273.5170.37.camel@plars.austin.ibm.com> <20020722225251.GG919@holomorphy.com> <1027446044.7699.15.camel@plars.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <1027446044.7699.15.camel@plars.austin.ibm.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-07-22 at 17:52, William Lee Irwin III wrote:
>> ISTR this compiler having code generation problems. I think trying to
>> reproduce this with a working i386 compiler is in order, e.g. debian's
>> 2.95.4 or some similarly stable version.

On Tue, Jul 23, 2002 at 12:40:43PM -0500, Paul Larson wrote:
> That's exactly the one I was planning on trying it with.  Tried it this
> morning with the same error.  Three compilers later, I think this is
> looking less like a compiler error.  Any ideas?

Stands a good chance of being fixed by the recent rmap.c bugfix posted
by Rik. I'm seeing deadlocks every other boot over here, the cause of
which I've not yet been able to discover.

Cheers,
Bill
