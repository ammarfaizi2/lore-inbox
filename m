Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280971AbRKLU2T>; Mon, 12 Nov 2001 15:28:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280980AbRKLU2L>; Mon, 12 Nov 2001 15:28:11 -0500
Received: from ns.caldera.de ([212.34.180.1]:34784 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S280974AbRKLU1x>;
	Mon, 12 Nov 2001 15:27:53 -0500
Date: Mon, 12 Nov 2001 21:27:35 +0100
From: Christoph Hellwig <hch@caldera.de>
To: Mark Peloquin <peloquin@us.ibm.com>
Cc: dalecki@evision.ag, linux-kernel@vger.kernel.org,
        evms-devel@lists.sourceforge.net
Subject: Re: [Evms-devel] Re: Re: Hardsector size support in 2.4 and 2.5
Message-ID: <20011112212735.A28486@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch@caldera.de>,
	Mark Peloquin <peloquin@us.ibm.com>, dalecki@evision.ag,
	linux-kernel@vger.kernel.org, evms-devel@lists.sourceforge.net
In-Reply-To: <OF9F38B076.0F9781F3-ON85256B02.006D5DFE@raleigh.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <OF9F38B076.0F9781F3-ON85256B02.006D5DFE@raleigh.ibm.com>; from peloquin@us.ibm.com on Mon, Nov 12, 2001 at 02:05:19PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2001 at 02:05:19PM -0600, Mark Peloquin wrote:
> So any block device, can always expect to receive buffer heads
> whose b_rsector value represents the offset from the beginning
> of that device in 512 byte multiples? And this will continue
> to hold true in 2.5 as well?

There is a good chance that no 2.5 block driver will ever see a buffer_head,
take a look at http://www.kernel.org/pub/linux/kernel/people/axboe/v2.5/ for
details.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
