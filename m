Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266905AbUJIRqS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266905AbUJIRqS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 13:46:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267165AbUJIRqS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 13:46:18 -0400
Received: from postfix4-2.free.fr ([213.228.0.176]:19943 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP id S266905AbUJIRqR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 13:46:17 -0400
Message-ID: <416823E6.6020008@free.fr>
Date: Sat, 09 Oct 2004 19:46:14 +0200
From: Eric Valette <eric.valette@free.fr>
Reply-To: eric.valette@free.fr
Organization: HOME
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: Albert Cahalan <albert@users.sf.net>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Inconsistancies in /proc (status vs statm) leading	to	wrong	documentation
 (proc.txt)
References: <1097329771.2674.4036.camel@cube>  <4167F0D7.3020502@free.fr>	 <1097339477.2669.4212.camel@cube>  <416815FD.2060502@free.fr> <1097341175.2669.4257.camel@cube>
In-Reply-To: <1097341175.2669.4257.camel@cube>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cahalan wrote:

> Not quite, but close. Those that know are willing
> to read the kernel code, including that of past
> releases, can certainly use the statm file.

Sure but it while doing that after readding the official documentation 
that the trouble began...


> For that, go directly to /proc/*/maps and be happy.

That's a good point. Very usefull for knowing which dynamic library 
account for what size. I start wondering if dynamic libraries and 
mlockall works well toghether..

> You may also want the RSS from /proc/*/status.

Well RSS = VmSize after mlockall I guess

Thanks for the maps hint,

-- eric



