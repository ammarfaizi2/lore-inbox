Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264461AbTFIPQH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 11:16:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264463AbTFIPQH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 11:16:07 -0400
Received: from 205-158-62-67.outblaze.com ([205.158.62.67]:6884 "EHLO
	spf13.us4.outblaze.com") by vger.kernel.org with ESMTP
	id S264461AbTFIPQE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 11:16:04 -0400
Message-ID: <20030609153039.1427.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Lars Unin" <lars_unin@linuxmail.org>
To: hahn@physics.mcmaster.ca
Cc: linux-kernel@vger.kernel.org
Date: Mon, 09 Jun 2003 23:30:38 +0800
Subject: Re: What are .s files in arch/i386/boot
X-Originating-Ip: 213.1.33.210
X-Originating-Server: ws5-7.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Hahn <hahn@physics.mcmaster.ca>
 > > > What are .s files in arch/i386/boot, are they c sources of some sort?
> 
> no.  is there some reason you can't just look at them?
> 
> > > > Where can I find the specifications documents they were made from? 
> > > 
> > > There are not c files.
> > > They are assembler files
> 
> .s files are versions of .S files that have been run through cpp (gcc -E).
> you can know this simply by looking at the makefiles or watching a build,
> or by looking at the .s file and noticing the #line directives.
> 
> > > Try running gcc on a c file with the -S option
> > > it will generate the same then you can tweak the
> > > assembler produced to make it faster.
> 
> that's useful advice, but irrelevant in this case.
> 
> > Where can I find the .c files they were made from,
> 
> they aren't.
> 
> > and the spec sheets the .c files were made from? 
> 
> what the heck is a "spec sheet"?

I mean where can I find the information from which

"* It then loads 'setup' directly after itself (0x90200), and the system
 * at 0x10000, using BIOS interrupts. "
-- bootsect.S

The ability to know how to get the BIOS to do that comes from, e.g. a
book that can tell me how to do that without taking another degree...
Where the information can be found, that says what BIOS memory 
area 0x90200 is for etc.
-- 
______________________________________________
http://www.linuxmail.org/
Now with e-mail forwarding for only US$5.95/yr

Powered by Outblaze
