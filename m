Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272941AbTHKSg7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 14:36:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272824AbTHKSem
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 14:34:42 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:29201 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id S272941AbTHKSeN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 14:34:13 -0400
Date: Mon, 11 Aug 2003 19:35:50 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Florian Weimer <fw@deneb.enyo.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.0-test3] Hyperthreading gone
In-Reply-To: <87smo8xdup.fsf@deneb.enyo.de>
Message-ID: <Pine.LNX.4.44.0308111925050.1499-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Aug 2003, Florian Weimer wrote:
> Hugh Dickins <hugh@veritas.com> writes:
> 
> > Florian, at the moment, in 2.4 and in 2.6, you do have to specify the
> > "acpismp=force" boot parameter to get HT to work with CPU Enumeration
> > Only:
> 
> With 2.4, I get hyperthreading without any ACPI configuration option.

In 2.4.which?  When I said "at the moment", I was meaning "latest",
2.4.22-pre1 through 2.4.22-rc2.  Sure, 2.4.21 and a few earlier could
do HyperThreading without CONFIG_ACPI, but 2.4.22-pre1 changed that.

Hugh

