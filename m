Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261648AbVD1Bnn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261648AbVD1Bnn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 21:43:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261667AbVD1Bnn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 21:43:43 -0400
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:32939 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261660AbVD1Bn1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 21:43:27 -0400
Message-ID: <42703FB5.3050408@yahoo.com.au>
Date: Thu, 28 Apr 2005 11:43:17 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Wright <chrisw@osdl.org>
CC: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>, Cliff White <cliffw@osdl.org>,
       "Theodore Ts'o" <tytso@mit.edu>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk
Subject: Re: [00/07] -stable review
References: <20050427171446.GA3195@kroah.com> <42702AC4.2030500@yahoo.com.au> <20050428013342.GM23013@shell0.pdx.osdl.net>
In-Reply-To: <20050428013342.GM23013@shell0.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:
> * Nick Piggin (nickpiggin@yahoo.com.au) wrote:
> 
>>Wanna take some buffer fixes?
> 
> 
> Do they meet the -stable criteria?  If so, please send 'em over.
> 

Where do I find the -stable criteria?

They are a little bit tested, reviewed by Andrew Morton.

To me they seem pretty important. But maybe they should wait until
they have at least seen an -mm release.

The first fix I think closes potential access to stale kernel memory
if you care about that sort of thing.

-- 
SUSE Labs, Novell Inc.

