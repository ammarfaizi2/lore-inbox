Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275407AbTHNTsf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 15:48:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275412AbTHNTsf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 15:48:35 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:5897 "HELO
	kinesis.swishmail.com") by vger.kernel.org with SMTP
	id S275407AbTHNTsa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 15:48:30 -0400
Message-ID: <3F3BEB0C.9090608@techsource.com>
Date: Thu, 14 Aug 2003 16:03:24 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: William Lee Irwin III <wli@holomorphy.com>, rob@landley.net,
       Charlie Baylis <cb-lkml@fish.zetnet.co.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] O12.2int for interactivity
References: <20030804195058.GA8267@cray.fish.zetnet.co.uk> <200308141659.33447.kernel@kolivas.org> <20030814070119.GN32488@holomorphy.com> <200308141746.53346.kernel@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Con Kolivas wrote:
> Thus tasks that never sleep are always below the interactive delta 
> so each time they use up their timeslice they go onto the expired array. 
> Tasks with enough bonus points can go back onto the active array if they 
> haven't used up those bonus points.

How does a bonus point translate to a priority level?  How many bonus 
points can you collect?

