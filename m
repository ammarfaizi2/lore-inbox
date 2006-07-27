Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161067AbWG0Nm0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161067AbWG0Nm0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 09:42:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161075AbWG0Nm0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 09:42:26 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:55879 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1161067AbWG0NmZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 09:42:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=n6LtCqbbzJ1C3fwZSLQPu6eECoo1iWwnMUtItqLGc/qZ1rbC774/kpMj5690snFgrnITti7Yh2X0PHxoOUx6y3tXXfeX1wmulTPuhgb6zz+CAxYtKGQmUyvrel/sAvm3uFw1ojSdyQ6jSHNf1HelwHnjH2oFexPYPO5HQOKlGy0=
Message-ID: <f96157c40607270642p44c89597pcbb7d5685b47dae8@mail.gmail.com>
Date: Thu, 27 Jul 2006 13:42:23 +0000
From: "gmu 2k6" <gmu2006@gmail.com>
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: Re: the ' 'official' point of view' expressed by kernelnewbies.org regarding reiser4 inclusion
Cc: "Luigi Genoni" <genoni@sns.it>, "Adrian Bunk" <bunk@stusta.de>,
       andrea@cpushare.com, "J. Bruce Fields" <bfields@fieldses.org>,
       "Hans Reiser" <reiser@namesys.com>,
       "Nikita Danilov" <nikita@clusterfs.com>,
       "Rene Rebe" <rene@exactcode.de>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <200607271330.k6RDUaPC008087@laptop13.inf.utfsm.cl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <genoni@sns.it>
	 <2870.192.167.206.189.1153998447.squirrel@darkstar.linuxpratico.net>
	 <200607271330.k6RDUaPC008087@laptop13.inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/06, Horst H. von Brand <vonbrand@inf.utfsm.cl> wrote:
> Luigi Genoni <genoni@sns.it> wrote:
>
> [...]
>
> > Anyway you have a datum.
> > Some people need reiser4, period.
>
> Nope. Some people run kernels that include reiser4. That is all you can
> infer, and that I knew beforehand. They are at least 35, and that I'd have
> guessed in any case.

35.5 as I'm testing it here on my workstation and it seems to be
faster when you test some things involving many copies of large
multi-level sourcetree directories each 3 to 6GiB big in size.
2.6.18-rc2-mm1 with Reiser4 looks ok so far and I had no sync() OOPS
like the last time with one -mm revision.

speed tells us nothing about reliability of course, but compared to
ext3 with dir_index,sparse_super Reiser4 seems to handle "du -sh" and
"rm -r" much faster and without eating all of the CPU cycles as it
finishes quicker although Reiser4 was meant to be CPU-heavy compared
to ext*/reiserfs3.
