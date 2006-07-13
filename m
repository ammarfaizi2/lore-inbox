Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030230AbWGMPUK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030230AbWGMPUK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 11:20:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030231AbWGMPUK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 11:20:10 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:3954 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030230AbWGMPUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 11:20:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fUiq4BJeUcuUuJbS8z0VTiTGqmACAwoxhhWbQZxW1jhUHK273dO2mmXf3dGzZ/whOE6h+RSvm/+zAdRXLBeECbr/k/4pIOquMVWmxzkLiDqn6WE/xfuOh0WfFoHwS4CSzPKxk7AK2x5zj3n+sT4zs8q88yCLgu0LVagh0H0/v4s=
Message-ID: <36bf289b0607130820r49112c0eqae6a1329432d4ddf@mail.gmail.com>
Date: Thu, 13 Jul 2006 11:20:06 -0400
From: "Vijay Kiran Kamuju" <infyquest@gmail.com>
To: "Molle Bestefich" <molle.bestefich@gmail.com>
Subject: Re: "assumed" graphic card memory
Cc: wine-devel@winehq.org, linux-kernel@vger.kernel.org
In-Reply-To: <62b0912f0607130810w5fd768f6k19294f3fafb42dc3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060711162356.GK11322@byleth.sc-networks.de>
	 <62b0912f0607121326s428ceb57h2fae8f1e9855acb6@mail.gmail.com>
	 <200607121719.14528.ns03ja@brocku.ca>
	 <62b0912f0607130810w5fd768f6k19294f3fafb42dc3@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

May be using we can use the internals of lspci and pciutils.
So that we can calculate the VGA memory on the fly.

On 7/13/06, Molle Bestefich <molle.bestefich@gmail.com> wrote:
> > I'd say it needs a framebuffer device which I do not have
>
> Use the PCI variant ;-).
>
> > Also, the PCI path varies a lot
>
> Obviously.  The correct PCI path would need to be found first.
>
> (I used "lspci|grep VGA", hehe.)
>
> > None of this works at all on non-Linux systems, for that matter.
> > (Wine does run on non-Linux systems, in case you didn't realize that.)
>
> Default to 64MB on those systems.
>
> > This reports the wrong values for me in
> > one machine with a 32M video card:
> > 134217728
>
> Ok.  Guess it's rubbish then, too bad.
> Oh well.
>
> > It might be possible to guesstimate the available memory:
> > http://delphi3d.net/articles/viewarticle.php?article=texman.htm
>
> Promising!
>
> But perhaps an easier approach would be to fix every Linux driver
> to report the correct number in sysfs.  I'm pretty sure each driver
> knows how much RAM is on the card already, so it should be trivial..
>
>
>
