Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265678AbTFXFBg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 01:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265690AbTFXFBg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 01:01:36 -0400
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:11506 "EHLO
	zcars0m9.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S265678AbTFXFBc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 01:01:32 -0400
Message-ID: <3EF7DE6F.9000102@nortelnetworks.com>
Date: Tue, 24 Jun 2003 01:15:27 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Larry McVoy <lm@bitmover.com>
Cc: Linux networking maillist <linux-kernel@vger.kernel.org>
Subject: Re: current bk has wrong version?
References: <3EF7DA79.5060501@nortelnetworks.com> <20030624050245.GA18311@work.bitmover.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy wrote:
> On Tue, Jun 24, 2003 at 12:58:33AM -0400, Chris Friesen wrote:
> 
>>When I do a "bk pull" on the standard kernel, the result generates a 
>>version of 2.5.72 rather than 2.5.73.  Is this a known issue?  I don't 
>>remember seeing it mentioned on the list before.
>>
> 
> The tag is in there:
> 
> 	http://linux.bkbits.net:8080/linux-2.5/tags?nav=index.htm

Interesting--I seem to be missing at least one change.  The last update 
on that file in my tree is 1.411, and yet when I do a "bk pull" it 
doesn't pick up anything new.  Have I found a bk bug?

One thing of note is that I ran "bk pull" late last night right after 
bkbits.net became available again.  Is it possible I picked up a partial 
update or something and now bk doesn't realize that it needs to get more 
stuff?

I'm re-cloning a second tree from scratch to make sure that it gets 
picked up in that tree.

Anything you want me to run in the affected tree to narrow down the issue?

Chris



-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

