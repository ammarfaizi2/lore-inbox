Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262081AbVBJKCj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262081AbVBJKCj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 05:02:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262087AbVBJKCj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 05:02:39 -0500
Received: from ip213-185-37-13.laajakaista.mtv3.fi ([213.185.37.13]:640 "EHLO
	three.holviala.com") by vger.kernel.org with ESMTP id S262081AbVBJKCh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 05:02:37 -0500
Message-ID: <420B2B01.5020206@holviala.com>
Date: Thu, 10 Feb 2005 11:36:01 +0200
From: Kim Holviala <kim@holviala.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Spontaneous reboot with 2.6.10 and NFSD
References: <420B0FCD.4000801@holviala.com> <16907.10130.293919.399727@cse.unsw.edu.au>
In-Reply-To: <16907.10130.293919.399727@cse.unsw.edu.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:
> On Thursday February 10, kim@holviala.com wrote:
> 
>>Anyway, I mount the export to a Linux client (tried with a few with 
>>different 2.6 kernels and distros) and then start copying files from 
>>clients CDROM to the server through NFS. After copying a few small 
>>files, the first big one reboots the server.
> 
> Can you be specific about the size of the "big" file?

Well, there were two bigger files, the first 18 megs and the second 35 
megs and the copying never got past those two. But in the end it wasn't 
the size - I was able to make it reboot with a small C source file...

> Also, what filesystem is being used on the server, what mount flags
> (if any) and what export options.

All the files are here:
http://www.holviala.com/~kimmy/crash/mount

Mount options:
/dev/md8 on /boot type ext3 (rw,nosuid,noatime)

I forgot to transfer the exports file, and now the server is dead... 
Will do that later.

> Having some sort of console, whether VGA, serial, or network, to view
> the Oops would be invaluable.

I'll carry the server next to a monitor once I get back home.



Kim
