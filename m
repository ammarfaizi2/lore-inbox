Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266466AbTGJUiL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 16:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269526AbTGJUiL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 16:38:11 -0400
Received: from zeke.inet.com ([199.171.211.198]:50569 "EHLO zeke.inet.com")
	by vger.kernel.org with ESMTP id S266466AbTGJUiJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 16:38:09 -0400
Message-ID: <3F0DD21B.5010408@inet.com>
Date: Thu, 10 Jul 2003 15:52:43 -0500
From: Eli Carter <eli.carter@inet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Stern <stern@rowland.harvard.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: Style question: Should one check for NULL pointers?
References: <Pine.LNX.4.44L0.0307101606060.22398-100000@netrider.rowland.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Stern wrote:
[snip]
> Ultimately this comes down to a question of style and taste.  This 
> particular issue is not addressed in Documentation/CodingStyle so I'm 
> raising it here.  My personal preference is for code that means what it 
> says; if a pointer is checked it should be because there is a genuine 
> possibility that the pointer _is_ NULL.  I see no reason for pure 
> paranoia, particularly if it's not commented as such.
> 
> Comments, anyone?

BUG_ON() perhaps?

Eli
--------------------. "If it ain't broke now,
Eli Carter           \                  it will be soon." -- crypto-gram
eli.carter(a)inet.com `-------------------------------------------------

