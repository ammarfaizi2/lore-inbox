Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751008AbVHVXfd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751008AbVHVXfd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 19:35:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751303AbVHVXfd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 19:35:33 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:58836 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S1751008AbVHVXfc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 19:35:32 -0400
Subject: Re: [patch] swsusp: fix error handling and cleanups
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@zip.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050822090047.GA8841@elf.ucw.cz>
References: <20050822090047.GA8841@elf.ucw.cz>
Content-Type: text/plain
Organization: Cyclades
Message-Id: <1124753721.5093.11.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 23 Aug 2005 09:35:21 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Mon, 2005-08-22 at 19:00, Pavel Machek wrote:
> @@ -1207,7 +1208,6 @@ static int check_sig(void)
>  		 */
>  		error = bio_write_page(0, &swsusp_header);
>  	} else { 
> -		printk(KERN_ERR "swsusp: Suspend partition has wrong signature?\n");
>  		return -EINVAL;
>  	}

This is an especially good change - I've seen some bogus displays of
this message but haven't looked into why, sorry.

Regards,

Nigel

-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.

