Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262403AbVCCVcP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262403AbVCCVcP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 16:32:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262367AbVCCVab
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 16:30:31 -0500
Received: from mx1.redhat.com ([66.187.233.31]:34767 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262403AbVCCV01 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 16:26:27 -0500
Date: Thu, 3 Mar 2005 16:26:22 -0500
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Andries Brouwer <aebr@win.tue.nl>, davem@davemloft.net, jgarzik@pobox.com,
       torvalds@osdl.org, linux-kernel@vger.kernel.org, notting@redhat.com
Subject: Re: RFD: Kernel release numbering
Message-ID: <20050303212115.GJ29371@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>, Andries Brouwer <aebr@win.tue.nl>,
	davem@davemloft.net, jgarzik@pobox.com, torvalds@osdl.org,
	linux-kernel@vger.kernel.org, notting@redhat.com
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org> <42264F6C.8030508@pobox.com> <20050302162312.06e22e70.akpm@osdl.org> <42265A6F.8030609@pobox.com> <20050302165830.0a74b85c.davem@davemloft.net> <20050303011151.GJ10124@redhat.com> <20050302172049.72a0037f.akpm@osdl.org> <20050303012707.GK10124@redhat.com> <20050303145846.GA5586@pclin040.win.tue.nl> <20050303130901.655cb9c4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050303130901.655cb9c4.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2005 at 01:09:01PM -0800, Andrew Morton wrote:

 > [*] I don't know any details of the /proc incompatibility which davej
 >     mentions, and I'd like to.  That sounds like a screw-up.

We changed the format of /proc/slabinfo.  Running slabtop threw up
an error message complaining that the format had changed.

It was a graceful failure, but a failure none-the-less.

Other failures have been somewhat more dramatic.
I know ipsec-tools, and alsa-lib have both caused pain
on at least one occasion after the last 2-3 kernel updates.

I was keeping track of these breakages, but I can't seem to
find the text file right now.  Bill, can you remember any
other cases worthy of mentioning ?

		Dave

