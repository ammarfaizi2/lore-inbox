Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262706AbTE0Gik (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 02:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262709AbTE0Gij
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 02:38:39 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:30725 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S262706AbTE0Gij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 02:38:39 -0400
Date: Mon, 26 May 2003 23:51:48 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jeff Garzik <jgarzik@pobox.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [BK PATCHES] add ata scsi driver
In-Reply-To: <Pine.LNX.4.44.0305262314260.18484-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0305262339510.19197-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 26 May 2003, Linus Torvalds wrote:
> 
> And quite frankly, names matter, and calling it SCSI is clearly wrong.  

Btw, in case you wonder why I care about names and organization, it's 
because with the names and organization comes assumptions and 
expectations.

One prime example of this is cdrecord, and the incredible braindamage that
the name "SCSI" foisted upon it. Why? Because everybody (ie schily)  
_knows_ that SCSI is addressed by bus/id/lun, and thinks that anything
else is wrong. So you have total idiocies like the "cdrecord -scanbus"  
crap for finding your device, and totally useless naming that makes no 
sense in any sane environment.

Calling something SCSI when it isn't brings on these kinds of bad things: 
people make assuptions that aren't sensible or desireable.

Names have power. There's baggage and assumptions in a name. In the case
of SCSI, there is a _lot_ of baggage.

			Linus

