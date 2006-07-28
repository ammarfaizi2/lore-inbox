Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752041AbWG1QeR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752041AbWG1QeR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 12:34:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752038AbWG1QeQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 12:34:16 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:18608 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1752034AbWG1QeP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 12:34:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IJChC6Q8JZgjqYhUUykJFL5TkwxQAbgmJIjnBuKpstt/816dzQcW2YfDQSi63guViiSNh9DC7azi0HK60PFfdoj1PPRx8lMFqsjwvMaRx2p4GJjxH6wSwAz9rA42vldCFrtp3mYvxPcSkUo93Nspnu5aVV8H2HMoN8E2p9jjvXc=
Message-ID: <6de39a910607280934t5c264b20w38c1f52c978b4e15@mail.gmail.com>
Date: Fri, 28 Jul 2006 09:34:11 -0700
From: "Handle X" <xhandle@gmail.com>
To: "=?ISO-8859-1?Q?Bj=F6rn_Steinbrink?=" <B.Steinbrink@gmx.de>,
       "Alexey Dobriyan" <adobriyan@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] #define rwxr_xr_x 0755
In-Reply-To: <20060727222314.GA9192@atjola.homenet>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <20060727205911.GB5356@martell.zuzino.mipt.ru>
	 <20060727222314.GA9192@atjola.homenet>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/06, Björn Steinbrink <B.Steinbrink@gmx.de> wrote:
> On 2006.07.28 00:59:11 +0400, Alexey Dobriyan wrote:
> > Every time I try to decipher S_I* combos I cry in pain. Often I just
> > refer to include/linux/stat.h defines to find out what mode it is
> > because numbers are actually quickier to understand.
> >
> > Compare and contrast:
> >
> >       0644 vs S_IRUGO|S_IWUSR vs rw_r__r__
> >
> > I'd say #2 really sucks.
>
> IMHO #3 sucks more, it's not as easy to spot when glossing over the
> code, the underscores make it quite ugly (think _r________) and it's
> less "greppable". If I know that there's something that sets S_ISUID, I
> can easily search for that, compare that to [_cpdbl]{1}[r_]{1}[w_]{1}s...
I agree with Steinbink. But how about having macros like,
S_I0700, S_I0070, S_I6444 ..etc. They combine visual appeal of octals,
easy to grep, easy to decipher ...etc.

Regards,
Om.
