Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267094AbTAPOGG>; Thu, 16 Jan 2003 09:06:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267099AbTAPOGG>; Thu, 16 Jan 2003 09:06:06 -0500
Received: from ausmtp01.au.ibm.COM ([202.135.136.97]:63143 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP
	id <S267094AbTAPOGF>; Thu, 16 Jan 2003 09:06:05 -0500
Message-ID: <3E26BF92.3020303@ToughGuy.net>
Date: Thu, 16 Jan 2003 19:50:02 +0530
From: Linux Geek <bourne@ToughGuy.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Tar'ing /proc ???
References: <Pine.LNX.3.95.1030116090109.4226A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Richard B. Johnson wrote:

>Normally, you do `tar -clf`
>                        |________ stay on the same file-system.
>Otherwise toy need to use --exclude /proc.  Proc is a virtual
>file-system that contains things like kcore. You can get into
>a deadlock when reading kcore and you don't want this in your
>backup anyway.
>
>
>  
>
so it means,  I can read /proc , write through sysctl interface but no 
'copy' business ;-) .

