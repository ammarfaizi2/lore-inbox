Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751204AbWBZRIH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbWBZRIH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 12:08:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751216AbWBZRIH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 12:08:07 -0500
Received: from rtr.ca ([64.26.128.89]:32714 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751204AbWBZRIG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 12:08:06 -0500
Message-ID: <4401E06D.90305@rtr.ca>
Date: Sun, 26 Feb 2006 12:07:57 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.1) Gecko/20060130 SeaMonkey/1.0
MIME-Version: 1.0
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Nick Warne <nick@linicks.net>, linux-kernel@vger.kernel.org
Subject: Re: hda: irq timeout: status=0xd0 DMA question
References: <200602261308.47513.nick@linicks.net> <4401B689.5050106@rtr.ca> <9a8748490602260615i8b72ae4ta3c6b13b568ca45d@mail.gmail.com>
In-Reply-To: <9a8748490602260615i8b72ae4ta3c6b13b568ca45d@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:
 >
> Or how about an option for the IDE driver to "not do that" that people
> could enable if needed/wanted?
> Or just change the code to "not do that" since we are no longer in the
> mid-1990s?

Well, yes.  That's what I would do, were I still maintaining the IDE layer.

But that code has become so twisted and confused since then,
that a change like this is probably too risky/challenging for
the current maintainers.  It seems really easy to break stuff
when touching parts of that code now, and people don't like it
much when their hard drives get corrupted.

But perhaps someone may successfully implement this.

Cheers
