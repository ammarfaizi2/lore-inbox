Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268429AbUHLHLv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268429AbUHLHLv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 03:11:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268431AbUHLHLv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 03:11:51 -0400
Received: from smtp107.mail.sc5.yahoo.com ([66.163.169.227]:27569 "HELO
	smtp107.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S268429AbUHLHLu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 03:11:50 -0400
Message-ID: <411B1830.7080601@yahoo.com.au>
Date: Thu, 12 Aug 2004 17:11:44 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040707 Debian/1.7-5
X-Accept-Language: en
MIME-Version: 1.0
To: Martin Schlemmer <azarah@nosferatu.za.org>
CC: Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.8-rc3-np1
References: <4117494E.704@yahoo.com.au> <1092262435.8976.59.camel@nosferatu.lan>
In-Reply-To: <1092262435.8976.59.camel@nosferatu.lan>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Schlemmer wrote:
> On Mon, 2004-08-09 at 11:52, Nick Piggin wrote:
> 
>>http://www.kerneltrap.org/~npiggin/2.6.8-rc3-np1/
>>
>>Patch is against 2.6.8-rc3-mm2 only at this stage due to significant
>>memory management changes in there making it difficult to track Linus'
>>tree as well.
>>
>>Feedback on the scheduler would be much appreciated, as it might get
>>a run in Andrew's tree soon.
>>
> 
> 
> I am trying to get it patched against rc4-mm1, but it seems there
> are some issues with the SMT bits - dependent_sleeper for example
> is still around although it was removed with all previous patches
> (and uses task_t.time_slice which is no longer there).
> 
> I assume you forgot to apply them?  Possible to get a complete
> patch?  If not, I'll see if I can get something going after some
> sleep.

Yeah, I've missed something. Thanks for the report. I'll fix
it shortly.
