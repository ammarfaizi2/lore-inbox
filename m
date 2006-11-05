Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161711AbWKEUf2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161711AbWKEUf2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 15:35:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161714AbWKEUf2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 15:35:28 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:742 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1161711AbWKEUf0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 15:35:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EvhQ8uzYSAqRJG5kiJ73Zxa/vWc/plXFB9xWKAt6tQTs3n5bqFRT4F8IKNDc2eJdfszQv1e0IZlcMuzUT2skqV6Fhn99qpxTtuXSiqkHCA/7lm9MF28wyPs/kfBkU4c2MFt47tc+ZVe381/IWu1cPn8PdTQxJNWWYwX4eiruVe8=
Message-ID: <653402b90611051235s1ecec9a2ub5776a63489920ca@mail.gmail.com>
Date: Sun, 5 Nov 2006 21:35:24 +0100
From: "Miguel Ojeda" <maxextreme@gmail.com>
To: "xp newbie" <xp_newbie@yahoo.com>
Subject: Re: How do I know whether a specific driver being used?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061105170318.68879.qmail@web38405.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <653402b90611050147x5af94b50s46a5f107f29031b@mail.gmail.com>
	 <20061105170318.68879.qmail@web38405.mail.mud.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/5/06, xp newbie <xp_newbie@yahoo.com> wrote:
> --- Miguel Ojeda <maxextreme@gmail.com> wrote:
> >
> > This mailing list is about kernel development, this
> > is not the right
> > place to ask that. Anyway, 3rd party kernels,
> > patches, drivers... are
> > not covered here.
> >
>
> I appologize for sending to the wrong mailing list.
> Could you please refer me to the correct
> newsgroup/forum/mailinglist?
>
> Please note that I have already tried
> http://www.ubuntuforums.org/ but the folks seem to be
> confused like me (regarding this particular issue).
>
> More specifically, there is confusion between the
> following statement:
>
> http://packages.debian.org/stable/devel/kernel-patch-2.4-fasttraks150
>

Usually, when you have a problem with some program, you ask the
developer about the bug you have found (or whatever). So you should
ask Ubuntu folks, because the kernels you are using are a "fork" of
the mailine kernel. They add a lot of 3rd party stuff along other
things, so they are the ones who need to solve their problems. I'm
sure there is someone at Ubuntu that can help you for future problems.

> And the fact that my system shows the following:
>
> ~> lsmod | grep promise
> sata_promise           12516  8
> libata                 83440  1 sata_promise
> scsi_mod              145960  6
> sr_mod,sbp2,sg,sd_mod,sata_promise,libata
>
> Do you know what the best place to ask such question?
>
> Thanks!
> Alex
>
> P.S. I didn't browse menuconfig, because I am not
> there yet. It's like the chicken-and-the-egg
> situation: I am using Ubuntu which conceptually
> exempts me from the need to compile kernel modules and
> thus menuconfig is not even installed by default.
> Since (thanks to Arjan's reply) I am pretty sure now
> that the driver is included in the distribution, I
> hope that no compilation is needed.
>

Well, you can browse menuconfig without compile the kernel at all...
Just for check if some driver is already in. Anyway, Ubuntu kernels
aren't the mailine ones and they have more drivers.

> P.S.2 If I discover something that IMHO points to a
> bug in the kernel, where do I post it?
>

If you discover a bug in the Ubuntu kernel, you should report it to
Ubuntu developers. Their kernels are "old" and very patched so they
are pretty different. Only report here if the bug appears in the
lastest mainline kernels (like 2.6.18 or 2.6.18.1 right now...).

Anyway, you can always use the lastest official kernel from
www.kernel.org ;-) so if you find a bug you can be sure to report it
here.
