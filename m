Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262796AbUDLKj7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 06:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262802AbUDLKj7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 06:39:59 -0400
Received: from bay14-f48.bay14.hotmail.com ([64.4.49.48]:7944 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S262796AbUDLKjy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 06:39:54 -0400
X-Originating-IP: [217.132.88.253]
X-Originating-Email: [qwejohn@hotmail.com]
From: "John Que" <qwejohn@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: printk redirection to a different file
Date: Mon, 12 Apr 2004 13:39:49 +0300
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY14-F48FudQ3yeYsb0003ff1e@hotmail.com>
X-OriginalArrivalTime: 12 Apr 2004 10:39:50.0059 (UTC) FILETIME=[7B569FB0:01C4207A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I had added printk calls in a linux kernel module
for debug purposes.
Now , I want that this calls will be loggoed not to
/var/log/messages (this is where
the printk messages  are on RH9) but to a different file.

I am thinking of one main alternative:

create a debug_printk() method (by  copying the printk.c to debug_printk.c
, doing needed changes , and call debug_printk() method instead of
printk() methods where I want messages to a different log file).

Problem is that I do not see where in printk.c it
says that the messages will go to /var/log/messages.

(I assume that this is done with a logging system daemon).


any idea what to do ?
regards,
John

_________________________________________________________________
The new MSN 8: smart spam protection and 2 months FREE*  
http://join.msn.com/?page=features/junkmail

