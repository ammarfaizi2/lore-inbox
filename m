Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261598AbULFRph@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261598AbULFRph (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 12:45:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261592AbULFRpf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 12:45:35 -0500
Received: from gate.corvil.net ([213.94.219.177]:56074 "EHLO corvil.com")
	by vger.kernel.org with ESMTP id S261598AbULFRnZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 12:43:25 -0500
Message-ID: <41B499FE.5000603@draigBrady.com>
Date: Mon, 06 Dec 2004 17:42:22 +0000
From: P@draigBrady.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040124
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Robert Love <rml@novell.com>
CC: Kyle Moffett <mrmacman_g4@mac.com>, Jeff Sipek <jeffpc@optonline.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>,
       Con Kolivas <kernel@kolivas.org>
Subject: Re: [PATCH] Time sliced CFQ #2
References: <20041204104921.GC10449@suse.de>	 <20041204163948.GA20486@optonline.net> <20041205185844.GF6430@suse.de>	 <20041206002954.GA28205@optonline.net> <41B3BD0F.6010008@kolivas.org>	 <20041206022338.GA5472@optonline.net> <41B3C54B.1080803@kolivas.org>	 <CED75073-4743-11D9-9115-000393ACC76E@mac.com>	 <1102310049.6052.123.camel@localhost>	 <62852042-4781-11D9-9115-000393ACC76E@mac.com> <1102351338.6052.126.camel@localhost>
In-Reply-To: <1102351338.6052.126.camel@localhost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
>>The reason I proposed my ideas for tying the two values together is 
>>that I am
>>concerned about breaking existing code.  
> 
> 
> Nothing should break.
> 
> If apps don't explicitly set their i/o priority, then they get the
> default.  Not a big deal.
> 
> This allows the default case to be the same as today.
> 
> 	Robert Love

For reference, this was discussed last year:
http://marc.theaimsgroup.com/?l=linux-kernel&m=106847268508985&w=2

-- 
Pádraig Brady - http://www.pixelbeat.org
--
