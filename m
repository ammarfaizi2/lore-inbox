Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261669AbVCOUWO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261669AbVCOUWO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 15:22:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261793AbVCOUVu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 15:21:50 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:27849 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261669AbVCOUTm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 15:19:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=c2Ypjbms4HtFuuD+y1VZiJg4fT1iEjOiYprSgPeYbiZAQUNrZik2UxMX/kma3PPbPvX8laSUPaEcKcnlGYsziOjq25DBKpJfhd/QcUWHlaK0OH4GgVjGr5zdbtvtvSRIGs+H9iMk1r3rIJ7UaWGF18o5wiU9a1+VNuHYjqCW0DA=
Message-ID: <a71293c2050315121938cd9dc1@mail.gmail.com>
Date: Tue, 15 Mar 2005 15:19:40 -0500
From: Stephen Evanchik <evanchsa@gmail.com>
Reply-To: Stephen Evanchik <evanchsa@gmail.com>
To: =?UTF-8?Q?Pawe=C5=82_Sikora?= <pluto@pld-linux.org>
Subject: Re: [PATCH 2.6.11] IBM TrackPoint support
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200503152049.26488.pluto@pld-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
References: <a71293c2050313210230161278@mail.gmail.com>
	 <200503152049.26488.pluto@pld-linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Mar 2005 20:49:25 +0100, Paweł Sikora <pluto@pld-linux.org> wrote:
> On Monday 14 of March 2005 06:02, Stephen Evanchik wrote:
> > Here's the latest patch for TracKPoint devices. I have changed the
> > sysfs filenames to be more descriptive for commonly used attributes. I
> > also implemented the set_properties flag for initialization.
> >
> > It patches against 2.6.11 and 2.6.11.3 however I have not tested it
> > with 2.6.11.3 .
> >
> > Any comments are appreciated.
> 
>   CC [M]  drivers/input/mouse/psmouse-base.o
> drivers/input/mouse/psmouse-base.c: In function 'psmouse_extensions':
> drivers/input/mouse/psmouse-base.c:489: error: 'PSMOUSE_TRACKPOINT' undeclared
> 
> ;-)

Thanks, I noticed this last night and have it fixed in the new patch
yet to be submitted ;)


Stephen
