Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261500AbVE3CfO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbVE3CfO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 22:35:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261499AbVE3CfO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 22:35:14 -0400
Received: from rproxy.gmail.com ([64.233.170.203]:17762 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261500AbVE3CfI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 22:35:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gkmZv3cGQBLCxQweUcGfoCDYO5fWRCWcMhLmF2dWRnG+mHiJ/MzezysV4m96Tq6se2/mvAcloY8HKrR3ByAN8utFnW66G1E1cQ0Kjbq9FXHbwJ48BHByFMOfpIIeSrk5M9U/izXjQw+rzwAMvVHFyqG8FbPn2bL/77S14j98woE=
Message-ID: <311601c9050529193515222ba2@mail.gmail.com>
Date: Sun, 29 May 2005 20:35:08 -0600
From: "Eric D. Mudama" <edmudama@gmail.com>
Reply-To: "Eric D. Mudama" <edmudama@gmail.com>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] SATA NCQ support
Cc: Matthias Andree <matthias.andree@gmx.de>, linux-kernel@vger.kernel.org
In-Reply-To: <4299EF74.9060506@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050527070353.GL1435@suse.de>
	 <20050527131842.GC19161@merlin.emma.line.org>
	 <20050527135258.GW1435@suse.de> <429732CE.5010708@gmx.de>
	 <20050527145821.GX1435@suse.de>
	 <20050529131611.GB13418@merlin.emma.line.org>
	 <4299EF74.9060506@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/29/05, Jeff Garzik <jgarzik@pobox.com> wrote:
> Matthias Andree wrote:
> > Do I take this as SATA is faster than legacy ATA? In what respect?
> > UDMA/33 and SATA I shouldn't be much different if I use the same drive,
> > or is there something?
> 
> It is "likely" to be faster.  Faster bus, newer technology.
> 
>         Jeff

The biggest improvement comes because the drives that ship with the
newer bus technology are newer internally too, they aren't just
repackaged older technology.

Today's current generation products (SATA and PATA100/133) can sustain
over 60MB/s datarates, and the next will probably be even higher.

The drive that could only do UDMA/33 is probably of a disk technology
around 15MB/s or worse.

Today's newest drives are quite fast.

--eric
