Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261567AbVGXEBZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261567AbVGXEBZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Jul 2005 00:01:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261903AbVGXEBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Jul 2005 00:01:25 -0400
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:42987
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S261567AbVGXEBY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Jul 2005 00:01:24 -0400
Message-ID: <42E30480.40909@linuxwireless.org>
Date: Sat, 23 Jul 2005 22:01:20 -0500
From: Alejandro Bonilla <abonilla@linuxwireless.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: =?ISO-8859-15?Q?Sven_K=F6hler?= <skoehler@upb.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [cpufreq] ondemand works, conservative doesn't
References: <dbucpq$7ti$1@sea.gmane.org>
In-Reply-To: <dbucpq$7ti$1@sea.gmane.org>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sven Köhler wrote:

>Hi,
>
>currently, i'm using the ondemand governor. My CPU supports the
>frequencies 800, 1800 and 2000 MHz (AMD Athlon64 Desktop with
>Cool&Quiet). The simple bash commands
>
>  
>
In my case, I have a Pentium M 1.8ghz 400 FSB. In powersave, it goes to 
1.19ghz, in conservative, it goes to 1.20GHZ and of course performance 
goes to 1.8ghz if plugged.

Conservative works well here, and so far, lt moved slowly from 
frequencies, 1.2 then in 5 seconds 1.4, 2 seconds 1.8. Then it took the 
CPU like 10 seconds to move back from 1.8ghz to 1.2..

Mine did reach the full cpu in a moment, yours looks like it not going 
over 2.0ghz. Maybe is not needing that much CPU?

If it only supports 800, 1800 and 2000 MHz, then it will only jump to 
those frequencies. I use the CPU Frequency Scaling Monitor included in 
gnome to switch between these options a lot. Maybe you could play with 
this a bit more and see how it behaves. It does look like it might need 
more frequencies, but you would need to check what does you CPU support.

.Alejandro
