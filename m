Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261594AbULITn7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261594AbULITn7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 14:43:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261597AbULITn7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 14:43:59 -0500
Received: from rproxy.gmail.com ([64.233.170.193]:9852 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261594AbULITn4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 14:43:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:return-path:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:x-enigmail-supports:content-type:content-transfer-encoding;
        b=gttCik6jrPPQ+uhMn384HGO+r4lyYkd2OkgotQb8MwNBwy5MFx6tHb0wRbJef4L0E+uuUS8tFXp5lpjUq0ZEeC27tzNyV0YBoRq8MUa3HjLI1zONuyiWzc4+R3AwNm3zpKJcB0tDUagXF4785EtPazn4nMmETtnUzKowGOJBuHg=
Message-ID: <41B8AAF9.6000807@gmail.com>
Date: Thu, 09 Dec 2004 21:43:53 +0200
From: Matan Peled <chaosite@gmail.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: rich turner <rich@storix.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: initrd and fc3
References: <1102620480.19320.8.camel@rich>
In-Reply-To: <1102620480.19320.8.camel@rich>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rich turner wrote:

>i am testing fc3 by using an old-school initrd. by old-school i mean not
>the new initramfs/cpio type initrd. the process i use to create the
>initrd works for all other distributions (suse, mandrake, debian, fc2,
>2.2.x, 2.4.x, 2.6.x, etc) but fails with fc3 (2.6.9-1.667).
>
>upon system boot, the kernel executes, checks to see if the initrd is
>initramfs (it isnt), finds the initrd (ext2), mounts it, and then
>immediately exits without executing linuxrc.
>
>anyone have any ideas as to why linuxrc is not being executed?
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>
You pretty much deduced the bug is in FC3, and not the general kernel...

So why exactly is this on topic on LKML?


Is the bug reproducible on a vanilla kernel.org kernel?

- Mif

