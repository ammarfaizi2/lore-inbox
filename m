Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261510AbULFMLR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261510AbULFMLR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 07:11:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261515AbULFMLR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 07:11:17 -0500
Received: from hermine.aitel.hist.no ([158.38.50.15]:34824 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S261510AbULFMLF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 07:11:05 -0500
Message-ID: <41B44E03.8090007@hist.no>
Date: Mon, 06 Dec 2004 13:18:11 +0100
From: Helge Hafting <helge.hafting@hist.no>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Robert Love <rml@novell.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       Con Kolivas <kernel@kolivas.org>, Jeff Sipek <jeffpc@optonline.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Time sliced CFQ #2
References: <20041204104921.GC10449@suse.de> <20041204163948.GA20486@optonline.net> <20041205185844.GF6430@suse.de> <20041206002954.GA28205@optonline.net> <41B3BD0F.6010008@kolivas.org> <20041206022338.GA5472@optonline.net> <41B3C54B.1080803@kolivas.org> <CED75073-4743-11D9-9115-000393ACC76E@mac.com> <1102310049.6052.123.camel@localhost> <20041206071923.GC10498@suse.de>
In-Reply-To: <20041206071923.GC10498@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:

>On Mon, Dec 06 2004, Robert Love wrote:
>  
>
>>
>>	(1) separate the two values.  we have a scheduling
>>	    priority (distributing the finite resource of
>>	    processor time) and an I/O priority (distributing
>>	    the finite resource of disk bandwidth).
>>	(2) just have a single value.
>>    
>>
>
>They are inherently seperate entities, I don't think mixing them up is a
>good idea. IO priorities also includes things like attempting to
>guarentee disk bandwidth, it isn't always just a 'nice' value.
>  
>
Two separate entities is fine.  Those who want just one
entity can use a "nice wrapper" that sets both
simultaneously.

Helge Hafting
