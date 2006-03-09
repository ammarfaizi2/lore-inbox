Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932705AbWCICSN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932705AbWCICSN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 21:18:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932707AbWCICSN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 21:18:13 -0500
Received: from wproxy.gmail.com ([64.233.184.206]:59845 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932705AbWCICSN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 21:18:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=m2cWXcw+dZVeps6/ZAnRlE95pXC76GmKHqWQ6V/Lmw8YaogawBwoFNVw8LzSssa1szJq2PmMUPHiADY4BA1ZUvrSkdjyYiFUzURxdwsTfoPD+H9cannOVyKNLOz7tqujdlw6MDBgLFa+slyeSJ1gvSttkc5eQ/wMUiBX2uNTrec=
Message-ID: <625fc13d0603081818l5a462e3aseb5c0007cda2d9ec@mail.gmail.com>
Date: Wed, 8 Mar 2006 20:18:11 -0600
From: "Josh Boyer" <jwboyer@gmail.com>
To: "Adrian Bunk" <bunk@stusta.de>
Subject: Re: problem mounting a jffs2 filesystem
Cc: "David Woodhouse" <dwmw2@infradead.org>,
       "Miguel Blanco" <mblancom@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20060308220710.GQ4006@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <8766c4ce0603050504h24b445c5t@mail.gmail.com>
	 <1141652131.4110.47.camel@pmac.infradead.org>
	 <20060308220710.GQ4006@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/8/06, Adrian Bunk <bunk@stusta.de> wrote:
> On Mon, Mar 06, 2006 at 01:35:31PM +0000, David Woodhouse wrote:
> > On Sun, 2006-03-05 at 14:04 +0100, Miguel Blanco wrote:
> > >  divide error: 0000 [#1]
> > >  EIP is at jffs2_scan_medium+0xdf/0x55e [jffs2]
> >
> > Can you try it with the attached patch? Or turn off
> > CONFIG_JFFS2_FS_WRITEBUFFER
>
> This patch seems to be 2.61.6 stuff?

I would agree that it could be 2.6.16 material.  Especially given that
it fixes a know problem for a user.  David?

josh
