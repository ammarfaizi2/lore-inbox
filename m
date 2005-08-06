Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261780AbVHFHjx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261780AbVHFHjx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 03:39:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262019AbVHFHjx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 03:39:53 -0400
Received: from wproxy.gmail.com ([64.233.184.192]:44863 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261780AbVHFHjw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 03:39:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=t4CNi0f4g5aec/bpmt3BvQXASOVS2WzreNY6yIDp/PTWVSjz0cEc7Pf2krIlTXNzx9ZMQvlp1sg3+BO02FchudkrmOrTdd67KEQUhn6ZodwEo3NI6L5diganqA2aNy39FDo9PHobLhOylImGHFatbyIH2Au9UCWAV4//zfYZZP4=
Message-ID: <42F46941.6040607@gmail.com>
Date: Sat, 06 Aug 2005 09:39:45 +0200
From: "scientica (GMail)" <scientica@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050724)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: linux-kernel@vger.kernel.org, ck list <ck@vds.kolivas.org>
Subject: Re: [ck] 2.6.12-ck5
References: <200508061247.44391.kernel@kolivas.org>
In-Reply-To: <200508061247.44391.kernel@kolivas.org>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:

>-schediso2.12.diff
>SCHED_ISO was dropped entirely. It broke in ck4, and there is now a decent 
>defacto standard for unprivileged realtime in mainline kernel with realtime 
>RLIMITS so I'm supporting the use of that instead.
>  
>
Just a silly question, what will happen if one tries to set SCHED_ISO
(with eg schedtool))? will the program just coninue as SCHED_NORM or die
by some signal?

(btw, I add myself to the array of people that will miss SCHED_ISO :)

also, how does the RLIMITS work? (ie, how does one set that on a
proccess, is it poosible to use schedtool to do that?)

Cheers
Fredrik

-- 
After all, if you are in school to study computer science, then a
professor saying: 
 "use this proprietary software to learn computer science" is the
same as English professor handing you a copy of Shakespeare
and saying:
 "use this book to learn Shakespeare without opening the book itself."
  -- Bradley Kuhn

