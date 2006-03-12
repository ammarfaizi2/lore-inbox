Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750881AbWCLPpT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750881AbWCLPpT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 10:45:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751050AbWCLPpT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 10:45:19 -0500
Received: from rtr.ca ([64.26.128.89]:23021 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1750881AbWCLPpS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 10:45:18 -0500
Message-ID: <441441F0.3010008@rtr.ca>
Date: Sun, 12 Mar 2006 10:44:48 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8) Gecko/20060305 SeaMonkey/1.1a
MIME-Version: 1.0
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Input: psmouse - disable autoresync
References: <200603110023.38863.dtor_core@ameritech.net> <44131BC9.5020800@rtr.ca> <200603112001.55358.dtor_core@ameritech.net>
In-Reply-To: <200603112001.55358.dtor_core@ameritech.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:
> Automatic resync code was added at the beginning of 2.6.16 and although it
> generally works quite well and usually resolves problems caused by KVMs
> resetting mice ther were several reports of it breaking existing setups.
> Unfortunately I did not have anough time to resolve the issues in time
> for 2.6.16 final and so I think it is the best to disable new code by
> default for now. I do not want to revert the changes completely as they
> are still useful.

Ah, okay.  Thank!  I need this patch on my server here!

Cheers
