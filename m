Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261681AbVAMQTq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261681AbVAMQTq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 11:19:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261670AbVAMQQU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 11:16:20 -0500
Received: from rproxy.gmail.com ([64.233.170.203]:12273 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261671AbVAMQOJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 11:14:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=n6bhq2C8alaYKaXCqSQGpckx++2MX5j8KOi13aU9uEkz0+2MtFQZ8SVugX+zfIdGoUwV+JRDOhrXTgbOWLBELj+0c8nDTdMv1tW8axrv+hmAFtY+5E1a8f8nHQE+UGUPfFjFgoanwc/wtK3RUsHU7fZMP7RPgAQ95SoalS9iLms=
Message-ID: <5b64f7f05011308141a04b2c1@mail.gmail.com>
Date: Thu, 13 Jan 2005 11:14:08 -0500
From: Rahul Karnik <deathdruid@gmail.com>
Reply-To: Rahul Karnik <deathdruid@gmail.com>
To: Jakub Jelinek <jakub@redhat.com>
Subject: Re: [ANNOUNCE] linux-libc-headers 2.6.10.0
Cc: Andrew Walrond <andrew@walrond.org>, Mariusz Mazur <mmazur@kernel.pl>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050113115154.GW10340@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200501081613.27460.mmazur@kernel.pl>
	 <200501130813.42545.andrew@walrond.org>
	 <200501131042.25470.mmazur@kernel.pl>
	 <200501131100.19500.andrew@walrond.org>
	 <5b64f7f050113034640e28eb9@mail.gmail.com>
	 <20050113115154.GW10340@devserv.devel.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jan 2005 06:51:54 -0500, Jakub Jelinek <jakub@redhat.com> wrote:
> On Thu, Jan 13, 2005 at 06:46:32AM -0500, Rahul Karnik wrote:
> > We are not talking about an application, but rather out of tree kernel
> > modules (or rather, different versions of modules already in the
> > tree).
> 
> For kernel modules you should never use /usr/include headers though.
> /lib/modules/`uname -r`/build/include headers should be used for them
> instead.

I was replying to the following:

> On Thursday 13 January 2005 09:42, Mariusz Mazur wrote:
> > I'm a distribution vendor. If x11 really required having current kernel
> > config at compile time to function properly, I'd start sending threats to
> > its authors.

"current kernel config" is the the same as /lib/modules/`uname
-r`/build/include, isn't it? I was saying that kernel modules
absolutely require the headers for the running kernel, just as you
are. Granted, the drm makefiles may be broken anyway and point to
/usr/include/linux.

Thanks,
Rahul
