Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270862AbTGPKNe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 06:13:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270863AbTGPKNd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 06:13:33 -0400
Received: from mauve.demon.co.uk ([158.152.209.66]:12942 "EHLO
	mauve.demon.co.uk") by vger.kernel.org with ESMTP id S270862AbTGPKNd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 06:13:33 -0400
From: root@mauve.demon.co.uk
Message-Id: <200307161025.LAA01549@mauve.demon.co.uk>
Subject: Re: How to test the new kernel 2.6.0-test1 ?
To: stephane.wirtel@belgacom.net (Stephane Wirtel)
Date: Wed, 16 Jul 2003 11:25:18 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030716082731.GA6202@stargate.brutele.be> from "Stephane Wirtel" at Jul 16, 2003 10:27:31 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I am using the kernel 2.6.0-test1 on my computer, and it works perfectly.
> 
> Which are the weaknesses of the new kernel, an idea ?

It almost certainly has bugs.
Most of the ones present probably don't show up much on an average 
machine, with an average load.

Try the edge cases, such as plugging in twenty thousand USB mice, running
it on a 386/20 with 4Mb ram, unplugging USB devices when in use, ...

The rarer bugs that do present on an average machine, with average loading
just need more people to test, and report oopses or other errors related
to the kernel.

Just running it helps, if only because it lowers the probability of such
bugs being present before 2.6.0 is released.
