Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262760AbVAQKEA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262760AbVAQKEA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 05:04:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262759AbVAQKEA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 05:04:00 -0500
Received: from blaster.systems.pipex.net ([62.241.163.7]:59105 "EHLO
	blaster.systems.pipex.net") by vger.kernel.org with ESMTP
	id S262760AbVAQKDk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 05:03:40 -0500
Date: Mon, 17 Jan 2005 10:04:31 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
X-X-Sender: tigran@ezer.homenet
To: Arjan van de Ven <arjan@infradead.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Jan Hubicka <jh@suse.cz>,
       Jack F Vogel <jfv@bluesong.net>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [discuss] booting a kernel compiled with -mregparm=0
In-Reply-To: <1105955608.6304.60.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.61.0501171002190.4644@ezer.homenet>
References: <Pine.LNX.4.61.0501141623530.3526@ezer.homenet> 
 <20050114205651.GE17263@kam.mff.cuni.cz>  <Pine.LNX.4.61.0501141613500.6747@chaos.analogic.com>
  <cs9v6f$3tj$1@terminus.zytor.com>  <Pine.LNX.4.61.0501170909040.4593@ezer.homenet>
 <1105955608.6304.60.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jan 2005, Arjan van de Ven wrote:
>> Actually, having cc'd Linus made me think very _carefully_ about what I
>> say and I went and checked how the userspace does it, as I couldn't
>> believe that such fine piece of software as gdb would be broken as well.
>> And to my surprize I discovered that gdb (when a program is compiled with
>> -g) works fine! I.e. it shows the function arguments correctly. And
>
>
> so why don't you use kgdb instead of kdb ?

If kdb was some dead unmaintained piece of software then, yes, I would 
follow your advice and switch to kgdb. But kdb is a very nice and actively 
maintained piece of work, so it should be fixed to show the parameter 
values correctly in the backtrace.

Kind regards
Tigran
