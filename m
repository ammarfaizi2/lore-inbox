Return-Path: <linux-kernel-owner+w=401wt.eu-S1751315AbWLLNGn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315AbWLLNGn (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 08:06:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751311AbWLLNGm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 08:06:42 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:34262 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751315AbWLLNGl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 08:06:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=U40twDtw2HSlItL2C8KukGOkqkqgjHj0Hz7CWhYGyoR/qy7s2O6eEHRrVHg0wvMyUF62KwTzMOfUBeSfuhFO2Gny+nNrpjXk3DJjl3unLSubBfp1PXFG4FEwczBQ6VE1s7ZZCZq7sONaDYxmE+WmzXqJ4jsjOei/JIDf+VBrFq4=
Message-ID: <625fc13d0612120506g3e4d1e54w8549989faf63031a@mail.gmail.com>
Date: Tue, 12 Dec 2006 07:06:39 -0600
From: "Josh Boyer" <jwboyer@gmail.com>
To: "Jeff Garzik" <jeff@garzik.org>
Subject: Re: [PATCH/RFC] Delete JFFS (version 1)
Cc: "Linux Kernel" <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org, "Andrew Morton" <akpm@osdl.org>,
       jffs-dev@axis.com, "David Woodhouse" <dwmw2@infradead.org>
In-Reply-To: <457EA86B.5010407@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <457EA2FE.3050206@garzik.org>
	 <625fc13d0612120456p1d74663fp21e40ee84a8819bc@mail.gmail.com>
	 <457EA86B.5010407@garzik.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/06, Jeff Garzik <jeff@garzik.org> wrote:
> Josh Boyer wrote:
> > On 12/12/06, Jeff Garzik <jeff@garzik.org> wrote:
> >> I have created the 'kill-jffs' branch of
> >> git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/misc-2.6.git that
> >> removes fs/jffs.
> >>
> >> I argue that you can count the users (who aren't on 2.4) on one hand,
> >> and developers don't seem to have cared for it in ages.
> >>
> >> People are already talking about jffs2 replacements, so I propose we zap
> >> jffs in 2.6.21.
> >
> > I'm usually all for killing broken code, but JFFS isn't really broken
> > is it?  Is there some burden it's causing by being in the kernel at
> > the moment?
>
> It's always been the case that we remove Linux kernel code when the
> number of users (and more importantly, developers) drops to near-nil.
>
> Every line of code is one more place you have to audit when code
> changes, one more place to update each time the VFS API is touched.

Ok, I can buy that.

>
> When it's more likely to get struck by lightning than encounter
> filesystem X on a random hard drive in the field, filesystem X need not
> be in the kernel.

Or flash chip in this case ;)

josh
