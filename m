Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263769AbUJEURp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263769AbUJEURp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 16:17:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263962AbUJEURp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 16:17:45 -0400
Received: from h66-38-154-67.gtcust.grouptelecom.net ([66.38.154.67]:18875
	"EHLO pbl.ca") by vger.kernel.org with ESMTP id S263769AbUJEURh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 16:17:37 -0400
Message-ID: <41630266.7070402@pbl.ca>
Date: Tue, 05 Oct 2004 15:21:58 -0500
From: Aleksandar Milivojevic <amilivojevic@pbl.ca>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Linux-2.6.5-1.358 and Fedora
References: <1097004565.9975.25.camel@laptop.fenrus.com> <Pine.LNX.4.61.0410052140150.2913@dragon.hygekrogen.localhost> <20041005194208.GE11254@devserv.devel.redhat.com>
In-Reply-To: <20041005194208.GE11254@devserv.devel.redhat.com>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Tue, Oct 05, 2004 at 09:46:18PM +0200, Jesper Juhl wrote:
> 
>>On Tue, 5 Oct 2004, Arjan van de Ven wrote:
>>
>>
>>>If Richard overwrote his modules anyway he must have hacked the Makefile
>>>himself to deliberately cause this, at which point... well saw wind
>>>harvest storm ;)
>>>
>>
>>While I lack specific Fedora knowledge and thus can't provide exact 
>>details for it I'd say it should still be pretty simple to recover. On 
>>Slackware I'd simply boot a kernel from the install CD and tell it to 
>>mount the installed system on my HD, then you'll have a running system and 
>>can easily clean out the broken modules etc and install the original ones 
>>from your CD and be right back where you started in 5 min. Surely 
>>something similar is possible with Fedora, reinstalling from scratch (as 
>>he said he did) seems like massive overkill to me.
> 
> 
> yeah there is rescue mode for that reason on the first cd

Actually, FC2 has an CD called rescue CD.  All he needed to do (if he 
toasted his working kernel) was to boot from it, and reinstall the 
kernel package from the first CD (rpm -Uhv --force 
kernel-2.6.5-1.358.i686.rpm or i586, force is needed to push things a 
bit since system thinks the same version of package is already installed).

I'd be quite interested to find out how he managed to toast his working 
kernel.  Not an easy task.  Actaully it is, but requires some manual 
work, it can't be done by just typing make this, make that.  There were 
some steps he "forgot" to mention ;-).

-- 
Aleksandar Milivojevic <amilivojevic@pbl.ca>    Pollard Banknote Limited
Systems Administrator                           1499 Buffalo Place
Tel: (204) 474-2323 ext 276                     Winnipeg, MB  R3T 1L7
