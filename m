Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262000AbTFIUwY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 16:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262001AbTFIUwX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 16:52:23 -0400
Received: from smtp017.mail.yahoo.com ([216.136.174.114]:52752 "HELO
	smtp017.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262000AbTFIUwW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 16:52:22 -0400
From: Steve Brueggeman <xioborg@yahoo.com>
To: "Lars Unin" <lars_unin@linuxmail.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: What are .s files in arch/i386/boot
Date: Mon, 09 Jun 2003 16:06:01 -0500
Message-ID: <mkt9evc8eossmephq3675ep0u0e73h690l@4ax.com>
References: <20030609153039.1427.qmail@linuxmail.org>
In-Reply-To: <20030609153039.1427.qmail@linuxmail.org>
X-Mailer: Forte Agent 1.93/32.576 English (American)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not sure, but I think this is what you want.

http://www.ibiblio.org/pub/Linux/docs/HOWTO/other-formats/html_single/Linux-Init-HOWTO.html

Steve Brueggeman


On Mon, 09 Jun 2003 23:30:38 +0800, you wrote:

>From: Mark Hahn <hahn@physics.mcmaster.ca>
> > > > What are .s files in arch/i386/boot, are they c sources of some sort?
>> 
>> no.  is there some reason you can't just look at them?
>> 
>> > > > Where can I find the specifications documents they were made from? 
>> > > 
>> > > There are not c files.
>> > > They are assembler files
>> 
>> .s files are versions of .S files that have been run through cpp (gcc -E).
>> you can know this simply by looking at the makefiles or watching a build,
>> or by looking at the .s file and noticing the #line directives.
>> 
>> > > Try running gcc on a c file with the -S option
>> > > it will generate the same then you can tweak the
>> > > assembler produced to make it faster.
>> 
>> that's useful advice, but irrelevant in this case.
>> 
>> > Where can I find the .c files they were made from,
>> 
>> they aren't.
>> 
>> > and the spec sheets the .c files were made from? 
>> 
>> what the heck is a "spec sheet"?
>
>I mean where can I find the information from which
>
>"* It then loads 'setup' directly after itself (0x90200), and the system
> * at 0x10000, using BIOS interrupts. "
>-- bootsect.S
>
>The ability to know how to get the BIOS to do that comes from, e.g. a
>book that can tell me how to do that without taking another degree...
>Where the information can be found, that says what BIOS memory 
>area 0x90200 is for etc.

