Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292399AbSBUOhK>; Thu, 21 Feb 2002 09:37:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292398AbSBUOhF>; Thu, 21 Feb 2002 09:37:05 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:37124 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S292399AbSBUOgr>;
	Thu, 21 Feb 2002 09:36:47 -0500
Message-ID: <3C7505FC.52D5B08E@mandrakesoft.com>
Date: Thu, 21 Feb 2002 09:36:44 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-2mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Lang <david.lang@digitalinsight.com>
CC: andersen@codepoet.org, Roman Zippel <zippel@linux-m68k.org>,
        linux-kernel@vger.kernel.org
Subject: Re: linux kernel config converter
In-Reply-To: <Pine.LNX.4.44.0202210626210.8696-100000@dlang.diginsite.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Lang wrote:
> 1. does this handle the cross directory dependancies?

I presume you are talking about Roman's tool, so I'll let him answer.  I
think he just implemented a converter to a new language, so new language
tools to parse the language don't exist yet, I think.

> 2. does it handle the 'I want this feature, turn on everything I need for
> it'?

This is fundamentally impossible for anything beyond the most simple
features. Although you can do a lot with config.in info, "everything I
need" is something a human needs to define in many cases.


> 3. if it handles #2 what does it do if you turn off that feature again
> (CML2 turns off anything it turned on to support that feature, assuming
> nothing else needs it)

This is a policy decision.  I'm not sure one -wants- to do this... 
Doing something like this blindly can have unintended side effects, i.e.
violate the Principle of Least Surprise.

	Jeff


-- 
Jeff Garzik      | "Why is it that attractive girls like you
Building 1024    |  always seem to have a boyfriend?"
MandrakeSoft     | "Because I'm a nympho that owns a brewery?"
                 |             - BBC TV show "Coupling"
