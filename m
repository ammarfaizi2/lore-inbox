Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293725AbSCXQc3>; Sun, 24 Mar 2002 11:32:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310139AbSCXQcT>; Sun, 24 Mar 2002 11:32:19 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:15887 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S293725AbSCXQcI>; Sun, 24 Mar 2002 11:32:08 -0500
Subject: Re: [PATCH] Re: Screen corruption in 2.4.18
To: srwalter@yahoo.com (Steven Walter)
Date: Sun, 24 Mar 2002 16:48:20 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk, davej@suse.de, torvalds@transmeta.com,
        marcelo@conective.com.br, linux-kernel@vger.kernel.org
In-Reply-To: <20020324155930.GA20926@hapablap.dyn.dhs.org> from "Steven Walter" at Mar 24, 2002 09:59:30 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16pBAL-0006f2-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Here is a patch which should apply cleanly to everyone's tree, which
> only clears bit 7 on all chips except the KT266.  No problems have been
> reported there, so I'm leaving well enough alone.  Please apply.

No. Not until someone explains to me why VIA specifically told me I must
clear the 3 bits. If you get that wrong you get slow and insidious disk
corruption. Its hard to test and I'm not going to use other people's
hardware as target practice for a hunch.
