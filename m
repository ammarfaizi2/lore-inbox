Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262730AbTK2UUo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Nov 2003 15:20:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262790AbTK2UUo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Nov 2003 15:20:44 -0500
Received: from gw-undead3.tht.net ([216.126.84.18]:47488 "HELO mail.undead.cc")
	by vger.kernel.org with SMTP id S262730AbTK2UUm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Nov 2003 15:20:42 -0500
Message-ID: <3FC8FF94.3040106@undead.cc>
Date: Sat, 29 Nov 2003 15:20:36 -0500
From: John Zielinski <grim@undead.cc>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20031013 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John Zielinski <grim@undead.cc>
CC: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: Rootfs mounted from user space - problem with umount
References: <3FC82D8F.9030100@undead.cc> <20031129053128.GF8039@holomorphy.com> <3FC8394A.7010702@undead.cc> <20031129062136.GH8039@holomorphy.com> <3FC869A3.8070809@undead.cc> <20031129094435.GS14258@holomorphy.com> <3FC8FB58.6080708@undead.cc>
In-Reply-To: <3FC8FB58.6080708@undead.cc>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Zielinski wrote:

> +      +config RAMFS_ROOTFS
> +    bool +    depends on !SHM_ROOTFS
> +    default y
> +    select RAMFS
> +
>  
>  
>
> -config RAMFS
> -    bool
> +config RAMFS +    tristate "Ramfs file system support"
>     default y


Doh.  Looks like my mailer combined a few lines when I pasted the patch 
into my message.   There's three places shown above where the + is not 
at the start of the line.   Just edit that before applying the patch.

John



