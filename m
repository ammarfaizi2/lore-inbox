Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132807AbRDDMwl>; Wed, 4 Apr 2001 08:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132809AbRDDMwc>; Wed, 4 Apr 2001 08:52:32 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:43533 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132807AbRDDMwV>; Wed, 4 Apr 2001 08:52:21 -0400
Subject: Re: uninteruptable sleep (D state => load_avrg++)
To: christophe.barbe@lineo.fr (christophe barbe)
Date: Wed, 4 Apr 2001 13:53:34 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20010404141349.A6702@pc8.inup.com> from "christophe barbe" at Apr 04, 2001 02:13:49 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14kmn2-0001sb-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The sleep should certainly be interruptible and I that's what I said to t=
> he GFS guy.
> But what the reason to increment the load average for each D process ?

D indicates short term I/O wait. This is how unix has always computed the
laod average.

