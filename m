Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292275AbSBOXbF>; Fri, 15 Feb 2002 18:31:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292276AbSBOXa4>; Fri, 15 Feb 2002 18:30:56 -0500
Received: from holomorphy.com ([216.36.33.161]:8322 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S292275AbSBOXau>;
	Fri, 15 Feb 2002 18:30:50 -0500
Date: Fri, 15 Feb 2002 15:30:40 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Robert Love <rml@tech9.net>, Robert Jameson <rj@open-net.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Hard lockup with 2.4.18-pre9 + preempt + lock break + O1k[23] + rmap
Message-ID: <20020215233040.GA782@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Robert Love <rml@tech9.net>, Robert Jameson <rj@open-net.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020215035135.0c26b130.rj@open-net.org> <1013780277.950.663.camel@phantasy> <20020215201810.GA5310@matchmail.com> <1013810411.803.1045.camel@phantasy> <20020215232221.GB5310@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <20020215232221.GB5310@matchmail.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2002 at 03:22:21PM -0800, Mike Fedyk wrote:
> Yep, I understand.  When I was patching in rmap12f I had to manually
> merge the little bit into mm/bootmem.c and the offset was several hundred
> lines.  Then I realized just how much WLI's bootmem patch changes.

It's a rewrite. Of course it changes the whole file. Lucky for you it
interacts with nothing else. I seem to remember this conflict being
somewhat trivial to resolve though.


Cheers,
Bill
