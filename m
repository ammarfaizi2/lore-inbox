Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932397AbVKUUeM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932397AbVKUUeM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 15:34:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932459AbVKUUeL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 15:34:11 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:54725 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932397AbVKUUeK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 15:34:10 -0500
Message-ID: <43822E56.7090909@ocroquette.free.fr>
Date: Mon, 21 Nov 2005 21:30:14 +0100
From: Olivier Croquette <ocroquette@perso107-g5.free.fr>
Reply-To: ocroquette@free.fr
User-Agent: Mozilla Thunderbird 1.0.7 (Macintosh/20050923)
X-Accept-Language: fr-fr, en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>, raven@themaw.net
Subject: Re: Automount ghost option
References: <5ainN-x5-11@gated-at.bofh.it> <5arK7-5L9-5@gated-at.bofh.it>
In-Reply-To: <5arK7-5L9-5@gated-at.bofh.it>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:e39ae1980843c849592344a98bbbf26f
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Kent wrote:
>>Nevertheless, on some recent distributions I have tested on, this option is
>>not available.
> 
> For example?

I tried on SuSE 9.2 and 9.3 and it didn't work.

After a short investigation based on your info, this is what came out:

On SuSE 9.2, it's because it is still using a 3.x autofs.
On SuSE 9.3, it's because it doesn't work with the --ghost option in the 
auto.x NIS map file. It works only if I put the option in the 
/etc/sysconfig/autofs global settings.

Thanks for your help!
