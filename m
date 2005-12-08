Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750934AbVLHLeW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750934AbVLHLeW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 06:34:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750937AbVLHLeW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 06:34:22 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:13529 "EHLO smtp1-g19.free.fr")
	by vger.kernel.org with ESMTP id S1750933AbVLHLeV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 06:34:21 -0500
Message-ID: <439819FF.5020704@droids-corp.org>
Date: Thu, 08 Dec 2005 12:33:19 +0100
From: Olivier MATZ <zer0@droids-corp.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051001)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] asm-i386 : config.h should not be included out of kernel
References: <4395F405.9010107@droids-corp.org> <200512062211.40142.arnd@arndb.de> <43971BD5.6040601@droids-corp.org> <20051207191030.GA7585@mars.ravnborg.org> <4397418E.3070400@droids-corp.org> <20051207213245.GA7575@mars.ravnborg.org>
In-Reply-To: <20051207213245.GA7575@mars.ravnborg.org>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>>>If you look at the commandline passed to gcc you will notice -include
>>>include/linux/autoconf.h which tell gcc to pull in autoconf.h.
>>>So it is no longer required to include config.h.
>>
>>I'm not sure. On my 2.6.14.3, this is a compilation line 
> 
> Ok, I was speaking on the 2.6.15-rc kernels. I was added when 2.6.15
> opened up and will first appear in a 'relased' kernel as of 2.6.15.

I have one more question about dependancies : in 2.6.15-rc, if we modify
the config, do we have to recompile everything ?

Olivier
