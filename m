Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263819AbTJ1CEJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 21:04:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261506AbTJ1CEJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 21:04:09 -0500
Received: from vladimir.pegasys.ws ([64.220.160.58]:39953 "EHLO
	vladimir.pegasys.ws") by vger.kernel.org with ESMTP id S263824AbTJ1CEB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 21:04:01 -0500
Date: Mon, 27 Oct 2003 18:03:56 -0800
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: Blockbusting news, results end
Message-ID: <20031028020356.GN8540@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <20031027205854.GF8540@pegasys.ws> <Pine.LNX.4.10.10310271425000.14405-100000@master.linux-ide.org> <20031027225727.GI8540@pegasys.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031027225727.GI8540@pegasys.ws>
User-Agent: Mutt/1.3.27i
X-Message-Flag: The contents of this message may cause confusion and disorientation to persons think they know everything.  Read at your own risk.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 27, 2003 at 02:57:27PM -0800, jw schultz wrote:
> On Mon, Oct 27, 2003 at 02:27:09PM -0800, Andre Hedrick wrote:
> > 
> > To date IDEMA has not released a formal spec for drive makers to switch to
> > 4Kb sectors.  If they have, then when running in compatibility mode, a
> > heavy read-modify-write happens to goto the pseudo sector of 512b.
> > 
> > Linux can not handled new IDEMA calls currently.
> 
> Irrelevant!

Andre, if you were trying to say what i am about to, i
apologise.

> I am assuming that these numbers are applicable (one is
> unknown):
> 	logical sector size == 512B
> 	physical sector size == ???B
> 	page size/filesystem block size == 4KB

I have dialoged with Eric Mudama.  He is 99% sure that no
manufacturer of is making ATA drives with physical sectors
larger than 512B.  I'll let that statement trump Norman
Diamond's until i hear otherwise.

The drive manufacturers would like to be able to go to a
larger physical sector but the read-modify-write is just too
scary.  If they could be sure of market acceptance of drives
that required all I/O to be in larger units they would build
them because it would allow greater capacity (and i'm
guessing speed as well) on the same physical hardware.
I look forward to the day with Linux has enough market-share
to influence the hardware manufacturers.

In any case, unless someone can authoritatively contradict
Eric we can ignore the firmware read-modify-write
implications of unreadable sectors.

End-of-subthread!
or in the words of Emily Latella "Never-mind".

