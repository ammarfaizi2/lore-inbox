Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269170AbUJUGm2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269170AbUJUGm2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 02:42:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269119AbUJUGmZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 02:42:25 -0400
Received: from rproxy.gmail.com ([64.233.170.193]:4711 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269170AbUJUGlH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 02:41:07 -0400
DomainKey-Signature: a=rsa-sha1; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=Qzr2aLSVN/Vup1I/MoR2UHxJS8v9VjF5plL8U+FrRE/PvnMYPSOf38kd9qWl/xLEfY8FIjFzZLTBxpLQAa3Mkpb++x42ebf9LUqlHuv/hJzFW6ppcy8tIHuVM4egczbjbXe6kTx3Iu9TCndka6FT1d8G82tl+5rIjRIFj4eVFEM
Message-ID: <2c59f0030410202341539842ad@mail.gmail.com>
Date: Thu, 21 Oct 2004 12:11:06 +0530
From: Amit Gud <amitgud1@gmail.com>
Reply-To: Amit Gud <amitgud1@gmail.com>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] Remove union u from linux/fs.h
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
In-Reply-To: <1098284026.3872.121.camel@baythorne.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <2c59f00304102002135ca68dd0@mail.gmail.com>
	 <20041020131015.GB20287@infradead.org>
	 <1098284026.3872.121.camel@baythorne.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Oct 2004 15:53:46 +0100, David Woodhouse <dwmw2@infradead.org> wrote:
> On Wed, 2004-10-20 at 14:10 +0100, Christoph Hellwig wrote:
> > > This patch does that along with the changes in other parts of the
> > > kernel that references the union. Its compile-tested and applies
> > > cleanly to 2.6.9 vanilla.
> >
> > I don't think we shoould do such purely cosmetic changes that break backwards
> > compatibility during stable series.
> 
> I don't think he meant to apply it to 2.6.9.1. 2.6.10.x is an entirely
> new stable series, and 2.6.10-rcX are the development series leading up
> to it, surely?
> 

Anyhow it be applied but I think that you agree with the intent of the patch.

AG
