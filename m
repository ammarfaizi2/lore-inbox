Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292409AbSBUOnk>; Thu, 21 Feb 2002 09:43:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292397AbSBUOnX>; Thu, 21 Feb 2002 09:43:23 -0500
Received: from [209.195.52.114] ([209.195.52.114]:39428 "HELO [209.195.52.30]")
	by vger.kernel.org with SMTP id <S292409AbSBUOnG>;
	Thu, 21 Feb 2002 09:43:06 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: andersen@codepoet.org, Roman Zippel <zippel@linux-m68k.org>,
        linux-kernel@vger.kernel.org
Date: Thu, 21 Feb 2002 06:40:38 -0800 (PST)
Subject: Re: linux kernel config converter
In-Reply-To: <3C7505FC.52D5B08E@mandrakesoft.com>
Message-ID: <Pine.LNX.4.44.0202210636020.8696-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Feb 2002, Jeff Garzik wrote:

> David Lang wrote:
> > 1. does this handle the cross directory dependancies?
>
> I presume you are talking about Roman's tool, so I'll let him answer.  I
> think he just implemented a converter to a new language, so new language
> tools to parse the language don't exist yet, I think.

I am so I'll wait for his answer

> > 2. does it handle the 'I want this feature, turn on everything I need for
> > it'?
>
> This is fundamentally impossible for anything beyond the most simple
> features. Although you can do a lot with config.in info, "everything I
> need" is something a human needs to define in many cases.
>

unless I am missing something this is one of the features that CML2
implements. Agreed that 'everything I need' needs to be defined by a
human, that's what Eric has done in his ruleset, define the dependancies.

>
> > 3. if it handles #2 what does it do if you turn off that feature again
> > (CML2 turns off anything it turned on to support that feature, assuming
> > nothing else needs it)
>
> This is a policy decision.  I'm not sure one -wants- to do this...
> Doing something like this blindly can have unintended side effects, i.e.
> violate the Principle of Least Surprise.

I'll argue that _not_ doing this violated the principle of lease surprise,
if you turn a feature on and immediatly back off why should anything in
your config be any different then it was before you turned it on?

David Lang

