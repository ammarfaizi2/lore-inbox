Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264467AbTDXVxV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 17:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264468AbTDXVxV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 17:53:21 -0400
Received: from zeke.inet.com ([199.171.211.198]:65228 "EHLO zeke.inet.com")
	by vger.kernel.org with ESMTP id S264467AbTDXVxU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 17:53:20 -0400
Message-ID: <3EA85FA2.6060500@inet.com>
Date: Thu, 24 Apr 2003 17:05:22 -0500
From: Eli Carter <eli.carter@inet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pete Zaitcev <zaitcev@redhat.com>
CC: "Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [OT] patch splitting util(s)?
References: <3E9B2C38.4020405@inet.com> <20030414215128.GA24096@suse.de> <mailman.1050360781.7083.linux-kernel2news@redhat.com> <200304150047.h3F0lXc22483@devserv.devel.redhat.com> <20030415131043.1cdcbe44.rddunlap@osdl.org> <20030424164503.A995@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Zaitcev wrote:
>>Date: Tue, 15 Apr 2003 13:10:43 -0700
>>From: "Randy.Dunlap" <rddunlap@osdl.org>
> 
> 
>>| > I'm aware of patchutils.  (Check the 0.2.22 Changelog ;) )  However, 
>>| > splitdiff doesn't do what I'm after, from my initial look.  Though now 
>>| > that I think about it, it suggests an alternative solution.  A 
>>| > 'shatterdiff' that created one diff file per hunk in a patch would give 
>>| > me basically what I want.
>>| 
>>| I moaned at Tim until he caved in and added an '-s' option
>>| couple of weeks ago. It should be in a fresh rawhide srpm.
>>| 
>>| Mind, you can do what you want even now, with -n (for line numbers)
>>| and a little bit of sh or perl, but all concievable solutions
>>| require several passes over the diff, which gets tiresome
>>| if you diff 2.4.9 (RH 7.2) and 2.4.18 (RH 8.0). The -s option
>>| does it in one pass.
>>
>>so when does this change show up at http://cyberelk.net/tim/patchutils/ ?
> 
> 
> Tim pointed out that the option is -a, not -s. It should be
> present in 0.2.22.

Almost.  That does a per-file split, not a per-hunk split.  And per-hunk 
I have found makes splitting patches into their logical components 
_much_ easier.

Thanks for the clarification though!

Eli
--------------------. "If it ain't broke now,
Eli Carter           \                  it will be soon." -- crypto-gram
eli.carter(a)inet.com `-------------------------------------------------

