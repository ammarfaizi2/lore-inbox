Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315971AbSF0Ps2>; Thu, 27 Jun 2002 11:48:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316770AbSF0Ps1>; Thu, 27 Jun 2002 11:48:27 -0400
Received: from holomorphy.com ([66.224.33.161]:49878 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S315971AbSF0Ps0>;
	Thu, 27 Jun 2002 11:48:26 -0400
Date: Thu, 27 Jun 2002 08:47:12 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Robert Love <rml@tech9.net>
Cc: Bongani <bonganilinux@mweb.co.za>,
       Alexandre Pereira Nunes <alex@PolesApart.dhs.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: 2.4.19-pre10-ac2 bug in page_alloc.c:131
Message-ID: <20020627154712.GO22961@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Robert Love <rml@tech9.net>, Bongani <bonganilinux@mweb.co.za>,
	Alexandre Pereira Nunes <alex@PolesApart.dhs.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0206222202400.7601-100000@PolesApart.dhs.org> <20020626204721.GK22961@holomorphy.com> <1025125214.1911.40.camel@localhost.localdomain> <1025128477.1144.3.camel@icbm> <20020627005431.GM22961@holomorphy.com> <1025192465.1084.3.camel@icbm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1025192465.1084.3.camel@icbm>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-06-26 at 20:54, William Lee Irwin III wrote:
>> Well, my concern here is for the pte_chain_lock() / pte_chain_unlock()
>> bits. Teaching them about preemption should be all that's needed there.

On Thu, Jun 27, 2002 at 11:40:39AM -0400, Robert Love wrote:
> The newest patch should have the code I shared with you.  So we are OK,
> no?

That should cover it, yes. The only questions left are if the user is
using the right version and where the bug is.

Cheers,
Bill
