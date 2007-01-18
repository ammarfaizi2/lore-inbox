Return-Path: <linux-kernel-owner+w=401wt.eu-S932229AbXARS4s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932229AbXARS4s (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 13:56:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932348AbXARS4s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 13:56:48 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:61959 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932229AbXARS4r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 13:56:47 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SwcbQcMysQv7f9W0r0R04feIHbTlItufD9ldVPgzHh68FBmTHpuoABczvERcrULD5weJZwFvMPhysStheXstFGmC2UUAVAMeeh/uhqkGdteenQfGYm9iHJKLq6wueoTLMQmnbyyTEvlGEzQUBW0qvs9AS7of/TnXfH1YfjElmvo=
Message-ID: <58cb370e0701181056v7765f219n7d62a3d28d1310c@mail.gmail.com>
Date: Thu, 18 Jan 2007 19:56:45 +0100
From: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
To: "Mark Lord" <liml@rtr.ca>
Subject: Re: [PATCH] IDE Driver for Delkin/Lexar/etc.. cardbus CF adapter
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <200701131125.38882.liml@rtr.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20070112041720.28755.49663.sendpatchset@localhost.localdomain>
	 <200701131125.38882.liml@rtr.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/13/07, Mark Lord <liml@rtr.ca> wrote:
> On Thursday 11 January 2007 23:17, Bartlomiej Zolnierkiewicz wrote:
> >
> > My working IDE tree (against Linus' tree) now resides here:
> >
> >       http://kernel.org/pub/linux/kernel/people/bart/pata-2.6/patches/
>
> Bart, here's a driver I've been keeping out-of-tree for the past couple of years.
> This is for the Delking/Lexar/ASKA/etc.. 32-bit cardbus IDE CompactFlash adapter card.
>
> It's probably way out of sync with the latest driver model (??), but it still builds/works.
> I'm not interested in doing much of a rewrite, other than for libata someday,
> as I no longer use the card myself.
>
> But lots of other people do seem to use it, so it might be nice to see it "in-tree".
>
> Signed-off-by:  Mark Lord <mlord@pobox.com>

Thanks, I applied it to IDE tree.

[ I must have been really somehow fixated on IDE unregistering/ordering mess
  not to merge it earlier.  Sorry for that. ]
