Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263806AbUCXT4Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 14:56:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263161AbUCXT4Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 14:56:25 -0500
Received: from expms3.cites.uiuc.edu ([128.174.5.207]:58983 "EHLO
	expms3.cites.uiuc.edu") by vger.kernel.org with ESMTP
	id S263806AbUCXT4X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 14:56:23 -0500
Date: Wed, 24 Mar 2004 13:56:22 -0600
From: Shawn Lindberg <slindber@uiuc.edu>
Subject: Re: [Problem]: "access beyond end" of DVD-R
To: linux-kernel@vger.kernel.org
Cc: slindber@uiuc.edu
X-Mailer: Webmail Mirapoint Direct 3.3.7-GR
MIME-Version: 1.0
Message-Id: <ebacb8e9.263e8edd.81ca600@expms3.cites.uiuc.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Mon, Mar 22 2004, slindber@uiuc.edu wrote:
> 
>>attempt to access beyond end of device
>>hdc: rw=0, want=8174536, limit=8123200
>>Buffer I/O error on device hdc, logical block 2043633
>>
>>There are more attempt to "access beyond end of device" messages, but
>>they are similar so I've snipped them.
> 
> Does this make a difference for you (2.6 patch)?

I made that one line change to my 2.6.3 kernel from gentoo and it fixed the problem for both the ISO/UDF and UDF discs (I couldn't try the ISO only disc since I don't have it anymore).  I also tried a few CDs to get a rough check for whether it introduced new errors, but they were fine also.  Please let me know if I should do any further testing, and THANKS!

Shawn Lindberg
