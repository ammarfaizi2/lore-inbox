Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262163AbVBUWn6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262163AbVBUWn6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 17:43:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262165AbVBUWn6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 17:43:58 -0500
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:33019 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S262163AbVBUWn4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 17:43:56 -0500
Message-ID: <421A6426.6020802@nortel.com>
Date: Mon, 21 Feb 2005 16:43:50 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Anthony DiSante <theant@nodivisions.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: uninterruptible sleep lockups
References: <421A3414.2020508@nodivisions.com> <200502211945.j1LJjgbZ029643@turing-police.cc.vt.edu>            <421A4375.9040108@nodivisions.com> <200502212054.j1LKs3xi032658@turing-police.cc.vt.edu> <421A5E28.1030409@nodivisions.com>
In-Reply-To: <421A5E28.1030409@nodivisions.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anthony DiSante wrote:

> It's indisputable that there will always be driver bugs and faulty 
> hardware.  Of course these should be fixed, but if it's possible for the 
> kernel to gracefully deal with the bugs until they get fixed, then why 
> shouldn't it do so?

Think of the overhead required to track every single resource ever 
aquired by the process/thread/entity in question.  Then if/when it 
hangs, you'd have to properly clean up every last one of them.

Much safer/simpler to leave it hung, and force an eventual reboot.

If you have been given code that causes D states, bitch to the supplier 
until they fix it.  Kernel bugs are not acceptable.

Chris
