Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262175AbUFNIYZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262175AbUFNIYZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 04:24:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262062AbUFNIXX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 04:23:23 -0400
Received: from holomorphy.com ([207.189.100.168]:63902 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262213AbUFNIWk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 04:22:40 -0400
Date: Mon, 14 Jun 2004 01:22:34 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [1/12] don't dereference netdev->name before register_netdev()
Message-ID: <20040614082234.GH1444@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
References: <20040614003148.GO1444@holomorphy.com> <20040614003331.GP1444@holomorphy.com> <20040614081056.GA7162@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040614081056.GA7162@infradead.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 13, 2004 at 05:33:31PM -0700, William Lee Irwin III wrote:
>>  * Removed dev->name lookups before register_netdev
>> This fixes Debian BTS #234817.
>> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=234817

On Mon, Jun 14, 2004 at 09:10:56AM +0100, Christoph Hellwig wrote:
> Herbert has worked with Jeff on this issue already.  And -netdev would
> be the right list for it.

Good stuff. Looks like I can drop a few more patches, then.


-- wli
