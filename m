Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750876AbWHZUzo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750876AbWHZUzo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Aug 2006 16:55:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750885AbWHZUzn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Aug 2006 16:55:43 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:3475 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750872AbWHZUzn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Aug 2006 16:55:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ss3u9CvFFoPygFGl7CK4F3OKejalOe/bZoeJpFLzNoRSdUYXyk1X/tzPxPJ17YY2d9m/2tQVb+WOv1JW7Zs22L7xFHGFdd/ogRTB2/3nAp6+kQ1yTsRVCAwbKtPihHL/gfkPn8PhdqbWI+tNZ19S2hOFEHonfrZXfzNfF4kLgfM=
Message-ID: <e9c3a7c20608261355k41692c64w9165a22a9b7fab29@mail.gmail.com>
Date: Sat, 26 Aug 2006 13:55:36 -0700
From: "Dan Williams" <dan.j.williams@gmail.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Linux: Why software RAID?
Cc: "Chris Friesen" <cfriesen@nortel.com>, "Jeff Garzik" <jeff@garzik.org>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>,
       "Linux RAID Mailing List" <linux-raid@vger.kernel.org>, marc@perkel.com
In-Reply-To: <44ED3851.7040202@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <44ED1E41.40606@garzik.org> <44ED3723.3090308@nortel.com>
	 <44ED3851.7040202@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/23/06, H. Peter Anvin <hpa@zytor.com> wrote:
> Chris Friesen wrote:
> > Jeff Garzik wrote:
> >
> >> But anyway, to help answer the question of hardware vs. software RAID,
> >> I wrote up a page:
> >>
> >>     http://linux.yyz.us/why-software-raid.html
> >
> > Just curious...with these guys
> > (http://www.bigfootnetworks.com/KillerOverview.aspx) putting linux on a
> > PCI NIC to allow them to bypass Windows' network stack, has anyone ever
> > considered doing "hardware" raid by using an embedded cpu running linux
> > software RAID, with battery-backed memory?
> >
> > It would theoretically allow you to remain feature-compatible by
> > downloading new kernels to your RAID card.
> >
>
> Yes.  In fact, I have been told by several RAID chip vendors that their
> customers are *strongly* demanding that their chips be able to run Linux
>   md (and still use whatever hardware offload features.)
>
> So it's happening.
Speaking of md with hardware offload features:

http://prdownloads.sourceforge.net/xscaleiop/ols_paper_2006.pdf?download

>         -hpa

Dan
