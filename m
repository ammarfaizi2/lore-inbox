Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932116AbWGCXfI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932116AbWGCXfI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 19:35:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932122AbWGCXfI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 19:35:08 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:17690 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932116AbWGCXfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 19:35:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=rmMu3KNV1uBKY5Gn1f7K+/Z4rZXnl08T7D/pCAzu6vVSxGOnkkP0xXdinHxKlEyvbZqzZNGY9UaE+VP31CIppy8/uaLwFabO60uWPtuyZFpRw3bcYSr1gjUJy3rcsdCXYpS0F3hfJBspEv1Si3jx3jr01/k/D7f9lqSG5lGd/XI=
Message-ID: <44A9A9BB.5090901@gmail.com>
Date: Tue, 04 Jul 2006 01:35:00 +0159
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
> 
> Does it work okay in UP mode?

Seems to be fine. Going to try restore stopmachine from 2.6.17...

regards,
-- 
Jiri Slaby        www.fi.muni.cz/~xslaby/
\_.-^-._   jirislaby@gmail.com   _.-^-._/
B67499670407CE62ACC8 22A032CC55C339D47A7E
<a href="http://www.fi.muni.cz/~xslaby/">Jiri Slaby</a>
