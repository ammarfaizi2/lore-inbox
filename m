Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262646AbSKMWqw>; Wed, 13 Nov 2002 17:46:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262881AbSKMWqw>; Wed, 13 Nov 2002 17:46:52 -0500
Received: from cs.columbia.edu ([128.59.16.20]:59894 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S262646AbSKMWqv>;
	Wed, 13 Nov 2002 17:46:51 -0500
Subject: figuring out which ioctl's a system needs?
From: Shaya Potter <spotter@cs.columbia.edu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1037228009.715.15.camel@zaphod>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.90 (Preview Release)
Date: 13 Nov 2002 17:53:29 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to figure out what is the subset of ioctl's a system needs to
run.  I figure the best way is sticking a printk in sys_ioctl, and
having it printk the number, so that syslog can pick it up, and then go
through the list.  This way I can use the system normally for a week to
collect the information I need.

Is there an easier way, or is there a way that I can make my life easier
(i.e. going from printk'd number to header file include).

thanks,

shaya potter

