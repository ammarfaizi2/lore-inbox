Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264717AbUHFDMB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264717AbUHFDMB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 23:12:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265222AbUHFDMB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 23:12:01 -0400
Received: from holomorphy.com ([207.189.100.168]:5064 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264717AbUHFDMA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 23:12:00 -0400
Date: Thu, 5 Aug 2004 20:11:53 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andy Isaacson <adi@hexapodia.org>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       "Mr. Berkley Shands" <berkley@cse.wustl.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: Severe I/O performance regression 2.6.6 to 2.6.7 or 2.6.8-rc3
Message-ID: <20040806031153.GO17188@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andy Isaacson <adi@hexapodia.org>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	"Mr. Berkley Shands" <berkley@cse.wustl.edu>,
	linux-kernel@vger.kernel.org
References: <41126811.7020607@dssimail.com> <20040805172531.GC17188@holomorphy.com> <4112917A.3080003@cse.wustl.edu> <20040805204615.GJ17188@holomorphy.com> <20040805223319.GA18155@logos.cnet> <20040806020930.GA23072@hexapodia.org> <20040806022734.GN17188@holomorphy.com> <20040806024221.GA19333@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040806024221.GA19333@hexapodia.org>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2004 at 07:27:34PM -0700, William Lee Irwin III wrote:
>> Once we get there, there must be some way to construct intermediate
>> points between those two faithful at the very least to the snapshot
>> ordering if not true chronological ordering.

On Thu, Aug 05, 2004 at 09:42:21PM -0500, Andy Isaacson wrote:
> Well, the state of the "central tree" is represented by a cset key at
> each point.  So the answer to your question is a list of keys.  But the
> keys in question aren't "special" in any bk sense; they're just some
> keys.  You can keep track of keys outside of BK if you want, to keep a
> history of "state of this tree at time X", but BK can't keep track of
> that info.
> Anyways, maybe an example is in order.
[...]

Sounds like time to put this into Documentation/


-- wli
