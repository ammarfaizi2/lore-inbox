Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263749AbTDXPQv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 11:16:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263752AbTDXPQv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 11:16:51 -0400
Received: from siaab1aa.compuserve.com ([149.174.40.1]:32413 "EHLO
	siaab1aa.compuserve.com") by vger.kernel.org with ESMTP
	id S263749AbTDXPQt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 11:16:49 -0400
Date: Thu, 24 Apr 2003 11:25:08 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH] 2.4.21-rc1 pointless IDE noise reduction
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200304241128_MC3-1-35DA-F3DA@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:


>> +	return((drive->id->cfs_enable_1 & 0x0400) ? 1 : 0);
>>  }
>
> Seconded, it causes a lot more confusion than it does good.


  The return looks like a function call in that last line.

  That's one of the few things I find really annoying -- extra parens
are fine when they make code clearer, but not there.


-------
 Chuck [ C Style Police, badge #666 ]
