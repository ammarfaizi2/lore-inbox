Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261713AbUBVRvn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 12:51:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261712AbUBVRvn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 12:51:43 -0500
Received: from bay8-f58.bay8.hotmail.com ([64.4.27.58]:5643 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id S261713AbUBVRvk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 12:51:40 -0500
X-Originating-IP: [217.185.85.165]
X-Originating-Email: [redzic_fadil@hotmail.com]
From: "redzic fadil" <redzic_fadil@hotmail.com>
To: linux-kernel@vger.kernel.org
Date: Sun, 22 Feb 2004 18:51:39 +0100
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Message-ID: <BAY8-F58uoHWh7qdDZ700010d93@hotmail.com>
X-OriginalArrivalTime: 22 Feb 2004 17:51:40.0063 (UTC) FILETIME=[863FFAF0:01C3F96C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello


I hope I don't disturb,


I have tried to compile the hello.c module under kernel 2.6.3.
And I'd like to insert the hello.o module in the kernel.
But this doesn't work with kernel 2.6.3 .

I have compiled this module with kernel 2.4.* and it is well.

Also I cannot include the header file module.h, because I get error 
messages.

my module:
#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/init.h>


int initial_module (void)
{
	printk("\ninitial module\n");
	return (0);
}

void delete_module (void)
{
	printk("\ndelete module\n");
}

module_init(initial_module);
module_exit(delete_module);


my Makefile:
CC=gcc
CFLAGS=-isystem /lib/modules/`uname -r`/build/include -O2 -D__KERNEL__ 
-DMODULE
all: hello.o

If you have any idea please send an E-Mail:  redzic_fadil@hotmail.com

thanks

_________________________________________________________________
Die ultimative Fan-Seite für den MSN Messenger http://www.ilovemessenger.de 
Emoticons und Hintergründe kostenlos downloaden!

