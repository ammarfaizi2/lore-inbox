Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932360AbVJaTic@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932360AbVJaTic (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 14:38:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932398AbVJaTic
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 14:38:32 -0500
Received: from nproxy.gmail.com ([64.233.182.203]:64896 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932360AbVJaTib (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 14:38:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:organization:user-agent:x-accept-language:mime-version:to:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=p7O7UYcN7toIpOoZ+gMhJz35p2amltFLjkExIyCbFLwjb8BpirIjhhdwi67b8io85x9obQd8AoKiSg/aH75XDZsDQZyDyx1FOyTA1hBNh1ZyYGoGligtB3QDWHduOOYNV1JDruAnibFbOFcyNV4uzDlM2gaID72mBKWSaguc2Ng=
Message-ID: <436672AB.5050604@gmail.com>
Date: Mon, 31 Oct 2005 20:38:19 +0100
From: Patrizio Bassi <patrizio.bassi@gmail.com>
Reply-To: patrizio.bassi@gmail.com
Organization: patrizio.bassi@gmail.com
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051027)
X-Accept-Language: it, it-it, en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>,
       "Kernel, " <linux-kernel@vger.kernel.org>
Subject: Re: [BUG 2579] linux 2.6.* sound problems
References: <53JVy-4yi-19@gated-at.bofh.it> <53Lus-73L-39@gated-at.bofh.it>
In-Reply-To: <53Lus-73L-39@gated-at.bofh.it>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell ha scritto:
> On Mon, 2005-10-31 at 16:30 +0100, Patrizio Bassi wrote:
> 
>>starting from 2.6.0 (2 years ago) i have the following bug.
>>
>>link: http://bugzilla.kernel.org/show_bug.cgi?id=2579
>>and https://bugtrack.alsa-project.org/alsa-bug/view.php?id=230
>>
>>fast summary:
>>when playing audio and using a bit the harddisk (i.e. md5sum of a 200mb
>>file)
>>i hear noises, related to disk activity. more hd is used, more chicks
>>and ZZZZ noises happen.
>>
>>linux 2.4.x and windows has no problems, perfect.
>>tried module/standalone alsa drivers.
> 
> 
> Your problem is a "singing capacitor", caused by cheap motherboard
> components.  The problem appeared in 2.6.0 because that's when the timer
> frequency changed from 100HZ to 1000HZ.
> 
> Starting with 2.6.14 you can work around this by compiling with HZ set
> to 250 or 100.  But it's fundamentally a hardware problem.
> 
> Lee

I have an Asus P2B-F, it should be a value board and not a cheap one.

i have 250hz and it still happens.

i'll check with 100, even if i see it's suggested for server and not
desktop (my usage)
