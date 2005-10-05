Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030444AbVJEXmF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030444AbVJEXmF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 19:42:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030445AbVJEXmF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 19:42:05 -0400
Received: from [67.137.28.189] ([67.137.28.189]:11392 "EHLO vger.utah-nac.org")
	by vger.kernel.org with ESMTP id S1030444AbVJEXmE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 19:42:04 -0400
Message-ID: <43445238.5030900@utah-nac.org>
Date: Wed, 05 Oct 2005 16:22:48 -0600
From: jmerkey <jmerkey@utah-nac.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Airlie <airlied@gmail.com>
Cc: Nix <nix@esperi.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Why no XML in the Kernel?
References: <20051002094142.65022.qmail@web51012.mail.yahoo.com>	 <35fb2e590510021153r254b7eb0haf9f9e365bed051e@mail.gmail.com>	 <87oe66r62s.fsf@amaterasu.srvr.nix>	 <20051003153515.GW7992@ftp.linux.org.uk>	 <87zmpqbcws.fsf@amaterasu.srvr.nix>	 <21d7e9970510051411y2f2871a7mafa2e96cce277657@mail.gmail.com>	 <87br23odls.fsf@amaterasu.srvr.nix>	 <21d7e9970510051557u42ae32f0rca46e951c5da536f@mail.gmail.com>	 <8764sbwoj7.fsf@amaterasu.srvr.nix> <21d7e9970510051636g29012748o77124c1c1abc9259@mail.gmail.com>
In-Reply-To: <21d7e9970510051636g29012748o77124c1c1abc9259@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Airlie wrote:

>>Ah. So, er, the DRM<-> userspace protocol is stable, then?
>>
>>Looks like I was working on bad assumptions (assuming the DRM and X were
>>tied). I'm not sure where those assumptions came from. Possibly just
>>that they shared a CVS repo, although I'd hope I'd had more evidence
>>than that. I realy can't recall.
>>    
>>
>
>In theory yes, on occasion I do get bugs that break XFree86 4.3, but
>these are bugs as opposed to design decisions, upgrading the kernel
>should never require upgrading to a new  version of X or anything like
>that, however upgrading X can sometimes require a newer kernel in
>order to take advantage of newer drm features.. but X should always
>work with the older drms...
>
>Dave.
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>
How about putting the ability to disable graphics mode in the kernel and 
moving this capability from X, and saving the video state. Would make 
kernel debuggers work a hell of a lot better when the damn thing crashes 
in X in the kernel. At least then the screen won;t be locked up (of 
course you can type "reboot " from memory while the system is still hung 
in X).

Jeff
