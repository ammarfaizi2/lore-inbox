Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268671AbTBZHSW>; Wed, 26 Feb 2003 02:18:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268672AbTBZHSW>; Wed, 26 Feb 2003 02:18:22 -0500
Received: from holomorphy.com ([66.224.33.161]:1210 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S268671AbTBZHSV>;
	Wed, 26 Feb 2003 02:18:21 -0500
Date: Tue, 25 Feb 2003 23:27:27 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org, mingo@redhat.com
Subject: Re: [BUG] 2.5.63: ESR killed my box!
Message-ID: <20030226072727.GO10411@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	"Martin J. Bligh" <mbligh@aracnet.com>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org, mingo@redhat.com
References: <9530000.1046238665@[10.10.2.4]> <20030226072327.7936B2C04B@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030226072327.7936B2C04B@lists.samba.org>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message mbligh wrote:
>> I put an esr_disable flag in there a while back ... does that workaround it?

On Wed, Feb 26, 2003 at 06:14:42PM +1100, Rusty Russell wrote:
> Yes.  Hmm.  Wonder if that helps my SMP wierness, too.

It shouldn't be set on anything but NUMA-Q and "bigsmp".


-- wli
