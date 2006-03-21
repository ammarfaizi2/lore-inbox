Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751134AbWCUUDj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbWCUUDj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 15:03:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751676AbWCUUDj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 15:03:39 -0500
Received: from anchor-post-32.mail.demon.net ([194.217.242.90]:35336 "EHLO
	anchor-post-32.mail.demon.net") by vger.kernel.org with ESMTP
	id S1751134AbWCUUDi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 15:03:38 -0500
Message-ID: <44205C1A.4040408@lougher.demon.co.uk>
Date: Tue, 21 Mar 2006 20:03:38 +0000
From: Phillip Lougher <phillip@lougher.demon.co.uk>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051010)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Phillip Lougher <phillip@lougher.org.uk>, Al Viro <viro@ftp.linux.org.uk>,
       "unlisted-recipients: no To-header on input <;, Jeff Garzik" 
	<jeff@garzik.org>,
       J?rn Engel <joern@wohnheim.fh-wedel.de>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [ANN] Squashfs 3.0 released
References: <20060317104023.GA28927@wohnheim.fh-wedel.de> <C91BFAB7-C442-4EB7-8089-B55BB86EB148@lougher.org.uk> <20060317124310.GB28927@wohnheim.fh-wedel.de> <441ADD28.3090303@garzik.org> <0E3DADA8-1A1C-47C5-A3CF-F6A85FF5AFB8@lougher.org.uk> <441AF118.7000902@garzik.org> <20060319163249.GA3856@ucw.cz> <4420236F.80608@lougher.demon.co.uk> <20060321161452.GG27946@ftp.linux.org.uk> <44204F25.4090403@lougher.org.uk> <20060321191144.GB3929@elf.ucw.cz>
In-Reply-To: <20060321191144.GB3929@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> 
> Al is right. Unconditional swap is probably faster than
> branch. Avoiding swaps is nice, but avoiding branches is probably more
> important.

Quite possible.

> 
> Can you try to benchmark it? I believe it is going to be lost in
> noise, slow cpus or not.

Good idea, I'll try to benchmark it (on a slow CPU if I can find one :-) 
).  It will probably make no difference.

I don't want the lack of a fixed endianness on disk to become a problem. 
   I personally don't think the use of, or lack of a fixed endianness to 
be that important, but I'd prefer not to change the current situation 
and adopt a fixed format.  I use big endian systems almost exclusively, 
and I don't like the way fixed formats always tend to be little-endian.

