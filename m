Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268568AbUIBQXu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268568AbUIBQXu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 12:23:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268675AbUIBQXt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 12:23:49 -0400
Received: from rproxy.gmail.com ([64.233.170.205]:40610 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268568AbUIBQXk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 12:23:40 -0400
Message-ID: <311601c904090209235759c7a2@mail.gmail.com>
Date: Thu, 2 Sep 2004 10:23:39 -0600
From: Eric Mudama <edmudama@gmail.com>
Reply-To: Eric Mudama <edmudama@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Driver retries disk errors.
Cc: James Courtier-Dutton <james@superbug.demon.co.uk>,
       "Theodore Ts'o" <tytso@mit.edu>,
       Rogier Wolff <r.e.wolff@harddisk-recovery.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org
In-Reply-To: <1093952325.32684.7.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20040830163931.GA4295@bitwizard.nl>
	 <20040830174632.GA21419@thunk.org>  <41337153.60505@superbug.demon.co.uk> <1093952325.32684.7.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Aug 2004 12:38:45 +0100, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> Not really as far as I can tell. It isn't a disk any more, its a storage
> appliance on a funny connector. It already knows a lot about retries
> internally as well as rewriting blocks with high ECC error
> count. In fact you actually have to issue a different command to do
> read/write without retry.

True, but in the later versions of the ATA specification, the retry
option was depreciated.  I think you'll find virtually every ATA drive
built today ignores that "suggestion" from the host.

--eric
