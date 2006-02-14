Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422663AbWBNRAo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422663AbWBNRAo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 12:00:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422664AbWBNRAo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 12:00:44 -0500
Received: from nproxy.gmail.com ([64.233.182.198]:47203 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1422663AbWBNRAn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 12:00:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BGjUvhZgaW6sA2DQjUP3LsaiGGfzzVKjBS0yjC/ms7pLPaeNCVHZTaVx+yn81RctgXOeu87hv5FcqRXi9oVc+6irsddqpDGTewtUfEQBqMr35PapfmOboxaHnss920cqoeWuKQxdqyUtP1uSLETNLqxGTejZwzOOY6qUNL1tdTs=
Message-ID: <58cb370e0602140900n4558d608p36e73a58c132b8ac@mail.gmail.com>
Date: Tue, 14 Feb 2006 18:00:41 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] ide: Allow IDE interface to specify its not capable of 32-bit operations
Cc: Kumar Gala <galak@kernel.crashing.org>, Andrew Morton <akpm@osdl.org>,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1139935828.10394.44.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.44.0602141022000.27351-100000@gate.crashing.org>
	 <1139935828.10394.44.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Maw, 2006-02-14 at 10:22 -0600, Kumar Gala wrote:
> > In some embedded systems the IDE hardware interface may only support 16-bit
> > or smaller accesses.  Allow the interface to specify if this is the case
> > and don't allow the drive or user to override the setting.
>
> The "no_io_32bit" is just a dead leftover. It has no effect at all
> anyway so this patch is a bit pointless.
>
> Do a grep over the code for no_io_32bit and you will see its essentially
> a private variable in the CMD640 driver.

Please grep ide.c for "no_io_32bit".  Thank you.

Bartlomiej
