Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932400AbWIVQ3Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932400AbWIVQ3Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 12:29:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751160AbWIVQ3X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 12:29:23 -0400
Received: from wx-out-0506.google.com ([66.249.82.224]:22486 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750791AbWIVQ3X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 12:29:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TheR7hez63QjQ7+EOpbuuuh205LeFHNpCAXuray9ZSnOcMKp2NGaWSVyGne42/bRlI1iPRE0ZZGaIOOgA6IOXuXU5ORrBJQdntfuD0iDEX2nXZ/go8V2cXKohC5pXqMwYwWM0Mk0qPKHzpviu45uyGsHsS0e5csTr/5GPCioofI=
Message-ID: <bd0cb7950609220929j55c24230h4e53db34af0ac385@mail.gmail.com>
Date: Fri, 22 Sep 2006 12:29:21 -0400
From: "Tom St Denis" <tomstdenis@gmail.com>
To: "Daniel Drake" <dsd@gentoo.org>
Subject: Re: sky2 eth device with Gigabyte 965P-S3 motherboard
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <450E4C25.9030206@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <bd0cb7950609200635qae3e0c6p3f7d776d33b50542@mail.gmail.com>
	 <4513D362.8030804@gentoo.org>
	 <bd0cb7950609220629i191683bq7b21fca3e04fafb1@mail.gmail.com>
	 <450E4C25.9030206@gentoo.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/18/06, Daniel Drake <dsd@gentoo.org> wrote:
> Tom St Denis wrote:
> > This won't be fixed as part of 2.6.18.x?
>
> Probably not.

It's a one line fix!!! :-/

> It wasn't detected under 2.6.17. Either your kernel is modified, or you
> were using the vendor sk98lin driver or something like that. If you have
> 2.6.17 still bootable you could boot it and check the dmesg output to
> make sense of things.

No, i get sky2 printk after udev kicks in.  It was a 2.6.17-gentoo-r8
kernel which has devices 4364 through 4368 [just checked].

This means my patch is incomplete, and the fix Gentoo made against
2.6.17 didn't make it into 2.6.18.  ARRG.

Tom
