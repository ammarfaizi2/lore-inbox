Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265772AbUGHEVM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265772AbUGHEVM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 00:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265774AbUGHEVM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 00:21:12 -0400
Received: from postoffice01.Princeton.EDU ([128.112.129.75]:32702 "EHLO
	Princeton.EDU") by vger.kernel.org with ESMTP id S265772AbUGHEVK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 00:21:10 -0400
Date: Thu, 8 Jul 2004 00:21:01 -0400 (EDT)
From: "Alexey N. Spiridonov" <aspirido@Princeton.EDU>
Cc: Antille Julien <julien.antille@eivd.ch>
Subject: Re: kacpid takes 99% of CPU when laptop lid is closed
Message-Id: <20040708001546.32d324a4@sheepiness>
In-Reply-To: <200406161244.55502.julien.antille@eivd.ch>
References: <200406161244.55502.julien.antille@eivd.ch>
Organization: Princeton University
X-Mailer: Sylpheed version 0.9.9claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have exactly the same laptop as Antille and exactly the same problem.

I did some stuff to diagnose it. I have the output of oprofile, my startup messages with ACPI debug messages enabled, and the messages when the lid is closed for about 2 seconds.
The debug configuration is: all components, and level VERBOSITY1.

They're all available here:
  http://www.math.princeton.edu/~aspirido/gpe-bug/
Watch out -- the two debug logs, uncompressed, are  pretty big (~20mb).

Here's the DSDT for the laptop:
http://acpi.sourceforge.net/dsdt/tables/Dell/Inspiron_2650/Dell-Inspiron_2650-A05-original.asl.gz

I know next to nothing about ACPI, but I hope I can help debug it, if it hasn't been fixed.
Otherwise, I'd like to help test the patch.

Best,

Alexey

