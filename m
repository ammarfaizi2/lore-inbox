Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbTDKUMi (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 16:12:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261743AbTDKUMi (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 16:12:38 -0400
Received: from zurich.ai.mit.edu ([18.43.0.244]:53765 "EHLO zurich.ai.mit.edu")
	by vger.kernel.org with ESMTP id S261711AbTDKUMf (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 16:12:35 -0400
To: mdresser_l@windsormachine.com
CC: John Bradford <john@grabjohn.com>,
       "Richard B. Johnson" <root@chaos.analogic.com>,
       <linux-kernel@vger.kernel.org>,
       <linux-hotplug-devel@lists.sourceforge.net>,
       <message-bus-list@redhat.com>
In-reply-to: <Pine.LNX.4.33.0304111615440.14943-100000@router.windsormachine.com> (mdresser_l@windsormachine.com)
Subject: [ANNOUNCE] udev 0.1 release
User-Agent: IMAIL/1.19; Edwin/3.114; MIT-Scheme/7.7.2.pre
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E19453q-0004gk-00@nuwen.ai.mit.edu>
From: Chris Hanson <cph@zurich.ai.mit.edu>
Date: Fri, 11 Apr 2003 16:23:46 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: Fri, 11 Apr 2003 16:16:52 -0400 (EDT)
   From: Mike Dresser <mdresser_l@windsormachine.com>

   On Fri, 11 Apr 2003, John Bradford wrote:

   > Now, assuming a voltage drop of 0.05V across each cable...
   >
   > :-)
   >
   > John.
   >
   Ah yes, I was going to mention that, but didn't know which way would be
   better.  My instinct tells me the massively parallel, but I could and
   probably am wrong again. :)

Using a tree (what you are calling massively parallel) for
distribution produces a uniform voltage drop for all of the devices,
and has a better worst-case voltage drop than a serial chaining
distribution.  The serial chain has different voltage drops for each
pair of disks, depending on how far down the chain they are, but the
worst case is very bad.

The reason is that the tree has O(log N) depth, and the serial chain
has O(N) depth.

Chris
