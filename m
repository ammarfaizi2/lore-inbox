Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261497AbTEARQg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 13:16:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbTEARQg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 13:16:36 -0400
Received: from dhcp93-dsl-usw3.w-link.net ([206.129.84.93]:2716 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id S261497AbTEARQf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 13:16:35 -0400
Message-ID: <3EB15946.4000506@candelatech.com>
Date: Thu, 01 May 2003 10:28:38 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030210
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Balram Adlakha <b_adlakha@softhome.net>
CC: Chuck Ebbert <76306.1226@compuserve.com>, linux-kernel@vger.kernel.org
Subject: Re: Kernel source tree splitting
References: <200305010756_MC3-1-36E1-623@compuserve.com> <20030501172238.GA13756@localhost.localdomain>
In-Reply-To: <20030501172238.GA13756@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Balram Adlakha wrote:
> On Thu, May 01, 2003 at 07:54:03AM -0400, Chuck Ebbert wrote:

>> I have seven source trees on disk right now.  Getting rid off all
>>the archs but i386 would not only save tons of space, it would also
>>make 'grep -r' go faster and stop spewing irrelevant hits for archs
>>that I couldn't care less about.

> 
> I agree with you. Making different trees for different archs will make the tarball much smaller. Usually people only use one architecture and the other code lies waste. I think this has been discussed many times but It really is worth doing.

How about a script to just prune it once you download it.  That will at least fix your
disk space & grep issue, and will not affect those of us who like to see it all.

If you want to save download bandwidth, just use incremental diffs and/or something
like bk or one of the cvs exports.

Ben


> -- 


-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


