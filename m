Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262060AbUE2Erc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262060AbUE2Erc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 00:47:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263226AbUE2Erc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 00:47:32 -0400
Received: from holomorphy.com ([207.189.100.168]:20352 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262060AbUE2Erb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 00:47:31 -0400
Date: Fri, 28 May 2004 21:47:23 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Neil Brown <neilb@cse.unsw.edu.au>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Subject: Re: nfsd oops 2.6.7-rc1
Message-ID: <20040529044723.GA2093@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Neil Brown <neilb@cse.unsw.edu.au>, akpm@osdl.org,
	linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
References: <20040529023550.GB2370@holomorphy.com> <16568.621.199870.484447@cse.unsw.edu.au> <20040529032540.GA1310@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040529032540.GA1310@holomorphy.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 29, 2004 at 01:24:29PM +1000, Neil Brown wrote:
>> Ok, I think I've found it.  There is a missing dget.  See below/.
>> NeilBrown

On Fri, May 28, 2004 at 08:25:40PM -0700, William Lee Irwin III wrote:
> Thanks! Testing ETA 10-15 minutes (time needed for kernel compiles).

No oopsen for 30 minutes so it's working wonderfully thus far, but I've
seen things go wrong a number of hours out from boot before. I'll try
to follow up with another ack after it's been longer.


-- wli
