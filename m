Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262331AbTEFDL6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 23:11:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262335AbTEFDL6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 23:11:58 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:54120 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S262331AbTEFDLy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 23:11:54 -0400
Date: Mon, 5 May 2003 23:24:25 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200305060324.h463OPK26674@devserv.devel.redhat.com>
To: Hans-Georg Thien <1682-600@onlinehome.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] "Disable Trackpad while typing" on Notebooks withh   a  PS/2 Trackpad
In-Reply-To: <mailman.1052174881.22701.linux-kernel2news@redhat.com>
References: <3EB19625.6040904@onlinehome.de.suse.lists.linux.kernel> <mailman.1052174881.22701.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have eliminated the use of a timer. The patch has been simple before, 
> and now it is even more simple :)

It's pretty good, but I disagree with gratious whitespaces
like these:

> @@ -430,6 +440,7 @@
>   }
> 
> 
> +
>   static inline void handle_mouse_event(unsigned char scancode)
>   {
>   #ifdef CONFIG_PSMOUSE

-- Pete
