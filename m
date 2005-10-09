Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932302AbVJIWg4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932302AbVJIWg4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Oct 2005 18:36:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932301AbVJIWg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Oct 2005 18:36:56 -0400
Received: from [81.2.110.250] ([81.2.110.250]:14018 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S932298AbVJIWgz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Oct 2005 18:36:55 -0400
Subject: Re: [patch 3/4] new serial flow control
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
In-Reply-To: <20051009114406.GE5104@bouh.residence.ens-lyon.fr>
References: <200501052341.j05Nfod27823@mail.osdl.org>
	 <20050105235301.B26633@flint.arm.linux.org.uk>
	 <20051008222711.GA5150@bouh.residence.ens-lyon.fr>
	 <20051009000153.GA23083@flint.arm.linux.org.uk>
	 <20051009002129.GJ5150@bouh.residence.ens-lyon.fr>
	 <20051009083724.GA14335@flint.arm.linux.org.uk>
	 <20051009100909.GF5150@bouh.residence.ens-lyon.fr>
	 <20051009111718.GA13144@flint.arm.linux.org.uk>
	 <20051009113313.GD5104@bouh.residence.ens-lyon.fr>
	 <20051009114406.GE5104@bouh.residence.ens-lyon.fr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 10 Oct 2005 00:04:20 +0100
Message-Id: <1128899060.2938.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2005-10-09 at 13:44 +0200, Samuel Thibault wrote:
> > Yes, of course. But can't this be disabled too?
> 
> (I mean, the FIFOs)

In the USB case generally not. Also many high end devices are polled
with big buffers and have no IRQ support. It works for the 16x50s that
are most PCs today however and that is enough IMHO to be relevant for
now (next gen PC's probably won't have serial of course)

