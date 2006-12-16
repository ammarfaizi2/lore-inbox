Return-Path: <linux-kernel-owner+w=401wt.eu-S1161414AbWLPTiq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161414AbWLPTiq (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 14:38:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161416AbWLPTiq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 14:38:46 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:57751 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161414AbWLPTip (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 14:38:45 -0500
X-Greylist: delayed 1940 seconds by postgrey-1.27 at vger.kernel.org; Sat, 16 Dec 2006 14:38:45 EST
Message-ID: <45844374.60903@web.de>
Date: Sat, 16 Dec 2006 20:05:24 +0100
From: Lee Garrett <lee-in-berlin@web.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061128 Thunderbird/1.5.0.8 Mnenhy/0.7.4.666
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc5: grub is much slower resuming from suspend-to-disk
 than in 2.6.18
References: <200611121436.46436.arvidjaar@mail.ru>
In-Reply-To: <200611121436.46436.arvidjaar@mail.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Borzenkov wrote:
 > [...]
> This is rather funny; in 2.6.19-rc5 grub is *really* slow loading kernel when 
> I switch on the system after suspend to disk. Actually, after kernel has been 
> loaded, the whole resuming (up to the point I have usable desktop again) 
> takes about three time less than the process of loading kernel + initrd. 
> During loading disk LED is constantly lit. This almost looks like kernel 
> leaves HDD in some strange state, although I always assumed HDD/IDE is 
> completely reinitialized in this case.
 > [...]

I had the same problem (/boot on reiserfs, grub hanging for ages 
after resume with 2.6.19), but in 2.6.19.1 it seems fixed. Do you 
still have this bug, Andrey? I didn't find an update on this issue 
on LKML.

Greetings, Lee

