Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129227AbRBNTyj>; Wed, 14 Feb 2001 14:54:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130826AbRBNTy3>; Wed, 14 Feb 2001 14:54:29 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:33809 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130761AbRBNTyY>; Wed, 14 Feb 2001 14:54:24 -0500
Subject: Re: Multicast on loopback?
To: egb@erikburrows.com (Erik G. Burrows)
Date: Wed, 14 Feb 2001 19:54:04 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0102141105140.19982-100000@centrum.jedi-group.com> from "Erik G. Burrows" at Feb 14, 2001 11:16:21 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14T808-0005qP-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I read that multicast loopback is by default enabled, and I have witnessed
> this, when having my application bind to my ethernet interface, but the
> datagrams do not seem to be looped back when I bind to the 'lo' interface.

I wouldnt expect them to be. The lo interface does not support multicasting.
I dont think this is a bug

