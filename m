Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262683AbTLIVrl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 16:47:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262705AbTLIVrl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 16:47:41 -0500
Received: from warden3-p.diginsite.com ([208.147.64.186]:8869 "HELO
	warden3.diginsite.com") by vger.kernel.org with SMTP
	id S262683AbTLIVrk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 16:47:40 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Bob <recbo@nishanet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Date: Tue, 9 Dec 2003 14:31:36 -0800 (PST)
Subject: Re: dialectical deprecation Re: cdrecord hangs my computer
In-Reply-To: <3FD4CF90.3000905@nishanet.com>
Message-ID: <Pine.LNX.4.58.0312091430320.19636@dlang.diginsite.com>
References: <Law9-F31u8ohMschTC00001183f@hotmail.com><Pine.LNX.4.58.0312060011130.2092@home.osdl.org>
 <3FD1994C.10607@stinkfoot.org><20031206084032.A3438@animx.eu.org>
 <Pine.LNX.4.58.0312061044450.2092@home.osdl.org><20031206220227.GA19016@work.bitmover.com>
 <Pine.LNX.4.58.0312061429080.2092@home.osdl.org><20031207110122.GB13844@zombie.inka.de>
 <Pine.LNX.4.58.0312070812080.2057@home.osdl.org> <1201390000.1070900656@[10.10.2.4]>
 <3FD4CF90.3000905@nishanet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bob, I don't believe that the 3ware card uses ide-scsi, yes it uses IDE
drives and looks like a SCSI controller, but that's done in the 3ware
driver, not by useing ide-scsi.

David Lang

On Mon, 8 Dec 2003, Bob wrote:

> I'm scared(under-informed) to drop ide-scsi since
> I'm using 3ware and don't know if just scsi-generic
> would be enough for that hd controller(needs ide-scsi?
> 3ware's site doc is not easy to find).

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
