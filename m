Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266527AbUHSPu6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266527AbUHSPu6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 11:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266535AbUHSPu6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 11:50:58 -0400
Received: from apate.telenet-ops.be ([195.130.132.57]:42905 "EHLO
	apate.telenet-ops.be") by vger.kernel.org with ESMTP
	id S266527AbUHSPu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 11:50:56 -0400
Subject: Re: ati_remote for medion
From: Karel Demeyer <kmdemeye@vub.ac.be>
To: Tom Felker <tcfelker@mtco.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200408191016.06528.tcfelker@mtco.com>
References: <1092904136.3352.5.camel@kryptonix>
	 <200408191016.06528.tcfelker@mtco.com>
Content-Type: text/plain
Date: Thu, 19 Aug 2004 17:51:14 +0200
Message-Id: <1092930674.6966.6.camel@kryptonix>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Are the keycodes unique enough that you can just put the keymaps for both 
> remotes into the same table?  I.E. when you wrote your keymaps, did you have 
> to remove some of the others to get it to work, or was that just for 
> cleanliness?  Otherwise, we'd need to have multiple tables and choose which 
> to use based on which remote is being used.
> 
> Oh, and do stick around, Karel, someone will need to test the result.
> 
> BTW, does anyone know whether the probe function actually needs to check 
> whether the product and vendor IDs match the device?  I've seen docs that 
> imply yes, but many drivers don't check, and I feel stupid iterating thru the 
> table if no.
> 
> Have fun,


I don't know if anything I say is usefull, but: The keys on my remote
and those on the ati-remotes doesn't seem to share the same 'hex-
code' (?).  I had to manually find out each code per key (I didn't know
how to do it).  The hardwarealso has other (and maybe more) keys.  The
ati remote has mouse-buttons for example.  In the code I sent earlier, I
made a ASCII-scetch of how my remote looks like (if someone wants it,
I'll put a photot online ;)).  So, I think the driver will need to
separate tables to choose from when it knows which remote is used.  

Secondly, I'd like to say that I HAD to change the Vendor_ID - thing to
let it work with my remote (found it out using lsusb ;)).


Don't shoot me if I say anything irrevelant, and I'll stay around for
testing and stuff, even my evolution-filters arenot what they should be
- they copy it both in my Inbox and my 'Linux-kernel'-directory :|

greets,

Karel "scapor" Demeyer.


