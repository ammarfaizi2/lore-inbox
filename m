Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262984AbTEGIy2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 04:54:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263011AbTEGIy2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 04:54:28 -0400
Received: from slider.rack66.net ([212.3.252.135]:46281 "EHLO
	slider.rack66.net") by vger.kernel.org with ESMTP id S262984AbTEGIy0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 04:54:26 -0400
Date: Wed, 7 May 2003 11:07:00 +0200
From: Filip Van Raemdonck <mechanix@debian.org>
To: Simon Kelley <srk@thekelleys.org.uk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Simon Kelley <simon@thekelleys.org.uk>,
       "J. Bruce Fields" <bfields@fieldses.org>, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
Subject: Re: Binary firmware in the kernel - licensing issues.
Message-ID: <20030507090700.GD25251@debian>
Mail-Followup-To: Simon Kelley <srk@thekelleys.org.uk>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Simon Kelley <simon@thekelleys.org.uk>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	linux-kernel@vger.kernel.org, torvalds@transmeta.com
References: <3EB79ECE.4010709@thekelleys.org.uk> <20030506121954.GO24892@mea-ext.zmailer.org> <20030506151644.GA19898@fieldses.org> <3EB7D7D9.2050603@thekelleys.org.uk> <1052234481.1202.20.camel@dhcp22.swansea.linux.org.uk> <3EB8AD41.5010605@thekelleys.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EB8AD41.5010605@thekelleys.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 07, 2003 at 07:52:49AM +0100, Simon Kelley wrote:
> Alan Cox wrote:
> >On Maw, 2003-05-06 at 16:42, Simon Kelley wrote:
> >
> >>Then, as you say, I need to know if the kernel developers have given
> >>permission to distribute a work which combines Atmel's blob with
> >>their source.[1]
> >
> >
> >Either the GPL does or it doesn't.
> <snip>
> >Na.. firmware stuff needs sorting out, but from the conversations I've
> >seem so far that involved people with a knowledge of law thats by
> >putting the firmware out of the kernel entirely
> >
> 
> Either the GPL allows this or it doesn't or maybe it is just not clear.
> If it is in fact silent or ambiguous on the issue then Linus is a much 
> more useful resource than Lawyers.

No he isn't.

Others are (re)distributing his kernels, whether heavily patched or not.
When he OKs it while lawyers say it's not, it's getting close to or
completely impossible for those others to include the drivers in the
kernel they redistribute without putting themselves at legal risk.
Effectively making it impossible for those people or organizations to
support running the kernels they distribute on the hardware which needs
that firmware.

While I agree that it is these others own responsibility to make sure
they are not doing anything illegal, Linus' approval contrary to legal
advise would create a situation where there is hardware which has drivers,
but noone can legally redistribute them. This is just as bad as having no
drivers at all.
(Actually, it's worse. Think about the amount of bitching that happens
about distributions not including Nvidia drivers, decss libraries or mp3
players. And you go try explain to aunt Tillie why RH can't include driver
XYZ for her fizzie-whizzie USB gadget while Linus does)

Sure, Linus will also be putting himself at risk in the above situation,
but that's his own call to make. Question yourself whether it's more
likely for Linus to get sued over it or, say, RedHat to get sued.
(Hmm, I wonder about the liability in the above case of kernel.org
mirrors)


Regards,

Filip

-- 
"Perhaps Debian is concerned more about technical excellence rather than
 ease of use by breaking software. In the former we may excel. In the
 latter we have to concede the field to Microsoft. Guess where I want
 to go today?"
	-- Manoj Srivastava
