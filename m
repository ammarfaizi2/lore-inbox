Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262248AbTH3XBU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 19:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262258AbTH3XBU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 19:01:20 -0400
Received: from mail.skjellin.no ([80.239.42.67]:39899 "HELO mail.skjellin.no")
	by vger.kernel.org with SMTP id S262248AbTH3XBS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 19:01:18 -0400
Message-ID: <3F512CBD.7050802@tomt.net>
Date: Sun, 31 Aug 2003 01:01:17 +0200
From: Andre Tomt <andre@tomt.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5b) Gecko/20030820 Mozilla Thunderbird/0.2a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "J.A. Magallon" <jamagallon@able.es>
CC: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] check_gcc for i386
References: <Pine.LNX.4.55L.0308301220020.31588@freak.distro.conectiva> <20030830220517.GA20429@werewolf.able.es>
In-Reply-To: <20030830220517.GA20429@werewolf.able.es>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J.A. Magallon wrote:

> On 08.30, Marcelo Tosatti wrote:
> 
>>Hello,
>>
>>Here goes -pre2. It contains an USB update, PPC merge, m68k merge, IDE
>>changes from Alan, network drivers update from Jeff, amongst other fixes
>>and updates.
>>
> 
> 
> New try...
> Plz, could you include this on your queue ?

This can be a potentially harmful change, suddenly exposing compiler 
bugs and other compiler related problems in the kernel code we have not 
yet seen. On one side, these bugs _should_ get fixed, on the other side, 
we might not find them all before release. Also, the pentium3 and 
pentium4 options have been known to compile for example bad SSE code in 
some gcc versions, something that's giving me a feeling those gcc 
options may be a little immature to use for a stable kernel series.

In my opinion, of course.

-- 
Cheers,
André Tomt
andre@tomt.net

