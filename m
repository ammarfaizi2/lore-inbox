Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964842AbVKQUZG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964842AbVKQUZG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 15:25:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964843AbVKQUZG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 15:25:06 -0500
Received: from ip213-185-39-113.laajakaista.mtv3.fi ([213.185.39.113]:30633
	"HELO dag.newtech.fi") by vger.kernel.org with SMTP id S964842AbVKQUZF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 15:25:05 -0500
Message-ID: <20051117202503.21906.qmail@dag.newtech.fi>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-0.27
To: linux-kernel@vger.kernel.org
Subject: Re: nanosleep with small value
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Date: Thu, 17 Nov 2005 22:25:03 +0200
From: Dag Nygren <dag@newtech.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


OK,

thanks to all that sorted this out for me. What mislead me
big time was my old manpage for nanosleep() which claimed
to busywait for short nanosleeps().

2.6 doesn't seem to do that.

I will look into the suggested patches. Just hate not being able
to just grab the latest kernel from kernel.org and throw it in there.
Already have to recompile a Matrox display module. Now this would
be an additional problem nuisance.

But once again thanks to all
Dag

