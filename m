Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269010AbTGUAKP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 20:10:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269016AbTGUAKP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 20:10:15 -0400
Received: from [134.126.12.40] ([134.126.12.40]:45841 "EHLO mpdir1.jmu.edu")
	by vger.kernel.org with ESMTP id S269010AbTGUAKM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 20:10:12 -0400
Message-ID: <3F1B32E6.4020107@jmu.edu>
Date: Sun, 20 Jul 2003 20:25:10 -0400
From: "William M. Quarles" <quarlewm@jmu.edu>
Organization: James Madison University
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Fwd: Re: Kernel 2.4 CPU Arch issues]
References: <3F1B25C2.8010403@jmu.edu> <1058745605.6299.4.camel@dhcp22.swansea.linux.org.uk>
In-Reply-To: <1058745605.6299.4.camel@dhcp22.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Llu, 2003-07-21 at 00:29, William M. Quarles wrote:
> 
>>Well, you separated the Pentium and Pentium-MMX.  It's the exact same
>>difference between Pentium Pro and Pentium-II: MMX technology.  That's
>>the point.
> 
> 
> This makes no difference to the kernel. Splitting PPro would only make
> sense for one reason. The Pentium Pro needs store barriers on
> spin_unlock and friends, the PII and later do not. However if this was
> done you'd also want to check for PPro boots with a PII kernel and panic
> which isn't currently done
> 

Well, wouldn't changing the gcc -march option and/or adding -mcpu 
options for the various processors in the Makefile make a difference, as 
the patchfile suggests?

-- 
William M. Quarles

quarlewm@jmu.edu
wquarles@bucknell.edu
walrus@bellsouth.net

