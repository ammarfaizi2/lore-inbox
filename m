Return-Path: <linux-kernel-owner+w=401wt.eu-S932447AbXAGJNv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932447AbXAGJNv (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 04:13:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932448AbXAGJNv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 04:13:51 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:39789 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932447AbXAGJNu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 04:13:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DUBwJO6w6Jj8TATSQF5PpyxI8MF1DJYYsHicHj9FI5MXxohGgRRmGHY+RHo/Pm4i0JYoyhEZW0Z/r5si9Ffp/LpJcy4fpeuOUqPGUln5HKAIUVQ8HnAj83WlbI22IbVp2VPo5lS8PJ0Gfg6One80SGKsfI38DZjMvNonVt600Pc=
Message-ID: <8355959a0701070113k659a3e57wedf52b9f18e0ac6a@mail.gmail.com>
Date: Sun, 7 Jan 2007 14:43:48 +0530
From: Akula2 <akula2.shark@gmail.com>
To: "Auke Kok" <sofar@foo-projects.org>
Subject: Re: Multi kernel tree support on the same distro?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <459E77D9.8080209@foo-projects.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <8355959a0701041146v40da5d86q55aaa8e5f72ef3c6@mail.gmail.com>
	 <459D9872.8090603@foo-projects.org>
	 <tekrp2tqo78uh6g2pjmrhe0vpup8aalpmg@4ax.com>
	 <459DFE9F.9050904@foo-projects.org>
	 <8355959a0701050402g673f446em1c263dea826f3bcb@mail.gmail.com>
	 <459E77D9.8080209@foo-projects.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/5/07, Auke Kok <sofar@foo-projects.org> wrote:
> keeping 2 gcc's around usually is just a pain, but might also work.
>
> gcc-4.1.1 might give some problems with some packages and just work fine otherwise too,
> but 3.4.6 has just been known to work all around more.

I am planning in this fashion:-

gcc-3.4.x (latest in that tree) to build 2.4.34 kernel
gcc-4.1.x (latest in that tree) to build 2.6.20 kernel (once released)

And, all the required utils for these kernels.

There is no other option for me (this is fairly I can call as an
Experimental work, but this effort would add a lots for my work in the
Labs).

> well, my own of course ;)
 > http://lunar-linux.org/

This am not so sure (totally new for me), but I shall really try
Lunar...thanks :-)

This time am looking to work with the OpenSuSE10.2 to create my kind
of environment. But, am not sure if there are any big issues. Else, I
may stick to FC6.

Only bottleneck would be the wrapping the utils as you have mentioned earlier.

> but perhaps that's too much work for you, lunar definately is rather spartan for most
> people, and maybe not what you prefer. OTOH it does give you almost all the freedom that
> LFS gives you, and often very stable.

Very true, but I shall have a look at that, thanks again.

> that's all you'd need to get started. I suggest shopping distros a bit. Even debian
> might already work a lot better. but the major distros like RH, SuSE are just not
> focussed on multi-booting 2.4/2.6 side-by-side anymore.

I have good exposure with Debain, especially with my Embedded domain
(ARM Linux). But, somehow I felt like am more comfortable with Fedora
or SuSE to do many other things (hmm, here I lack much of the Embedded
support compared to Debian).

This is my actual initiative; have to crack this problem.

Lastly, one question I didn't understand:-

Someone said in the reply to this thread that we shouldn't have 2
kernels on the same distro? I didn't understand here clearly *Why
Not*?

> Cheers,
>
> Auke

~Akula2
