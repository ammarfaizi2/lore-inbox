Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135580AbRD1SF3>; Sat, 28 Apr 2001 14:05:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135581AbRD1SFT>; Sat, 28 Apr 2001 14:05:19 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:32781 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S135576AbRD1SFN>;
	Sat, 28 Apr 2001 14:05:13 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200104281804.f3SI4ar368494@saturn.cs.uml.edu>
Subject: Re: 2.4 and 2GB swap partition limit
To: R.E.Wolff@BitWizard.nl (Rogier Wolff)
Date: Sat, 28 Apr 2001 14:04:35 -0400 (EDT)
Cc: wakko@animx.eu.org (Wakko Warner), R.E.Wolff@BitWizard.nl (Rogier Wolff),
        xavier.bestel@free.fr (Xavier Bestel),
        goswin.brederlow@student.uni-tuebingen.de (Goswin Brederlow),
        fluffy@snurgle.org (William T Wilson), Matt_Domsch@Dell.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <200104281411.QAA04406@cave.bitwizard.nl> from "Rogier Wolff" at Apr 28, 2001 04:11:47 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rogier Wolff writes:
> Wakko Warner wrote:

>>> So you've spent almost $200 for RAM, and refuse to spend
>>> $4 for 1Gb of swap space. Fine with me. 

So that is a factor of 50 in price. It's what, a factor of 1000000
in access time?

> That disk space is just sitting there. Never to be used. I spent $400
> on the RAM, and I'm now reserving about $8 worth of disk space for
> swap. I think that the $8 is well worth it. It keeps my machine
> functional a while longer should something go haywire... As I said:
> If you don't want to see it that way: Fine with me. 

It is a disaster waiting to happen. Instead of having the offending
process get killed, your machine could suffer extreme thrashing.

Have enough swap for idle processes and no more.
