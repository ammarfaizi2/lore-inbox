Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261983AbUBWWwQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 17:52:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262067AbUBWWwP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 17:52:15 -0500
Received: from zeus.kernel.org ([204.152.189.113]:58809 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261983AbUBWWuo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 17:50:44 -0500
Message-ID: <403A8409.3040205@comcast.net>
Date: Mon, 23 Feb 2004 16:51:53 -0600
From: Karl Tatgenhorst <ketatgenhorst@comcast.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: andreas.hartmann@fiducia.de
CC: linux-kernel@vger.kernel.org
Subject: Re: distinguish two identical network cards
References: <OF3A73498C.45F49506-ONC1256E43.002FC840@fiducia.de>
In-Reply-To: <OF3A73498C.45F49506-ONC1256E43.002FC840@fiducia.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


   If you pay attention to what slot you are putting them in you could 
script the install using lspci to get the cards right. ie...slots 3 & 4 
are nics so eth0 = `lspci | grep for slot 3`  of  course grep for slot 3 
may need replaced, use the man pages and play around.

Karl

andreas.hartmann@fiducia.de wrote:

>Hello!
>
>I've got a little problem with XSeries machines, containing two identical
>builtin Broadcom NIC's. Is there any chance to get some information, which one
>of the two cards is the upper, and which one is the lower card?
>I need this information, because I want to install a lot of these machines
>automatically.
>
>
>Thank you for every hint,
>kind regards,
>Andreas Hartmann
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>


