Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272980AbTHFBDr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 21:03:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272983AbTHFBDr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 21:03:47 -0400
Received: from tomts16-srv.bellnexxia.net ([209.226.175.4]:46545 "EHLO
	tomts16-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S272980AbTHFBDo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 21:03:44 -0400
Message-ID: <3F3053F2.7050803@linuxfreak.ca>
Date: Tue, 05 Aug 2003 21:03:46 -0400
From: Patrick McLean <pmclean@linuxfreak.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030731
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [2.6] Perl weirdness with ext3 and HTREE
References: <1059856625.14962.19.camel@nosferatu.lan> <20030805182847.GA20850@vmware.com>
In-Reply-To: <20030805182847.GA20850@vmware.com>
X-Enigmail-Version: 0.76.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It is possible to install gentoo in a subdir of your main box, just 
unzip the tarball
into that directory, then chroot to it and follow the rest of the steps 
for installation
(skipping kernel, bootloader, syslog, etc of course), then you can test 
stuff out by just chrooting to the gentoo dir, and doing "env-update ; 
source /etc/profile".

Christopher Li wrote:

>I can take a look at it.
>
>Is there any way to reproduce this bug without installing the
>whole gentoo? It would be nice if I can just download some
>package to make it happen.
>
>Thanks,
>
>Chris
>
>
>On Sat, Aug 02, 2003 at 10:37:05PM +0200, Martin Schlemmer wrote:
>  
>
>>Hi
>>
>>I have mailed about this previously, but back then it was not
>>really confirmed, so I have let it be at that.
>>
>>Anyhow, problem is that for some reason 2.5/2.6 ext3 with HTREE
>>support do not like what perl-5.8.0 does during installation.
>>It *seems* like one of the temporary files created during manpage
>>installation do not get unlinked properly, or gets into the
>>hash (this possible?) and cause issues.
>>
>>It seems to work flawless on 2.4 still.
>>
>>Also, to be honest, I do not have that much free time these days,
>>so if an interest in helping me/us debug this, it will be appreciated
>>if some direction in what is needed/suggestions can be given as to what
>>is required.  There are a few users that experience this issue, and
>>I am sure that we can get whatever info needed.
>>
>>A bug on our tracker is here with more (hopefully) complete info:
>>
>>  http://bugs.gentoo.org/show_bug.cgi?id=24991
>>
>>
>>Thanks,
>>
>>-- 
>>
>>Martin Schlemmer
>>
>>
>>
>>    
>>
>
>
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>  
>

