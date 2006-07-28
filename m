Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752048AbWG1Qsq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752048AbWG1Qsq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 12:48:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752050AbWG1Qsq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 12:48:46 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:54403 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S1752048AbWG1Qsq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 12:48:46 -0400
Date: Fri, 28 Jul 2006 12:48:40 -0400
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: Handle X <xhandle@gmail.com>
Cc: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
       Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] #define rwxr_xr_x 0755
Message-ID: <20060728164839.GA20974@filer.fsl.cs.sunysb.edu>
References: <20060727205911.GB5356@martell.zuzino.mipt.ru> <20060727222314.GA9192@atjola.homenet> <6de39a910607280934t5c264b20w38c1f52c978b4e15@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6de39a910607280934t5c264b20w38c1f52c978b4e15@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2006 at 09:34:11AM -0700, Handle X wrote:
> On 7/27/06, Björn Steinbrink <B.Steinbrink@gmx.de> wrote:
> >On 2006.07.28 00:59:11 +0400, Alexey Dobriyan wrote:
> >> Every time I try to decipher S_I* combos I cry in pain. Often I just
> >> refer to include/linux/stat.h defines to find out what mode it is
> >> because numbers are actually quickier to understand.
> >>
> >> Compare and contrast:
> >>
> >>       0644 vs S_IRUGO|S_IWUSR vs rw_r__r__
> >>
> >> I'd say #2 really sucks.
> >
> >IMHO #3 sucks more, it's not as easy to spot when glossing over the
> >code, the underscores make it quite ugly (think _r________) and it's
> >less "greppable". If I know that there's something that sets S_ISUID, I
> >can easily search for that, compare that to [_cpdbl]{1}[r_]{1}[w_]{1}s...
> I agree with Steinbink. But how about having macros like,
> S_I0700, S_I0070, S_I6444 ..etc. They combine visual appeal of octals,
> easy to grep, easy to decipher ...etc.

Even better!

Josef "Jeff" Sipek.

-- 
In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like
that.
		- Linus Torvalds
