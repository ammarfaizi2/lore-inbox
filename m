Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750820AbWGKOaH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820AbWGKOaH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 10:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750823AbWGKOaH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 10:30:07 -0400
Received: from smtpq1.tilbu1.nb.home.nl ([213.51.146.200]:40612 "EHLO
	smtpq1.tilbu1.nb.home.nl") by vger.kernel.org with ESMTP
	id S1750820AbWGKOaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 10:30:06 -0400
Message-ID: <44B3B680.4040101@keyaccess.nl>
Date: Tue, 11 Jul 2006 16:32:32 +0200
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Olaf Hering <olaf@aepfle.de>
CC: "H. Peter Anvin" <hpa@zytor.com>, Roman Zippel <zippel@linux-m68k.org>,
       torvalds@osdl.org, klibc@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: [klibc] klibc and what's the next step?
References: <klibc.200606251757.00@tazenda.hos.anvin.org>	<Pine.LNX.4.64.0606271316220.17704@scrub.home> <20060711044834.GA11694@suse.de>
In-Reply-To: <20060711044834.GA11694@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Hering wrote:

 > I do not want to see kinit merged.

For what it's worth -- I as a user am violently opposed to kinit not 
being in the source tree, if _anything_ is merged.

Given that's it's intended to take over kernel functionality, kinit 
would be a tightly coupled piece of software and a number of problems 
2.6 has seen are with tightly coupled software (udev, alsa-lib) getting 
out of sync with the kernel. I believe someone from redhat complained 
about it last. Adding another tightly coupled external app to the mix is 
just going to worsen the situation. Please don't do that.

And yes, then there's the issue of keeping distributions all using the 
same thing which I saw someone else remark on as well. If klibc/kinit is 
the way forward, please make sure kinit is in the kernel source tree.

Rene.

