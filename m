Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751470AbVKYTx6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751470AbVKYTx6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 14:53:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751472AbVKYTx6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 14:53:58 -0500
Received: from zproxy.gmail.com ([64.233.162.195]:8064 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751470AbVKYTx6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 14:53:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=UE2xlk45OBk6rU4kZfVsZLOGdIQs+1M+iN8OXZHDzoRWni1InXSOMkfmHgRR7JLZ0ejuhf4dS4h+3vMoVLivEuwgTbrnm2xk0ZL0Ji+z8XKUewBJEXIs/EFk0WJedqR1eEhs/Kj8hq+IXNE20Emmh3GqQs4bptlIxoUwtt5RGNc=
Message-ID: <43876BCF.4030508@gmail.com>
Date: Fri, 25 Nov 2005 20:53:51 +0100
From: Xose Vazquez Perez <xose.vazquez@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: "Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH] was Re: [RFC] Documentation dir is a mess
References: <438069BD.6000401@gmail.com> <20051121003033.GA11302@kroah.com>
In-Reply-To: <20051121003033.GA11302@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

> On Sun, Nov 20, 2005 at 01:19:09PM +0100, Xose Vazquez Perez wrote:

>>_today_ Documentation/* is a mess of files. It would be good
>>to have the _same_ tree as the code has:

> Do you have a proposal as to what specific files in that directory
> should go where?  Just basing it on the source tree will not get you
> very far...

well, more or less the same but not _exactly_ the same ;-)

I already have a big patch against 2.6.15-rc2-git5:

[ http://perso.wanadoo.es/xose_vp/documentation_cleanup_01.diff.bz2 ]

main features:
- move all drivers_info into 'drivers'
- move all arch_info into 'arch'
- move all drivers_info from 'net' to 'drivers/net'

TODO:
- clean up the 'Documentation' root dir a bit more (easy)
- remove (easy) or update all INDEX files (tedious)
- move all info/text files from source code to 'Documentation' dir (tedious)
- verify all files are in the correct place (tedious)

enough for now.


-thanks-

-- 
Romanes eunt domus
