Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291044AbSBGB0c>; Wed, 6 Feb 2002 20:26:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291048AbSBGB0X>; Wed, 6 Feb 2002 20:26:23 -0500
Received: from smtp02.web.de ([217.72.192.151]:44806 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id <S291044AbSBGB0N>;
	Wed, 6 Feb 2002 20:26:13 -0500
Message-ID: <3C61D6B0.2040608@web.de>
Date: Thu, 07 Feb 2002 02:21:52 +0100
From: Todor Todorov <ttodorov@web.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20020104
X-Accept-Language: en-us
MIME-Version: 1.0
To: jss@pacbell.net
CC: linux-kernel@vger.kernel.org
Subject: Re: Kernel reboot problem
In-Reply-To: <PGEMINDOPMDNMJINCKBNEEELCAAA.jss@pacbell.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>-cp bzImage to /boot/vmlinuz-2.4.17
>

do you really mena bzImage or arch/i386/bootbzImage ? And it would be 
very helpful if you can provide the compile options. Without them or 
only with the information from your mail is hard to tell what is going 
wrong. Your compile settings are stored in the $LINUX_SRC/.config file. 
The way you did it though is correct. You culd skip mproper on a newly 
untarred kernel and the make clean after the first config but it doesn't 
hurt if you do it. The failure is in your .config probably.

Greets,
        Todor

