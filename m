Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750761AbWEPUr6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbWEPUr6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 16:47:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750751AbWEPUr5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 16:47:57 -0400
Received: from relay03.pair.com ([209.68.5.17]:775 "HELO relay03.pair.com")
	by vger.kernel.org with SMTP id S1750728AbWEPUr5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 16:47:57 -0400
X-pair-Authenticated: 71.197.50.189
Date: Tue, 16 May 2006 15:47:56 -0500 (CDT)
From: Chase Venters <chase.venters@clientec.com>
X-X-Sender: root@turbotaz.ourhouse
To: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Wiretapping Linux?
In-Reply-To: <yw1xodxx1znc.fsf@agrajag.inprovide.com>
Message-ID: <Pine.LNX.4.64.0605161541390.32181@turbotaz.ourhouse>
References: <4469D296.8060908@perkel.com> <Pine.LNX.4.61.0605161100590.27707@chaos.analogic.com>
 <Pine.LNX.4.64.0605161052120.32181@turbotaz.ourhouse> <yw1xodxx1znc.fsf@agrajag.inprovide.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1050654786-1147812498=:32181"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1050654786-1147812498=:32181
Content-Type: TEXT/PLAIN; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 16 May 2006, Måns Rullgård wrote:

> Chase Venters <chase.venters@clientec.com> writes:
>
>> The thing is that there is enough peer review in the open source world
>> that not only would it be *difficult* to slip in some intentionally
>> malicious code (and I don't think any malicious code of much potential
>> would be likely to make it past LKML, especially if it doesn't closely
>> adhere to CodingStyle :P) but it would not be long before someone
>> noticed it.
>
> Some details on a real attempt: http://kerneltrap.org/node/1584
>

Wow. Did anyone ever find out who edited CVS, and how they did it? (I 
assume David Miller didn't have anything to do with it :P)

Yeah, so to wrap this malware conversation up -- the most effective way to 
implant malicious code in Linux is to crack into developer machines and 
sneak the changes in.

And hope that someone doesn't notice.

The original poster speaks of spyware - I think spyware would end up being 
a few lines more than a fake current->uid test(set). So it's not proper to 
say malicious code couldn't be inserted into Linux; rather, it's just not 
very likely to get anything very complicated in there. The bigger the 
elephant, the harder it is to dress it up as an elf.

Thanks,
Chase
--8323328-1050654786-1147812498=:32181--
