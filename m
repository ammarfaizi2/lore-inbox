Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262210AbSLFPFV>; Fri, 6 Dec 2002 10:05:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262360AbSLFPFV>; Fri, 6 Dec 2002 10:05:21 -0500
Received: from holomorphy.com ([66.224.33.161]:27279 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S262210AbSLFPFT>;
	Fri, 6 Dec 2002 10:05:19 -0500
Date: Fri, 6 Dec 2002 07:12:38 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Arjan van de Ven <arjanv@redhat.com>, Andrea Arcangeli <andrea@suse.de>,
       Andrew Morton <akpm@digeo.com>, Norman Gaywood <norm@turing.une.edu.au>,
       linux-kernel@vger.kernel.org
Subject: Re: Maybe a VM bug in 2.4.18-18 from RH 8.0?
Message-ID: <20021206151238.GE11023@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Arjan van de Ven <arjanv@redhat.com>,
	Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@digeo.com>,
	Norman Gaywood <norm@turing.une.edu.au>,
	linux-kernel@vger.kernel.org
References: <20021206111326.B7232@turing.une.edu.au> <3DEFF69F.481AB823@digeo.com> <20021206011733.GF1567@dualathlon.random> <3DEFFEAA.6B386051@digeo.com> <20021206014429.GI1567@dualathlon.random> <20021206021559.GK9882@holomorphy.com> <1039170975.1432.5.camel@laptop.fenrus.com> <20021206142302.GC11023@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021206142302.GC11023@holomorphy.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 06, 2002 at 11:36:15AM +0100, Arjan van de Ven wrote:
>> United Linux at least has tested this according to
>> http://www.unitedlinux.com/en/press/pr111902.html
>> Hardware functionality is exploited through advanced features such as
>> large memory support for up to 64 GB of RAM
>> so I'm sure Andrea's VM deals with it gracefully

On Fri, Dec 06, 2002 at 06:23:02AM -0800, William Lee Irwin III wrote:
> I'm not convinced of grace even if I were to take it from this that it
> were directly tested, which seems doubtful given the nature of the page.
> This page sounds more like CONFIG_HIGHMEM64G is an option.
> And besides, the report is useless unless it's got actual technical
> content and descriptions reported by an kernel hacker.

Well, since I've not seen recent attempts at the Right Way To Do It (TM),
there's also a remote possibility of someone changing the user/kernel
split just to get a bloated mem_map to fit. Many of the smaller apps,
e.g. /bin/sh etc. are indifferent to the ABI violation.


Bill
