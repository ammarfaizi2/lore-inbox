Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262197AbTEZT4e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 15:56:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262202AbTEZT4e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 15:56:34 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:2826 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S262197AbTEZT4d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 15:56:33 -0400
Date: Mon, 26 May 2003 13:09:29 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jeff Garzik <jgarzik@pobox.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [BK PATCHES] add ata scsi driver
In-Reply-To: <3ED2533A.1000602@pobox.com>
Message-ID: <Pine.LNX.4.44.0305261306500.12186-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 26 May 2003, Jeff Garzik wrote:
> 
> Correct, but precisely by saying that, you're missing something.

You're missing _my_ point.

> The SCSI midlayer provides infrastructure I need -- which is not 
> specific to SCSI at all.

If it isn't specific to SCSI, then it sure as hell shouldn't BE THERE!

My point is that it's _wrong_ to make non-SCSI drivers use the SCSI layer, 
because that shows that something is misdesigned.

And I bet there isn't all that much left that really helps.

You adding more "pseudo-SCSI" crap just _makes_things_worse. It does not 
advance anything, it regresses. 

		Linus

