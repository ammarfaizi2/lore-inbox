Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161322AbWALXmJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161322AbWALXmJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 18:42:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161472AbWALXmJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 18:42:09 -0500
Received: from quark.didntduck.org ([69.55.226.66]:21407 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id S1161322AbWALXmI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 18:42:08 -0500
Message-ID: <43C6E9CC.60509@didntduck.org>
Date: Thu, 12 Jan 2006 18:44:12 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mail/News 1.5 (X11/20060103)
MIME-Version: 1.0
To: Nigel Cunningham <ncunningham@cyclades.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Does a git pull have to be so big?
References: <200601130845.29797.ncunningham@cyclades.com> <43C6DCD7.30709@didntduck.org> <200601130912.27374.ncunningham@cyclades.com>
In-Reply-To: <200601130912.27374.ncunningham@cyclades.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Cunningham wrote:
> Hi.
> 
> On Friday 13 January 2006 08:48, Brian Gerst wrote:
>> Nigel Cunningham wrote:
>>> Hi.
>>>
>>> I try to do pulls reasonably often, but they always seem to be huge
>>> downloads - I'm sure they're orders of magnitude bigger than a simple
>>> patch would be. This leads me to ask, do they have to be so big? I'm on
>>> 256/64 ADSL at home, did a pull yesterday at work iirc, and yet the pull
>>> this morning has taken at least half an hour. Am I perhaps doing
>>> something wrong?
>>>
>>> I'm using cogito .16-2 (ubuntu) and git 1.0.6.
>>>
>>> Regards,
>>>
>>> Nigel
>>>
>>> #cg-fetch
>>> Fetching head...
>>> Fetching objects...
>>> progress: 114 objects, 256992 bytes
>>> Getting alternates list for
>>> http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/
>>> progress: 376 objects, 1413225 bytes
>>> Getting pack list for
>>> http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/
>>> progress: 453 objects, 1924312 bytes
>>> Getting index for pack 221c50e73e5ab65afededc14f1df0541b59ebdd5
>>> Getting pack 221c50e73e5ab65afededc14f1df0541b59ebdd5
>>>  which contains 62727f8969438d99c3c34415d16611cf86f16140
>>>
>>> (Still going)
>>> -
>>> To unsubscribe from this list: send the line "unsubscribe linux-kernel"
>>> in the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>> Please read the FAQ at  http://www.tux.org/lkml/
>> Use git://git.kernel.org/... instead of http.
>>
>> --
>> 				Brian Gerst
> 
> Ok. I'll give it a try - is it related to the packed files thing Jeff spoke 
> of?
> 
> Regards,
> 
> Nigel
> 

Yes.  If the objects are packed then the only way to get the objects by
http are to download the whole pack.

--
				Brian Gerst
