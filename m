Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263801AbTJ1BXv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 20:23:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263805AbTJ1BXv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 20:23:51 -0500
Received: from gprs192-78.eurotel.cz ([160.218.192.78]:8065 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263801AbTJ1BXu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 20:23:50 -0500
Date: Tue, 28 Oct 2003 02:23:38 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Patrick Mochel <mochel@osdl.org>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [pm] fix device suspend/resume handling
Message-ID: <20031028012338.GB427@elf.ucw.cz>
References: <20031022233127.GA6410@elf.ucw.cz> <Pine.LNX.4.44.0310271401590.13116-100000@cherise>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310271401590.13116-100000@cherise>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!


> > [Oops, this one:
> > 
> > -               if(drivers_suspend()==0)
> > +               if ((res = device_suspend(4))==0)
> > 
> > probably will reject. Sorry about that, should be easy to fix up].
> 
> Please send an applicable patch.

Can you send me patch or patch * to diff against? I do not think I can
reproduce your tree just now...
								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
