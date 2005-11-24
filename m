Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030371AbVKXLAb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030371AbVKXLAb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 06:00:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbVKXLAa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 06:00:30 -0500
Received: from zproxy.gmail.com ([64.233.162.199]:1808 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751361AbVKXLAa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 06:00:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZZIinFDfOrjmNAVdRKZbg0YaNVeo7IzeCi2FNu/0pFBGcoXsLAc9gl/0qKgWA0moFzn6emI1F9jLHWJpZxf2idpFw3OoVpmGh64jcxQGI3rVhQ9MQ+cNt036+lZll0jeT7g9NtcSCB46kCwqMwmtDmOu6g79xJB+jIZLdc0xtas=
Message-ID: <9929d2390511240300t4d5e7d5dhb1a716b5505ee422@mail.gmail.com>
Date: Thu, 24 Nov 2005 03:00:28 -0800
From: Jeff Kirsher <tarbal@gmail.com>
To: Hiatt Gary-E3486C <E3486C@motorola.com>
Subject: Re: Scratch install of Red Hat Linux 7.3 on a Dell Poweredge 1850
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <EFB813091B18D511BD3600508B644F82168263C0@tx14exm06.ftw.mot.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <EFB813091B18D511BD3600508B644F82168263C0@tx14exm06.ftw.mot.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/05, Hiatt Gary-E3486C <E3486C@motorola.com> wrote:
> I agree with you but we are going to load Ubiquity software on this server
> and they approve only the Red Hat Linux 7.3 load. I will write them and see
> if we might use a newer load.
>
> Thank You
> Gary Hiatt
>
> Subject: Re: Scratch install of Red Hat Linux 7.3 on a Dell Poweredge 1850
>
> On Mer, 2005-11-23 at 09:12 -0600, Hiatt Gary-E3486C wrote:
> > I need some help with finding out what I might be over looking trying to
> > load Red Hat Linux 7.3
>
> Thats the first thing to change. Red Hat 7.3 is very very old. Linux,
> installers and the rest have come on a long way since then. Its a bit
> like "I'm having trouble installing Windows 95 on my new machine".
>
> Red Hat Linux itself has turned into Fedora Core (end user), and Red Hat
> Enterprise Linux (packaged with support).
>
> Alan
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

While I agree with Alan and Jeff's response about using a newer
kernel, I do have some suggestions.  I personally had similar
experience when installing on newer Dell servers and found the issue
to be the LSI drivers.  While installation found the hard drive and
completed installation, I found that I needed to load the latest LSI
drivers during the install to get the system to boot correctly.  I
checked the Dell site and they do provide drivers for Red Hat 7.3, so
I would try loading the appropriate drivers for your system.

--
Cheers,
Jeff
