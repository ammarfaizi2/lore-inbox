Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263776AbTK2Pji (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Nov 2003 10:39:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263784AbTK2Pji
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Nov 2003 10:39:38 -0500
Received: from mail.gmx.net ([213.165.64.20]:23234 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263776AbTK2Pjh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Nov 2003 10:39:37 -0500
X-Authenticated: #4512188
Message-ID: <3FC8BDB6.2030708@gmx.de>
Date: Sat, 29 Nov 2003 16:39:34 +0100
From: "Prakash K. Cheemplavam" <prakashpublic@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031116
X-Accept-Language: de-de, de, en-us, en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org, marcush@onlinehome.de
Subject: Re: Silicon Image 3112A SATA trouble
References: <3FC36057.40108@gmx.de>
In-Reply-To: <3FC36057.40108@gmx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Holy Shit!

I just tried the libata driver and it ROCKSSSS! So far, at least.

I already wrote about the crappy SiI3112 ide driver, now with libata I 
get >60mb/sec!!!! More then I get with windows.

Also tests with dd. This rocks. Lets see whether it likes swsup, as well...

So folks, try libata, as well.

I dunno what all is actuall needed. I enabled scsi, scie disk, scsi 
generic, sata and its driver. In grub I appended "doataraid noraid".

YES!

Prakash

