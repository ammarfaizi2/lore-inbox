Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269984AbUJVOfX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269984AbUJVOfX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 10:35:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270956AbUJVOfW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 10:35:22 -0400
Received: from rproxy.gmail.com ([64.233.170.198]:24264 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269984AbUJVOfV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 10:35:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=klGBMqm7RF0Ufteh1wCI0LMlVx+dr7Ooi4JCWty1J0O7HNHFBLWNh7w5Lt19KEfd+6SP6e6locEf8pfGJsRJ+8iNTEfspv+N3aFiSpnqfaWXxejWvqrQt3lRtPJe/sySzpoFihgDaep87ExL3IuqPrsbsClMlUCxi58N64jn+Oc=
Message-ID: <58cb370e04102207351d79c481@mail.gmail.com>
Date: Fri, 22 Oct 2004 16:35:20 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Tabris <tabris@tabris.net>
Subject: Re: DVD/ide-cd related Oops 2.6.[89]-mm
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Jens Axboe <axboe@suse.de>
In-Reply-To: <20041022090145.GA6408@tabriel.tabris.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20041022090145.GA6408@tabriel.tabris.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Oct 2004 05:01:45 -0400, Tabris <tabris@tabris.net> wrote:
>         undecoded slave fixup is a oneliner patch in ide-probe to
> recognize both of my Maxtor drives that appear to have the same serial
> number, D3000000. This fix was discussed a month ago or so, as I had run
> into it, but nothing official came of it, and it was never merged to -mm.

Did you test it on different controller (as asked by Eric)?

> Patch attached.

thanks, I'll apply it

Bartlomiej
