Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262034AbVBAPL6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262034AbVBAPL6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 10:11:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262036AbVBAPL6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 10:11:58 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:32154 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S262034AbVBAPLz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 10:11:55 -0500
Message-ID: <41FF9D13.8010902@tmr.com>
Date: Tue, 01 Feb 2005 10:15:31 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
Newsgroups: mail.linux-kernel
To: John Richard Moser <nigelenki@comcast.net>
CC: Josh Boyer <jdub@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: Why does the kernel need a gig of VM?
References: <1106944969.7542.13.camel@windu.rchland.ibm.com><1106944969.7542.13.camel@windu.rchland.ibm.com> <41FAA51E.10000@comcast.net>
In-Reply-To: <41FAA51E.10000@comcast.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Richard Moser wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Wow.
> 
> I'd heard that there was a way to set 3.5/0.5 GiB split, and that there
> was a patch that removed the split and isolated the kernel (but that was
> slow), so I was just curious about all this stuff with people screaming
> about how tight 4G of VM is vs a half gig or a gig that can be freed up.

The 4/4 split requires somewhat different logic than the others, but I 
believe that other splits could be specified at runtime instead of as a 
config option, should there ever be a need. From memory the 4/4 split 
needs table flushing on every kernel entry.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
