Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272895AbTHKRR5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 13:17:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272894AbTHKRR2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 13:17:28 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:40427 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S272886AbTHKRQL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 13:16:11 -0400
Message-ID: <3F37CF4E.3010605@pobox.com>
Date: Mon, 11 Aug 2003 13:15:58 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Larry McVoy <lm@bitmover.com>
CC: davej@redhat.com, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       dri-devel@lists.sourceforge.net
Subject: Re: [PATCH] CodingStyle fixes for drm_agpsupport
References: <E19mF4Y-0005Eg-00@tetrachloride> <20030811164012.GB858@work.bitmover.com> <3F37CB44.5000307@pobox.com> <20030811170425.GA4418@work.bitmover.com>
In-Reply-To: <20030811170425.GA4418@work.bitmover.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy wrote:
> That ought to be balanced with "don't screw up the revision history, people
> use it".  It's one thing to reformat code that is unreadable, for the most
> part this code didn't come close to unreadable.

Granted.


> I wasn't suggesting that.  I was saying
> 
> 	if (expr) statement;		// OK

The test and the statement run together visually, which is it is 
preferred to put the statement on the following line.


> The exception I was saying was reasonable is if you are doing something like
> 
> 	if (!pointer) return (-EINVAL);
> 
> Short, sweet, readable, no worries.  

return is not a function ;-)

	Jeff



