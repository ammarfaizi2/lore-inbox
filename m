Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262279AbUGLUcF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262279AbUGLUcF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 16:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263024AbUGLUbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 16:31:45 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:11775 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262837AbUGLU3l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 16:29:41 -0400
Message-ID: <40F2F4B2.3080104@acm.org>
Date: Mon, 12 Jul 2004 15:29:38 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030428
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joerg Paysen <paysen@rob.uni-luebeck.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: stock 2.6.7: modprobe ipmi_si hangs
References: <1089454814.2869.10.camel@ing>
In-Reply-To: <1089454814.2869.10.camel@ing>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, I've been on vacation for a week.

This is fixed in the next release of the kernel.  If you want a fix now, 
you can download the patch to fix it from http://openipmi.sf.net.  Go 
there, and then to the downloads page.

-Corey

Joerg Paysen wrote:

>hello,
>
>i have a intel serverboard SE7501WV2 wich supports ipmi 1.5.
>i compiled ipmi_devintf, ipmi_msghandler and ipmi_si as kernel
>modules. modprobing ipmi_msghandler and ipmi_devintf works fine and
>dmesg shows:
> 
>ipmi message handler version v31
>ipmi device interface version v31
>IPMI System Interface driver version v31, KCS version v31, SMIC version
>v31, BT
>version v31
> 
>when i do a 'modprobe ipmi_si' modprobe does not return and ps ax
>shows:
> 
>6380 ?        D      0:00 modprobe ipmi_si
> 
>and dmesg shows:
> 
>ipmi_si: Found SMBIOS-specified state machine at I/O address 0xca2
> 
>any help?
> 
>thanks all
>joerg
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>  
>


