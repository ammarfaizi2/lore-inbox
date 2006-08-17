Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964898AbWHQNq6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964898AbWHQNq6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 09:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964988AbWHQNqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 09:46:31 -0400
Received: from wx-out-0506.google.com ([66.249.82.234]:9603 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S964911AbWHQNqV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 09:46:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YDqlYNcgkwp0qlCgze4y6x76XQ8Ta2rlDyqEZvkLfTnU+cwZ/CMTHNkMk/6XaEHjzb2o0q/Rl2n0PewMkwf7EoRupdNG/cIvPupegpLr/gJaOBXCI8t74D6Wm/LXS+HzCTg/O9nILkyQ5XRhAgpUqscM2rnSkso7HjpC96Lo65c=
Message-ID: <62b0912f0608170646jee93cabs46bdf9424a16b8d7@mail.gmail.com>
Date: Thu, 17 Aug 2006 15:46:19 +0200
From: "Molle Bestefich" <molle.bestefich@gmail.com>
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: Re: ext3 corruption
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <200608170127.k7H1RZBQ003805@laptop13.inf.utfsm.cl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <molle.bestefich@gmail.com>
	 <62b0912f0608120154s1b158732y5da52b17583fdfa0@mail.gmail.com>
	 <200608170127.k7H1RZBQ003805@laptop13.inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst H. von Brand wrote:
> > > The kernel people are certainly not infallible either. And there are cases
> > > where the right order is A B C, and others in which it is C B A, and still
> > > others where it doesn't matter.
>
> > In the quite unlikely situation where that happens, you've obviously
> > got a piece of software which is broken dependency-wise.  Many of the
> > current schemes will fail to accommodate that too.
>
> It isn't broken /software/, it is /different setups/.

It's broken software.

> > For example, no amount of moving the /etc/rc.d/rc6.d/K35smb script
> > around will fix that situation on Red Hat.
>
> What situation?

The situation you outlined, where A can depend on B, which can depend
on C, but in another usage scenario C can depend on B which can depend
on A.
