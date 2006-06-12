Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751254AbWFLVH3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbWFLVH3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 17:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932099AbWFLVH3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 17:07:29 -0400
Received: from A.painless.aaisp.net.uk ([81.187.81.51]:8680 "EHLO
	smtp.aaisp.net.uk") by vger.kernel.org with ESMTP id S1751407AbWFLVH2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 17:07:28 -0400
Date: Mon, 12 Jun 2006 22:07:27 +0100
From: Andrew Clayton <andrew@digital-domain.net>
To: Chase Venters <chase.venters@clientec.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: VMSPLIT kernel config option
Message-ID: <20060612220727.4bd12759@alpha.digital-domain.net>
In-Reply-To: <Pine.LNX.4.64.0606121552380.17886@turbotaz.ourhouse>
References: <20060612215434.0b8c873f@alpha.digital-domain.net>
	<Pine.LNX.4.64.0606121552380.17886@turbotaz.ourhouse>
X-Mailer: Sylpheed-Claws 2.2.3 (GTK+ 2.6.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jun 2006 15:55:23 -0500 (CDT), Chase Venters wrote:

> On Mon, 12 Jun 2006, Andrew Clayton wrote:
> 
> > Hi,
> >
> > Is it meant, that the VMSPLIT_* options are only enabled
> > "if EMBEDDED"?
> 
> Indeed. Unfortunately, adjusting VMSPLIT appeared to break the
> assumptions of some programs like Valgrind (and hence caused a
> regression for some users). VMSPLIT was thusly "hidden" under
> CONFIG_EMBEDDED such that the only people who would be inclined to
> mess with the setting were people already tinkering with "low-level"
> settings if you will.

Ah, understood.


Cheers,

Andrew
