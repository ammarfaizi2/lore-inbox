Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264865AbRFTJP4>; Wed, 20 Jun 2001 05:15:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264866AbRFTJPq>; Wed, 20 Jun 2001 05:15:46 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:26374 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264865AbRFTJPd>; Wed, 20 Jun 2001 05:15:33 -0400
Subject: Re: Alan Cox quote? (was: Re: accounting for threads)
To: rothwell@holly-springs.nc.us (Michael Rothwell)
Date: Wed, 20 Jun 2001 10:14:48 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <993005859.1799.1.camel@gromit> from "Michael Rothwell" at Jun 19, 2001 10:57:38 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Ce4W-0007aH-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Oh, how I would love for select() and poll() to work on files... or for
> any other working AIO mothods to be present.
> What would get broken if things were changed to let select() work for
> filesystem fds?

It does. They are always readable. If it were to trigger prefetching in that
case then I suspect no harm would occur

