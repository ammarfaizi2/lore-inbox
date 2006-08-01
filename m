Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751622AbWHAN7S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751622AbWHAN7S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 09:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751625AbWHAN7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 09:59:18 -0400
Received: from flpi101.sbcis.sbc.com ([207.115.20.70]:37596 "EHLO
	flpi101.sbcis.sbc.com") by vger.kernel.org with ESMTP
	id S1751622AbWHAN7R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 09:59:17 -0400
X-ORBL: [70.248.21.215]
Message-ID: <44CF5E26.50702@ksu.edu>
Date: Tue, 01 Aug 2006 08:59:02 -0500
From: "Scott J. Harmon" <harmon@ksu.edu>
User-Agent: Thunderbird 1.5.0.5 (X11/20060727)
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Hans Reiser <reiser@namesys.com>,
       Denis Vlasenko <vda.linux@googlemail.com>, linux-kernel@vger.kernel.org
Subject: Re: reiser4: maybe just fix bugs?
References: <1158166a0607310226m5e134307o8c6bedd1f883479c@mail.gmail.com> <44CEBCBC.9070707@namesys.com> <20060801103714.GA2310@elf.ucw.cz>
In-Reply-To: <20060801103714.GA2310@elf.ucw.cz>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
>>> * Are there plans for making reiserfsck interface compatible with fsck?
>>>  I mean, making it so that reiserfsck can be symlinked to fsck.reiser
>>>  and it will work? Currently, there seems to be some incompatibility
>>>  in command-line switches. (I will dig out details and send separately
>>>  when I'll get back to my Linux box.)
>> Not sure what you mean.  Forgive me, I have not supervised fsck as
>> closely as other things.
> 
> fsck.ext2/fsck.vfat/... follow some convention including naming,
> command line switches, and behaviour.
> 
> Like fsck.ext2 /dev/something is enough to check the fielsystem.
> 
> reiserfsck is missnamed (should be fsck.reiser), and it likes to chat
> with you -- which is unexpected for tools.
> 								Pavel

Yeah, I would never imagine that for ext2 and ext3 fsck might be called
'e2fsck'. ;-)

Scott.
-- 
"Computer Science is no more about computers than astronomy is about
telescopes." - Edsger Dijkstra
