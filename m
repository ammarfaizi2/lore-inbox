Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261363AbSJLWk3>; Sat, 12 Oct 2002 18:40:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261366AbSJLWk3>; Sat, 12 Oct 2002 18:40:29 -0400
Received: from ip68-13-110-204.om.om.cox.net ([68.13.110.204]:3200 "EHLO
	dad.molina") by vger.kernel.org with ESMTP id <S261363AbSJLWk2>;
	Sat, 12 Oct 2002 18:40:28 -0400
Date: Sat, 12 Oct 2002 17:46:07 -0500 (CDT)
From: Thomas Molina <tmolina@cox.net>
X-X-Sender: tmolina@dad.molina
To: "Murray J. Root" <murrayr@brain.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.42 ide-scsi loads!
In-Reply-To: <20021012213756.GA1582@Master.Wizards>
Message-ID: <Pine.LNX.4.44.0210121740330.970-100000@dad.molina>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Oct 2002, Murray J. Root wrote:

> It's fixed.
> ide-scsi loaded 4 out of 4 tries.

Modular?  If yes, try rmmod ide-scsi.  I am still getting the exact same 
oops and hang I got in:

http://marc.theaimsgroup.com/?l=linux-kernel&m=103351991417181&w=2

To summarize:  If I load ide-scsi on boot and don't remove any components 
while up I don't have a problem.  If I rmmod and ide-scsi related module I 
get an oops with apparent register poisoning (signature 5a5a5a5a in the 
register).  After one of these oops I get a hang on shutdown.  The oops 
and hang I get in 2.5.42 is exactly the same as that in the cited message.

