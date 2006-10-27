Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750704AbWJ0VsR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbWJ0VsR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 17:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750705AbWJ0VsR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 17:48:17 -0400
Received: from zrtps0kn.nortel.com ([47.140.192.55]:64390 "EHLO
	zrtps0kn.nortel.com") by vger.kernel.org with ESMTP
	id S1750704AbWJ0VsR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 17:48:17 -0400
Message-ID: <45427E91.2000402@nortel.com>
Date: Fri, 27 Oct 2006 15:48:01 -0600
From: "Chris Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.7) Gecko/20050427 Red Hat/1.7.7-1.1.3.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Andi Kleen <ak@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>,
       john stultz <johnstul@us.ibm.com>
Subject: Re: AMD X2 unsynced TSC fix?
References: <1161969308.27225.120.camel@mindpipe> <200610271335.10178.ak@suse.de> <1161981682.27225.184.camel@mindpipe>
In-Reply-To: <1161981682.27225.184.camel@mindpipe>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Oct 2006 21:48:04.0359 (UTC) FILETIME=[94BF4970:01C6FA11]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:

> What exactly does that AMD patch do?

"...by periodically adjusting the core time-stamp-counters, so that they 
are synchronized."

It sounds like they just periodically write a new value to the TSC. 
Presumably they set the "slower" one equal to the "faster" one.

You'd likely still have windows where time might run backwards, but it 
would be better than nothing.

Chris
