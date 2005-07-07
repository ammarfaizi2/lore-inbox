Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262239AbVGHAbZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262239AbVGHAbZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 20:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262360AbVGHAbZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 20:31:25 -0400
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:55703
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S262239AbVGHAbY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 20:31:24 -0400
Message-ID: <42CDBB3B.6020803@linuxwireless.org>
Date: Thu, 07 Jul 2005 18:31:07 -0500
From: Alejandro Bonilla <abonilla@linuxwireless.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Jon Escombe <lists@dresco.co.uk>
CC: Jens Axboe <axboe@suse.de>, Shawn Starr <spstarr@sh0n.net>,
       hdaps-devel@lists.sourceforge.net, Lenz Grimmer <lenz@grimmer.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Jesper Juhl <jesper.juhl@gmail.com>, Dave Hansen <dave@sr71.net>,
       LKML List <linux-kernel@vger.kernel.org>
Subject: Re: IBM HDAPS things are looking up (was: Re: [Hdaps-devel] Re: [ltp]
 IBM HDAPS Someone interested? (Accelerometer))
References: <42C8D06C.2020608@grimmer.com> <20050704110604.GL1444@suse.de> <20050707080323.GF1823@suse.de> <200507071028.06765.spstarr@sh0n.net> <20050707150548.GD24401@suse.de> <42CDB3F9.5010402@dresco.co.uk>
In-Reply-To: <42CDB3F9.5010402@dresco.co.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Escombe wrote:

> Jens Axboe wrote:
>
>> Note on that - if the util says it parked, you can be very sure that it
>> actually did as the drive actually returns that status outside of just
>> completing the command.
>>  
>>
> It's worth noting that you'll need the libata passthrough patch to 
> make this work on a T43..
>
> However, with this patch I'm getting the "head not parked 4c" message, 
> but I can hear the click from the drive.. It takes around 350-400ms 
> for the command to execute, but when repeated, it drops to around 5ms 
> for a short while (with no audible clicking), before reverting to 
> original behaviour after a few seconds.
>
> The clicking and the variation in execution time lead me to think it 
> is parking, but not being reported correctly?
>
> Regards,
> Jon,

Jon,

    Most likely it might be doing it but returning inmediately. If you 
are in a quiet place, you should be able to notice the change.

    You can test this by having 2 consoles. With one you run the command 
and with the other one, try going deep into the filesystem, you should 
notice that it takes awhile to find the files and folders.

If it is fast, then is not parking.

.Alejandro
