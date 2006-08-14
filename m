Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932096AbWHNQGJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096AbWHNQGJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 12:06:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbWHNQGI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 12:06:08 -0400
Received: from wr-out-0506.google.com ([64.233.184.229]:22757 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751134AbWHNQGH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 12:06:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=C1wE+5i1Y7TUK+r3LWeHFrxR+tkpi7EOVhgBB3XGyETS1fag4T0PyRmCOEbFx7VOX2248v9dCfiNtjrkEyQCpOT08jviy714X6gXdJBhQ0Yx3J42sdTOUIECTK8SJ0XOcOg0wCmOJ/zppigUGGO790bQcQCALUDUiJLkmxAcb4I=
Message-ID: <d120d5000608140906x47bc572blb1b9821ead987d7e@mail.gmail.com>
Date: Mon, 14 Aug 2006 12:06:06 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Andreas Mohr" <andi@rhlx01.fht-esslingen.de>
Subject: Re: Touchpad problems with latest kernels
Cc: "Gene Heskett" <gene.heskett@verizon.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20060814155437.GA801@rhlx01.fht-esslingen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <BAY114-F2C4913B499BE3113C8E9BFA4E0@phx.gbl>
	 <200608141038.04746.gene.heskett@verizon.net>
	 <20060814152000.GA19065@rhlx01.fht-esslingen.de>
	 <d120d5000608140841q657c6c2euae986b37f6aff605@mail.gmail.com>
	 <20060814155437.GA801@rhlx01.fht-esslingen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/14/06, Andreas Mohr <andi@rhlx01.fht-esslingen.de> wrote:
> On Mon, Aug 14, 2006 at 11:41:29AM -0400, Dmitry Torokhov wrote:
> > On 8/14/06, Andreas Mohr <andi@rhlx01.fht-esslingen.de> wrote:
> > >Plus, I'm sometimes having issues with pointer movement (cursor won't
> > >advance
> > >any more unless I stop touching the touchpad for a few seconds to let it
> > >reset somehow - probably a bytestream hickup issue).
> > >
> > >Any clues?
> > >
> >
> > Yes, you might want to reseat your touchpad connector and vacuum the
> > case a bit. Inspiron 8000 is almost the same as 8100 and I am using it
> > constantly ;) Well, I thought my keyboard broke because PgUp stopped
> > working but it recovered after I got a hairball from under the key.
>
> Hmm, might need to verify that, but I've been cleaning it from time to time
> (Murphy tells me that it was the regular cleaning which broke it ;).
>

That could be too ;)

> > Just make sure you do not pull ACPI battery info to often.
>
> Uh... why!?
>

On many laptops (including mine) polling battery takes a loooong time
and is done in SMI mode in BIOS causing lost keypresses, jerky mouse
etc. It is pretty common problem. I think I have my ACPI client
refreshing every 3 minutes.

-- 
Dmitry
