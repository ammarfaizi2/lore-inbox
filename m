Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262036AbULPVpZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262036AbULPVpZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 16:45:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262034AbULPVpY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 16:45:24 -0500
Received: from rproxy.gmail.com ([64.233.170.198]:25353 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262036AbULPVpS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 16:45:18 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=TJGyUYFWtCJ84MeD24fIozusXwMHnkcLvyCxUXYLbjv7YKcgVV1G0712fnIQX01frUK6AZIYJPVogXZ1i3U8QtOk6GD7Do/xsxSn6EsW7JYQQPrtE79Px8y3XUBQRcOkUOxKd4fjR9/9KQGfxAaOo1s0HhsCVJ+QS9GsAYOOysY=
Message-ID: <d120d5000412161345420548f9@mail.gmail.com>
Date: Thu, 16 Dec 2004 16:45:17 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Andrew Walrond <andrew@walrond.org>
Subject: Re: bkbits problem?
Cc: linux-kernel@vger.kernel.org,
       Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
       bitkeeper-users@bitmover.com
In-Reply-To: <200412162116.57509.andrew@walrond.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20041216190159.GA31805@one-eyed-alien.net>
	 <200412162116.57509.andrew@walrond.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Dec 2004 21:16:57 +0000, Andrew Walrond <andrew@walrond.org> wrote:
> On Thursday 16 Dec 2004 19:01, Matthew Dharm wrote:
> > Is anyone besides me having difficulty cloning a tree from
> > linux.bkbits.net/linux-2.5 or 2.6?
> >
> > I keep getting:
> >
> > [mdharm@g5 mdharm]$ bk clone bk://linux.bkbits.net/linux-2.5 linux-405-2.5
> > Clone bk://linux.bkbits.net/linux-2.5
> >    -> file://home/mdharm/linux-405-2.5
> > BAD gzip hdr
> > read: No such file or directory
> > 0 bytes uncompressed to 0, nanX expansion
> > sfio errored
> >
> > I can clone from linuxusb, so I don't _think_ it's a problem on my end...
> >
> 
> I reported the same thing on Sunday to the bitkeeper-users ML (see below)
> Interestingly, I can 'pull' to an existing linux-2.5 repo now, but clone is
> still busted.
> 

Try using http for cloning - worked for me last time (bk clone
http://linux.....)

-- 
Dmitry
