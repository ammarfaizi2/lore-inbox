Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272435AbTHIQj0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 12:39:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272445AbTHIQj0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 12:39:26 -0400
Received: from galaxy.lunarpages.com ([64.235.234.165]:53434 "EHLO
	galaxy.lunarpages.com") by vger.kernel.org with ESMTP
	id S272435AbTHIQjZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 12:39:25 -0400
Message-ID: <3F352855.1090103@genebrew.com>
Date: Sat, 09 Aug 2003 12:59:01 -0400
From: Rahul Karnik <rahul@genebrew.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030706
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: war <war@lucidpixels.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Multiple problems with 2.4.21?
References: <Pine.LNX.4.56.0308081440160.5382@p500>
In-Reply-To: <Pine.LNX.4.56.0308081440160.5382@p500>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - galaxy.lunarpages.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - genebrew.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

war wrote:
> does or can the nvidia module cause other
> processes to die etc?

Yes. It's your X session that is crashing after all.

> 0: NVRM: AGPGART: unable to retrieve symbol table

And this message is repeated over and over in your logs. Unless you can 
reproduce the problem without the nvidia module loaded, it is clear 
where the problem lies.

-Rahul
-- 
Rahul Karnik
rahul@genebrew.com

