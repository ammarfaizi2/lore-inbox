Return-Path: <linux-kernel-owner+w=401wt.eu-S1751240AbWLLLxZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240AbWLLLxZ (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 06:53:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbWLLLxZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 06:53:25 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:9077 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751240AbWLLLxY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 06:53:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=N8fwXaHEBwjTdXW82mFIHNPkXNT3waro2zGmZ8nYzOgmorXzhGrqrnRmiThC8tcsfzlA6x5qlYj6mua+28ibs/aHAsfPmSdql1SfD0dw9iTt6AOQwt6o6OBnscQbfjcfSRV72c9GzT7h5lp7g3qL12mmSllwVnlSNynVoc7EocI=
Message-ID: <625fc13d0612120353w1b10d953s4b10bbb82561307b@mail.gmail.com>
Date: Tue, 12 Dec 2006 05:53:23 -0600
From: "Josh Boyer" <jwboyer@gmail.com>
To: "Adrian Bunk" <bunk@stusta.de>
Subject: Re: 2.6.19-mm1: drivers/mtd/ubi/debug.c: unused variable
Cc: "Andrew Morton" <akpm@osdl.org>,
       "Artem Bityutskiy" <dedekind@infradead.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20061211204616.GJ28443@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061211005807.f220b81c.akpm@osdl.org>
	 <20061211204616.GJ28443@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/06, Adrian Bunk <bunk@stusta.de> wrote:
> On Mon, Dec 11, 2006 at 12:58:07AM -0800, Andrew Morton wrote:
> >...
> > Changes since 2.6.19-rc6-mm2:
> >...
> >  git-ubi.patch
> >...
> >  git trees.
> >...
>
> It doesn't seem to be intended that in ubi_dbg_vprint_nolock() the
> variable "caller" is never assigned any value different from 0.

Hm..  we'll take a look.  Thanks for pointing that out.

FYI, if you CC the linux-mtd list for things related to UBI, a few
more people that can fix things will get the emails.

josh
