Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262815AbUDLK7e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 06:59:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262840AbUDLK7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 06:59:34 -0400
Received: from cm219.gamma177.maxonline.com.sg ([202.156.177.219]:13228 "EHLO
	garfield.anomalistic.org") by vger.kernel.org with ESMTP
	id S262815AbUDLK7c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 06:59:32 -0400
Date: Mon, 12 Apr 2004 18:59:33 +0800
From: Eugene Teo <eugene.teo@eugeneteo.net>
To: John Que <qwejohn@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: printk redirection to a different file
Message-ID: <20040412105933.GA13957@eugeneteo.net>
Reply-To: Eugene Teo <eugene.teo@eugeneteo.net>
References: <BAY14-F48FudQ3yeYsb0003ff1e@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BAY14-F48FudQ3yeYsb0003ff1e@hotmail.com>
X-Operating-System: Linux 2.6.3-rc3
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wrong mailing list.

Edit /etc/syslog.conf so that the messages will be forwarded to
a different file.

Eugene

<quote sender="John Que">
> Hello,
> 
> I had added printk calls in a linux kernel module
> for debug purposes.
> Now , I want that this calls will be loggoed not to
> /var/log/messages (this is where
> the printk messages  are on RH9) but to a different file.
> 
> I am thinking of one main alternative:
> 
> create a debug_printk() method (by  copying the printk.c to debug_printk.c
> , doing needed changes , and call debug_printk() method instead of
> printk() methods where I want messages to a different log file).
> 
> Problem is that I do not see where in printk.c it
> says that the messages will go to /var/log/messages.
> 
> (I assume that this is done with a logging system daemon).
> 
> 
> any idea what to do ?
> regards,
> John
> 
> _________________________________________________________________
> The new MSN 8: smart spam protection and 2 months FREE*  
> http://join.msn.com/?page=features/junkmail
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
Eugene TEO -  <eugeneteo%null!cc!uic!edu> <http://www.anomalistic.org/>
1024D/14A0DDE5 print D851 4574 E357 469C D308  A01E 7321 A38A 14A0 DDE5
main(i) { putchar(182623909 >> (i-1) * 5&31|!!(i<7)<<6) && main(++i); }

