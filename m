Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965452AbWI0I7c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965452AbWI0I7c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 04:59:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750986AbWI0I7c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 04:59:32 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:40081 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1750925AbWI0I7b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 04:59:31 -0400
Date: Wed, 27 Sep 2006 10:58:41 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Sergey Panov <sipan@sipan.org>
cc: James Bottomley <James.Bottomley@SteelEye.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: GPLv3 Position Statement
In-Reply-To: <1159342569.2653.30.camel@sipan.sipan.org>
Message-ID: <Pine.LNX.4.61.0609271051550.19438@yvahk01.tjqt.qr>
References: <1158941750.3445.31.camel@mulgrave.il.steeleye.com> 
 <1159319508.16507.15.camel@sipan.sipan.org>  <Pine.LNX.4.61.0609270753590.19275@yvahk01.tjqt.qr>
 <1159342569.2653.30.camel@sipan.sipan.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>almost, surrounding_userland_applications = (operating_system - kernel) 
>
>> then yes, why should there be a problem with a GPL2 kernel and a GPL3 
>> userland? After all, the userland is not only GPL, but also BSD and 
>> other stuff.
>
>It was not a problem with GPL[0-1]/BSD/MIT license, but is it still true
>with GPL3? What is the difference between running application on the top
>of the kernel "A" and linked with the library "B"?

I think Linus once said that he does not consider the kernel to 
become part of a combined work when an application uses the kernel.

I tend to agree, it's gray (unless Linus explicitly colorizes it) -- 
IIRC the GPL allows a GPL and closed program to interact if they do so 
using 'standard' interfaces, i.e. passing a file as argument, or 
shell redirection, communicating over a pipe or a socket, etc.
But OTOH, linking code makes it a combined work.
And the question now is: Since the kernel is the one providing these 
standard services, what would apply? Do userland and kernel communicate 
by means of linking or by means of standardized interfaces (in this case -
fixed syscall numbers or thelike). I'd say the latter. An application 
does not link with the kernel IMHO, no symbol resolution is done.

>> >The last Q. is how good is the almost forgotten Hurd kernel?
>> 
>> Wild guess: At most on par with Minix.
>
>... ???. I am not so sure. Kernel is really a small thing. The VMWare
>proprietary hyper-visor was/is reusing Linux drivers with ease, why BSD or
>Hurd can not do the same? As a former (Linux) driver writer I like to show the
>following numbers to my friends:

Oh well I was rather interpreting the question as "What about Hurd?" and 
my answer was the same from the Hurd page last time I read it.
"It's not so complete to make up a production system." or similar.

>================================================================
>
>PS. Given that some of the sub-systems (e.g SCSI) in Linux still suck
>badly, other OS (not as in Operating Systems but as in Open Source)
>alternatives might eventually gain some ground in the enterprise
>environment.

Don't tell me you like the Solaris way of naming devices. :)


Jan Engelhardt
-- 
