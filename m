Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262925AbTHVBLn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 21:11:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262936AbTHVBLn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 21:11:43 -0400
Received: from phobos.aros.net ([66.219.192.20]:59919 "EHLO phobos.aros.net")
	by vger.kernel.org with ESMTP id S262925AbTHVBLm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 21:11:42 -0400
Message-ID: <3F456DBA.5040202@aros.net>
Date: Thu, 21 Aug 2003 19:11:22 -0600
From: Lou Langholtz <ldl@aros.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-15?Q?Diego_Calleja_Garc=EDa?= <aradorlinux@yahoo.es>
Cc: jgarzik@pobox.com, willy@debian.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: [PATCH] bio.c: reduce verbosity at boot
References: <20030821150211.GU19630@parcelfarce.linux.theplanet.co.uk>	<3F44E2EB.6020508@pobox.com>	<3F44F88F.9010106@aros.net> <20030821223141.74ccb89e.aradorlinux@yahoo.es>
In-Reply-To: <20030821223141.74ccb89e.aradorlinux@yahoo.es>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Diego Calleja García wrote:

>El Thu, 21 Aug 2003 10:51:27 -0600 Lou Langholtz <ldl@aros.net> escribió:
>  
>
>>How about using KERN_DEBUG and augmenting the dmesg store so that the 
>>level that is saved is configurable? Even compile time configurable 
>>seems reasonable to start. But axeing out even the possibility of boot 
>>time info seems bad to me.
>>    
>>
>Like this?
>(14) Kernel log buffer size (16 => 64KB, 17 => 128KB)  
>Available at least in 2.6.0-test3 under "General setup"
>  
>
Yes, except I was thinking for loglevel rather than size. Is a loglevel 
option - as in only save printk's above level X in dmesg - already 
available? I've seen other emails fly by on the printk system before so 
this could well already be available. I haven't checked but was assuming 
from the emails I'd seen so far that this didn't exist and was merely 
suggesting this thinking it'd be an easy addition to the dmesg store.

