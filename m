Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751240AbVIYISQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240AbVIYISQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 04:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751242AbVIYISQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 04:18:16 -0400
Received: from zproxy.gmail.com ([64.233.162.192]:19827 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751240AbVIYISQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 04:18:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:organization:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=qFYr6FSpTpN8mQynUKpknvdyXAF3cSMqeTzkT9OCGHdKBeZ84wyGq0SRRnx/97mOS1DOGabzDZ5pESgrD0WEtElQogoeMSHXq+14E1USyhMEe6vOlLtzfNTgcAQcnhw2/rU8YjI3I+QJDz3YDf622fZOJZXzrR6asdlJRIL1RfI=
Message-ID: <43365D3D.6050608@gmail.com>
Date: Sun, 25 Sep 2005 10:18:05 +0200
From: Patrizio Bassi <patrizio.bassi@gmail.com>
Reply-To: patrizio.bassi@gmail.com
Organization: patrizio.bassi@gmail.com
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050810)
X-Accept-Language: it, it-it, en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: "Kernel," <linux-kernel@vger.kernel.org>,
       alsa-devel <alsa-devel@lists.sourceforge.net>
Subject: Re: [BUG] alsa volume and settings not restored after suspend
References: <4335909D.2070904@gmail.com> <1127593697.18892.1.camel@mindpipe>
In-Reply-To: <1127593697.18892.1.camel@mindpipe>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell ha scritto:

>On Sat, 2005-09-24 at 19:45 +0200, Patrizio Bassi wrote:
>  
>
>>-----BEGIN PGP SIGNED MESSAGE-----
>>Hash: SHA1
>>
>>As topic.
>>
>>Suspend works perfectly, but after resume, no sound from audio card.
>>    
>>
>
>I'm not surprised, suspend/resume is not implemented for that device.
>
>It looks like it would not be too hard, see es1938.c for an example.
>
>Lee
>
>
>  
>
ok, suspend/resume functions are very very simple.

the problem is i have really 0 experience in alsa devel, for example i 
don't know
the 0xa0 limit (in es1938...).

so...i'm asking for alsa devel to implement that, i'll be happy to help 
you in testing and debugging.

Thanks

Patrizio

