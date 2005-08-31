Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964776AbVHaMja@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964776AbVHaMja (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 08:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964777AbVHaMja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 08:39:30 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:10250 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S964776AbVHaMj3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 08:39:29 -0400
Message-ID: <4315A663.3070903@tmr.com>
Date: Wed, 31 Aug 2005 08:45:23 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Phy Prabab <phyprabab@yahoo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: odd socket behavior
References: <20050830065344.86508.qmail@web51807.mail.yahoo.com>
In-Reply-To: <20050830065344.86508.qmail@web51807.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phy Prabab wrote:
> Hello all,
> 
> I am seeing something odd w/sockets.  I have an app
> that opens and closes network sockets.  When the app
> terminates it releases all fd (sockets) and exists,
> yet running netstat after the app terminates still
> shows the sockets as open!  Am I doing something wrong
> or is this something that is normal?

What do you see with lsof? Is there a process associated?

I'm seeing something related with 2.6.13...

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
