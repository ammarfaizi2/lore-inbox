Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265200AbTLaQcF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 11:32:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265205AbTLaQcF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 11:32:05 -0500
Received: from mx1.it.wmich.edu ([141.218.1.89]:36809 "EHLO mx1.it.wmich.edu")
	by vger.kernel.org with ESMTP id S265200AbTLaQcB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 11:32:01 -0500
Message-ID: <3FF2F9FE.2000403@wmich.edu>
Date: Wed, 31 Dec 2003 11:31:58 -0500
From: Ed Sweetman <ed.sweetman@wmich.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en
MIME-Version: 1.0
To: Paolo Ornati <ornati@lycos.it>
CC: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.1-rc1 [resend]
References: <Pine.LNX.4.58.0312310033110.30995@home.osdl.org> <200312311619.27812.ornati@lycos.it> <20031231152052.GR27687@holomorphy.com> <200312311645.23348.ornati@lycos.it>
In-Reply-To: <200312311645.23348.ornati@lycos.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Ornati wrote:
> On Wednesday 31 December 2003 16:20, you wrote:
> 
>>On Wednesday 31 December 2003 16:06, you wrote:
>>
>>>>What io scheduler are you using? Or, could you post /var/log/dmesg?
>>
>>On Wed, Dec 31, 2003 at 04:19:27PM +0100, Paolo Ornati wrote:
>>
>>>"dmesg" and "config" attached.
>>
>>Could you try this with elevator=deadline?
> 
> 
> ok, I have just tried...
> I don't see any big difference.
> 


Wasn't it mentioned in another thread related to a drop in ide 
performance that there is possibly some bug in the ide code that ends up 
requiring you to set the readahead on all your devices to see the max 
performance of any one?

set all the readaheads of all your ide devices to 8192  You should see 
the best peformance doing this.


