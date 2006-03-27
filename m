Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751242AbWC0BYf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751242AbWC0BYf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 20:24:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbWC0BYf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 20:24:35 -0500
Received: from smtp.enter.net ([216.193.128.24]:1799 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S1751242AbWC0BYf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 20:24:35 -0500
From: "D. Hazelton" <dhazelton@enter.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-fbdev-devel@lists.sourceforge.net,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: funny framebuffer fonts on PowerBook with radeonfb
Date: Sun, 26 Mar 2006 20:24:44 -0500
User-Agent: KMail/1.8.1
References: <20060327004741.GA19187@MAIL.13thfloor.at>
In-Reply-To: <20060327004741.GA19187@MAIL.13thfloor.at>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603262024.44737.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 26 March 2006 19:47, Herbert Poetzl wrote:
> Hey Ben!
>
> 2.6.16 and 2.6.15-something show a funny behaviour
> when using the radeonfb driver (for text mode), they
> kind of twist and break the fonts in various places
> some characters or parts seem to be mirrored like
> '[' becoming ']' but not on character boundary but
> more on N pixels, colors seem to be correct for the
> characters, and sometimes the font is perfectly fine
> for larger runs, e.g. I can read the logon prompt
> fine, but everything I type is garbled ...
>
> just for an example, when I type 'echo "Test"' then
> all characters are mirrored and cut off on the right
> side but the locations are as shown above, on enter
> the T is only a few pixels wide, but the est part is
> written perfectly fine ... this is a new behaviour
> and going back to 2.6.13.3 doesn't show this ...
>
> if there is some testing I can do for you, or when
> you need more info, please let me know. here a few
> details for the machine:

I saw this on an PC with a Radeon 7000/VE that was slowly going bad. I'd 
recommend you run a full diagnostic on the video system memory (if possible) 
and look for errors there. If it isn't the memory (which was the problem on 
my Radeon) then the GPU itself might be going bad.

ShadowWolf
