Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030293AbWFIQ1S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030293AbWFIQ1S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 12:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030292AbWFIQ1R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 12:27:17 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:14223 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030289AbWFIQ1Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 12:27:16 -0400
Message-ID: <4489A15E.5020904@garzik.org>
Date: Fri, 09 Jun 2006 12:27:10 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Mike Snitzer <snitzer@gmail.com>
CC: Alex Tomas <alex@clusterfs.com>, Christoph Hellwig <hch@infradead.org>,
       Mingming Cao <cmm@us.ibm.com>, linux-kernel@vger.kernel.org,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>	 <20060609091327.GA3679@infradead.org> <m364jafu3h.fsf@bzzz.home.net>	 <44898476.80401@garzik.org> <m33beee6tc.fsf@bzzz.home.net>	 <4489874C.1020108@garzik.org> <m3y7w6cr7d.fsf@bzzz.home.net>	 <44899113.3070509@garzik.org> <170fa0d20606090921x71719ad3m7f9387ba15413b8f@mail.gmail.com>
In-Reply-To: <170fa0d20606090921x71719ad3m7f9387ba15413b8f@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Snitzer wrote:
> Developers never _want_ to branch (maintenance-hell), the question
> becomes: do the risks associated with ext3-with-extents' backword
> incompatibility _really_ justify the branch?


It's also a question of...  why keep adding modernizing features to 
ext3, thus keeping it on life support, but just barely?  If we are going 
to modernize the _main Linux filesystem_, let's not do it in a way that 
is slow, and ties our hands.

	Jeff


