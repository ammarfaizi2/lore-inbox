Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267170AbUJIQq7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267170AbUJIQq7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 12:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267180AbUJIQq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 12:46:59 -0400
Received: from postfix3-1.free.fr ([213.228.0.44]:37582 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S267170AbUJIQq4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 12:46:56 -0400
Message-ID: <416815FD.2060502@free.fr>
Date: Sat, 09 Oct 2004 18:46:53 +0200
From: Eric Valette <eric.valette@free.fr>
Reply-To: eric.valette@free.fr
Organization: HOME
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: Albert Cahalan <albert@users.sf.net>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Inconsistancies in /proc (status vs statm) leading to	wrong	documentation
 (proc.txt)
References: <1097329771.2674.4036.camel@cube>  <4167F0D7.3020502@free.fr> <1097339477.2669.4212.camel@cube>
In-Reply-To: <1097339477.2669.4212.camel@cube>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cahalan wrote:

>>Well the Documentation is said to matches 2.6.8-rc3 and is only 5 weeks 
>>old according to bitkeeper changesets... So at least the doc should be 
>>fixed.
> 
> 
> Removal would be simpler.

I beg to disagree. statm catche eyes when you want to know precisely 
your memory usage or do you consider to be the single statm user via procps?

> Second of all, because you get more information this
> way. You can subtract to determine the address space
> used for IO alone.

Sure but displaying it via status information would be much more simple 
furthermore I think it is incorrectly computed.

> I could go for another number: available address space.
> Then I could display percent used.

The free command does provide the information I think so it must be 
somewhere else...

> Even the other files are only partly for humans.
> Minor changes will cause many tools to break.

Sure but many people in the embedded wolrd need to know precisley 
process memory usage and possibly inside the program itsel not via 
top/ps/free/...

And if tools display wrong information for ages, then it can still be 
fixed...

-- 
    __
   /  `                   	Eric Valette
  /--   __  o _.          	6 rue Paul Le Flem
(___, / (_(_(__         	35740 Pace

Tel: +33 (0)2 99 85 26 76	Fax: +33 (0)2 99 85 26 76
E-mail: eric.valette@free.fr



