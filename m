Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262800AbUDLKrO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 06:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262810AbUDLKrO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 06:47:14 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:55726 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S262800AbUDLKrM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 06:47:12 -0400
Subject: Re: printk redirection to a different file
From: Vladimir Saveliev <vs@namesys.com>
To: John Que <qwejohn@hotmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <BAY14-F48FudQ3yeYsb0003ff1e@hotmail.com>
References: <BAY14-F48FudQ3yeYsb0003ff1e@hotmail.com>
Content-Type: text/plain
Message-Id: <1081766830.1183.34.camel@tribesman.namesys.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Mon, 12 Apr 2004 14:47:10 +0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

On Mon, 2004-04-12 at 14:39, John Que wrote:
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
man syslog.conf

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

