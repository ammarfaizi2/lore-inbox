Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262958AbTJZJC1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 04:02:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262970AbTJZJC1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 04:02:27 -0500
Received: from mail-10.iinet.net.au ([203.59.3.42]:29660 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S262958AbTJZJCY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 04:02:24 -0500
Message-ID: <3F9B9BEB.5060908@cyberone.com.au>
Date: Sun, 26 Oct 2003 21:03:23 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: "Jeffrey E. Hundstad" <jeffrey@hundstad.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: [long] linux-2.6.0-test9, XFree86 4.2.1.1, ATI ATI Radeon VE
 QY, screen hangs on 3d apps
References: <3F9B8A6B.6030102@hundstad.net>
In-Reply-To: <3F9B8A6B.6030102@hundstad.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Jeffrey E. Hundstad wrote:

> Hello,
>
> I'm using Debian unstable.  It comes with XFree86 Vesrion 4.2.1.1.  
> This works fine with linux-2.4.22.  I've been using this configuration 
> with accelerated 3d apps.  With linux-2.6.0-test9 X works fine until a 
> 3d application such as glxgears starts.  The screen no longer updates 
> except that you can move the cursor.  The logs do not indicate 
> failure.  I can't get the screen back without a reboot.  I can connect 
> via. the network to do analysis if someone wants to give me a clue 
> what to look for.


renice 0 `pidof X`

How does it go with X at default priority?


