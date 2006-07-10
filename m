Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964909AbWGJNSU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964909AbWGJNSU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 09:18:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbWGJNSU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 09:18:20 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:43136 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751339AbWGJNST (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 09:18:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JbgalsHHxJjdc6DhA9w0wUdj8l4hZmRJy4gXvyXryis6xVsiUvkKg9+1Xtm+UgGvlVBWZi7a8O6KXGkMFWLf4OmtQTmIRiEGywwyMN1506JIRp+QON7UNhhazoo1wr0r/LizKXy+d4SB1vXWy9akCcUn0pbLyJfYrs1RrRqZbRk=
Message-ID: <9e4733910607100618v2bfa857w17fbb1c6f2827a84@mail.gmail.com>
Date: Mon, 10 Jul 2006 09:18:17 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: CaT <cat@zip.com.au>
Subject: Re: [PATCH] Clean up old names in tty code to current names
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>, "H. Peter Anvin" <hpa@zytor.com>,
       "Greg KH" <greg@kroah.com>, lkml <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>
In-Reply-To: <20060710131204.GO2344@zip.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <9e4733910607092111i4c41c610u8b9df5b917cca02c@mail.gmail.com>
	 <1152524657.27368.108.camel@localhost.localdomain>
	 <9e4733910607100541i744dd744n16c35c50dae1e98d@mail.gmail.com>
	 <1152537049.27368.119.camel@localhost.localdomain>
	 <9e4733910607100603r5ae1a21ex1a2fa0f045424fd1@mail.gmail.com>
	 <20060710131204.GO2344@zip.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/10/06, CaT <cat@zip.com.au> wrote:
> On Mon, Jul 10, 2006 at 09:03:49AM -0400, Jon Smirl wrote:
> > one in-kernel and one out of kernel? I'm not even sure if USB will
> > work without udev anymore.
>
> *blink* I use USB every other day, on recent kernels without problems
> and without udev. What should I expect not to work for me?

The hotplug handlers need udev. For example plugging in a new storage
device and expecting kernel support to get autoloaded for it.

If you have a fixed set of devices and have compiled in support for
all of them and made static device nodes, then you don't need it. But
in this case you don't need in-kernel naming support either.

-- 
Jon Smirl
jonsmirl@gmail.com
