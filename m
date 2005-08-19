Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932543AbVHSAo7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932543AbVHSAo7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 20:44:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932542AbVHSAo7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 20:44:59 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:56753 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S932539AbVHSAo6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 20:44:58 -0400
Message-ID: <43052B89.8080709@rtr.ca>
Date: Thu, 18 Aug 2005 20:44:57 -0400
From: Mark Lord <liml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050728
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       linux-ide@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [git patches] ide update
References: <Pine.GSO.4.62.0508182332470.22579@mion.elka.pw.edu.pl> <Pine.LNX.4.58.0508181512240.3412@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508181512240.3412@g5.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
>
> Btw, things like this:
> 
> 	+#define IDEFLOPPY_TICKS_DELAY  HZ/20   /* default delay for ZIP 100 (50ms) */
> 
> are just bugs waiting to happen.

Needs parenthesis: ((HZ)/20)

Or one could just use the msecs_to_jiffies() macro.

Cheers
