Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276406AbRJBSia>; Tue, 2 Oct 2001 14:38:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276420AbRJBSiV>; Tue, 2 Oct 2001 14:38:21 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:56585 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S276406AbRJBSiK>; Tue, 2 Oct 2001 14:38:10 -0400
Subject: Re: Huge console switching lags
To: jfbeam@bluetopia.net (Ricky Beam)
Date: Tue, 2 Oct 2001 19:43:00 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), akpm@zip.com.au (Andrew Morton),
        lenstra@tiscalinet.it (Lorenzo Allegrucci),
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.33.0110021423140.22872-100000@sweetums.bluetronic.net> from "Ricky Beam" at Oct 02, 2001 02:32:08 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15oUVQ-0005YA-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In that case, keventd needs to be a high priority real-time task.  If it
> takes SECONDS to change consoles, I'm very likely to assume the machine is
> locked and push the reset button (and I'm sure many others will do the same.)

Well one way to test that would be to renice it and see
