Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261829AbTDGOCZ (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 10:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262623AbTDGOCZ (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 10:02:25 -0400
Received: from chiba.3jane.net ([64.57.168.198]:60618 "EHLO chiba.3jane.net")
	by vger.kernel.org with ESMTP id S261829AbTDGOCY (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 10:02:24 -0400
Message-ID: <3E91867A.1040504@gentoo.org>
Date: Mon, 07 Apr 2003 10:08:58 -0400
From: Nicholas Wourms <dragon@gentoo.org>
User-Agent: Mozilla/5.0 (Windows; U; Win 9x 4.90; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nikita Danilov <Nikita@Namesys.COM>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove kdevname() before someone starts using it again
References: <20030331162634.A14319@lst.de>	<3E908DF6.1050004@gentoo.org> <16017.11269.576246.373826@laputa.namesys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita Danilov wrote:
> Nicholas Wourms writes:
>  > 
>  > A quick grep shows that Intermezzo FS still uses kdevname if 
>  > you've turned on debugging (fs/intermezzo/sysctl.c).  As for 
>  > pending stuff, both Reiser4 & pktcdvd also use it.  So I 
> 
> reiser4 switched to bdevname().
> 

When will the reiser4 bk repo be updated to reflect this? 
It has been pretty quiet for the last few days or so, 
compared to the daily updating it used to get.  As of 
yesterday, trying to compile reiser4 as a module yeilded the 
undefined reference to kdevname in a few places, not to 
mention a few other undefined references as well...

Cheers,
Nicholas

