Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272327AbTGYVXE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 17:23:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272311AbTGYVXD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 17:23:03 -0400
Received: from fep03-mail.bloor.is.net.cable.rogers.com ([66.185.86.73]:39584
	"EHLO fep03-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id S272309AbTGYVWY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 17:22:24 -0400
Message-ID: <3F21A5AE.3020802@rogers.com>
Date: Fri, 25 Jul 2003 17:48:30 -0400
From: gaxt <gaxt@rogers.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5a) Gecko/20030708 Thunderbird/0.1a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ben Collins <bcollins@debian.org>
CC: Torrey Hoffman <thoffman@arnor.net>, Sam Bromley <sbromley@cogeco.ca>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       linux firewire devel <linux1394-devel@lists.sourceforge.net>
Subject: Re: Firewire
References: <20030725154009.GF1512@phunnypharm.org> <20030725160706.GK23196@ruvolo.net> <20030725161803.GJ1512@phunnypharm.org> <1059155483.2525.16.camel@torrey.et.myrio.com> <20030725181303.GO23196@ruvolo.net> <20030725181252.GA607@phunnypharm.org> <3F217A39.2020803@rogers.com> <20030725182642.GD607@phunnypharm.org> <20030725184506.GE607@phunnypharm.org> <20030725193515.GQ23196@ruvolo.net> <20030725201128.GA535@phunnypharm.org>
In-Reply-To: <20030725201128.GA535@phunnypharm.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at fep03-mail.bloor.is.net.cable.rogers.com from [24.157.78.60] using ID <dw2price@rogers.com> at Fri, 25 Jul 2003 17:37:34 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ben. Firewire is working here too- iPod is running again :-) Pleasure 
working with you on the testing. I'm using the tarballed ieee1394 code 
from www.linux1394.org's viewcvs

Ben Collins wrote:
> On Fri, Jul 25, 2003 at 12:35:15PM -0700, Chris Ruvolo wrote:
> 
>>On Fri, Jul 25, 2003 at 02:45:06PM -0400, Ben Collins wrote:
>>
>>>Maybe it wont. Try reverting back to stock, and apply this patch. I am
>>>pretty sure this will fix the problem for anyone having this issue.
>>
>>Yes, I think this did it!  One change: needed to change HSBP_VERBOSE to
>>HSBP_DEBUG in csr.c.  
>>
>>I will try turning on my DV camera tonight (I'm remote now) and I'll let you
>>know how that goes.
> 
> 
> Kick ass. I've commited this change to the 1394 repo. Linus will get the
> fix soon. I'll also send it to Marcelo for 2.4.22.
> 
> Please, if you are testing, use the code at www.linux1394.org's viewcvs
> (trunk tarball will replace drivers/ieee1394 in 2.6, branches/linux-2.4
> will do the same for 2.4).
> 
> 
> Thanks for help in tracking this down.
> 


