Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965022AbVHYXZR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965022AbVHYXZR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 19:25:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965024AbVHYXZR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 19:25:17 -0400
Received: from wproxy.gmail.com ([64.233.184.195]:17024 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965022AbVHYXZQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 19:25:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=mU4LgBd+5c0Pns6yoCvbMCxShXcSQ60xAsa0g2jk2pmE11Y6G+wuT7A26o7bglSeuneCrK5P+Y5PhsMugsGlju1WoYdKX7tbqdwFbR4GtqJbA/Ai6oVSwvPYH+3K6SQUYp+l3fz1riEnwM90xtYPxVMcuKIhwid1vCuJnns3QSM=
Message-ID: <430E5355.5080601@gmail.com>
Date: Fri, 26 Aug 2005 07:25:09 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sylvain Meyer <sylvain.meyer@worldonline.fr>
CC: Sebastian Kaergel <mailing@wodkahexe.de>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: Linux-2.6.13-rc7
References: <Pine.LNX.4.58.0508232203520.3317@g5.osdl.org>	<20050825194954.6db42e90.mailing@wodkahexe.de>	<430DF08C.8010604@gmail.com> <20050825210148.4f60e531.mailing@wodkahexe.de> <430E1246.5020107@worldonline.fr>
In-Reply-To: <430E1246.5020107@worldonline.fr>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry. Here's the start of the thread.

Tony

On Tue, 23 Aug 2005 22:08:13 -0700 (PDT)
Linus Torvalds <torvalds@osdl.org> wrote:

> > Antonino A. Daplas:
> >   intelfb/fbdev: Save info->flags in a local variable
> > Sylvain Meyer:
> >   intelfb: Do not ioremap entire graphics aperture

One of these changes broke intelfb. The same .config from 2.6.13-rc6
does no longer work for -rc7. After booting the screen stays black, but
i can type blindly. I can also start X. dmesg does not show anything
unusual. any ideas?
