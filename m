Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269380AbUINPSQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269380AbUINPSQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 11:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269422AbUINPR2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 11:17:28 -0400
Received: from a26.t1.student.liu.se ([130.236.221.26]:47020 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S269177AbUINPQx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 11:16:53 -0400
Message-ID: <41470B5A.2010005@drzeus.cx>
Date: Tue, 14 Sep 2004 17:16:42 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040704)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: seife@suse.de, LKML <linux-kernel@vger.kernel.org>
Subject: Re: HP/Compaq (Winbond) SD/MMC reader supported
References: <41383D02.5060709@drzeus.cx> <20040913223827.GA28524@elf.ucw.cz> <41467216.6070508@drzeus.cx> <20040914150013.GB27621@elf.ucw.cz>
In-Reply-To: <20040914150013.GB27621@elf.ucw.cz>
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:

>
>
>Hmm, if I disable the check (and make id 0xf00 valid), it will freeze
>my machine during boot :-(. Where did you get documentation for this
>beast?
>
>	
>
Is the 0xf00 id the only one you get? If it is a SuperIO chip then 
resetting it will probably cause all sorts of funky problems.
Do you know what SuperIO is used in the machine? And have you tried 
confirming that the card reader is indeed winbond? The easiest way to do 
that is to see if the Windows driver is wbsd.sys.

The documentation was given to me by one of Winbond's resellers (after a 
lot of begging and whining). It only includes documentation for one chip 
and the ID specified in it is not even the same as reported by the chip 
the spec is supposed to be for. Winbond is definitely not on my 
recommended vendors list.

Rgds
Pierre

