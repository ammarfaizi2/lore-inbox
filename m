Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261293AbUKHBNq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261293AbUKHBNq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 20:13:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261721AbUKHBNq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 20:13:46 -0500
Received: from siaag2ae.compuserve.com ([149.174.40.135]:2408 "EHLO
	siaag2ae.compuserve.com") by vger.kernel.org with ESMTP
	id S261293AbUKHBNp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 20:13:45 -0500
Date: Sun, 7 Nov 2004 20:11:19 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: deadlock with 2.6.9
To: Chris Stromsoe <cbs@cts.ucla.edu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200411072013_MC3-1-8E2F-FA46@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Nov 2004 at 23:49:14 -0800 Chris Stromsoe wrote:


> Boot with nosmp or boot a kernel compiled for up?

nosmp should work, but I'd build a non-smp kernel to get rid of the
locking overhead.

>> Get a real RAID controller (3Ware, not some crappy pseudo-RAID junk.) 
>> They are much more reliable than software RAID.
>
> I've had more problems with reliable hardware raid controllers than I have 
> with software raid.  Your mileage may vary.

I've never had trouble with either kind, but recovery has been much less
painful with hardware RAID.  It takes just a few seconds to hotswap a drive.


--Chuck Ebbert  07-Nov-04  08:54:08
