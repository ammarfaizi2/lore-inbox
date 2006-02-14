Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030589AbWBNS71@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030589AbWBNS71 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 13:59:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030587AbWBNS71
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 13:59:27 -0500
Received: from nproxy.gmail.com ([64.233.182.207]:40006 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030556AbWBNS7Y convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 13:59:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YRi5qOcA0f8zx10iqiGKYHgVsZjV0V+iTsc02ays13/sSkWcxonVWwy+3QGlVm4DwVXx2oNUZieyQxocjAiorH642G8BtiH6eVGN8RmE4NfKyz1bJXIh687PZZqqmWelHTt4xCOvPfIHI2vbQhr8BPOMCi6DoxASv9bXmid3tOQ=
Message-ID: <58cb370e0602141059i690f665bs39601ba4766585c5@mail.gmail.com>
Date: Tue, 14 Feb 2006 19:59:21 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] ide: Allow IDE interface to specify its not capable of 32-bit operations
Cc: Kumar Gala <galak@kernel.crashing.org>, Andrew Morton <akpm@osdl.org>,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1139939605.11979.2.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.44.0602141022000.27351-100000@gate.crashing.org>
	 <1139935828.10394.44.camel@localhost.localdomain>
	 <58cb370e0602140900n4558d608p36e73a58c132b8ac@mail.gmail.com>
	 <1139939605.11979.2.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Maw, 2006-02-14 at 18:00 +0100, Bartlomiej Zolnierkiewicz wrote:
> > > Do a grep over the code for no_io_32bit and you will see its essentially
> > > a private variable in the CMD640 driver.
> >
> > Please grep ide.c for "no_io_32bit".  Thank you.
>
> Ok I take it back its merely broken and pointless code rather than do
> nothing.

You are welcomed to fix what you think is broken/pointless.

OTOH Kumar's patch is perfectly fine.

Thank you,
Bartlomiej
