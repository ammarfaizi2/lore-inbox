Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750819AbWGCW6l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750819AbWGCW6l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 18:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751178AbWGCW6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 18:58:41 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:41920 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750819AbWGCW6k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 18:58:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=EsRw4jL7B1sZK0gqGG1ls1k1eWXX6mS7Q/lvHUCs/A/mT+Fj8vtVV0NMaM3uRjYOwsNabf7a/O7NdO/tNMZQ8ROgUcIxDN6t4Ihh5JRJGI7I4Qj6kP4frNYzHgE5rp1yjeetWOr+vTYSg/yE/JgTUzJiH/ovXujb4ZL9TbcI0FQ=
Message-ID: <44A9A133.2000509@gmail.com>
Date: Tue, 04 Jul 2006 00:58:36 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: swsusp regression
References: <44A99DFB.50106@gmail.com> <20060703224936.GT1674@elf.ucw.cz>
In-Reply-To: <20060703224936.GT1674@elf.ucw.cz>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek napsal(a):
> Hi!
> 
>> when suspending machine with hyperthreading, only Freezing cpus appears and then
>> it loops somewhere. 
> 
> Does it fail to freeze, or just lock up at that point?

It loops, cpu is 100 % working, fans can be heard as they try to cool cpu with
absolutely no feedback to keyboard except sysrq.

> 
> Does it work okay in UP mode?

What does UP mode stands for? UniProcessor, i.e. turn HT off?

thanks,
-- 
Jiri Slaby        www.fi.muni.cz/~xslaby/
\_.-^-._   jirislaby@gmail.com   _.-^-._/
B67499670407CE62ACC8 22A032CC55C339D47A7E
<a href="http://www.fi.muni.cz/~xslaby/">Jiri Slaby</a>
