Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314457AbSESO6p>; Sun, 19 May 2002 10:58:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314469AbSESO6o>; Sun, 19 May 2002 10:58:44 -0400
Received: from panic.tn.gatech.edu ([130.207.137.62]:2725 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S314457AbSESO6m>;
	Sun, 19 May 2002 10:58:42 -0400
Date: Sun, 19 May 2002 10:58:43 -0400
From: Jeff Garzik <garzik@gtf.org>
To: Anssi Saari <as@sci.fi>
Cc: Andre Hedrick <andre@linux-ide.org>, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org
Subject: Re: IO/MMIO 2.4 ATA/IDE driver recore near complete
Message-ID: <20020519105843.B10528@gtf.org>
In-Reply-To: <Pine.LNX.4.10.10205180230290.774-100000@master.linux-ide.org> <20020519103323.GA28335@sci.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 19, 2002 at 01:33:24PM +0300, Anssi Saari wrote:
> I wonder if this would help me with my audio CD writing problem which
> seems to use PIO mode and slow my system to a snails pace?

Nope.  It depends on your ATA controller, and the vast majority of
controllers currently on the market use PIO.

You are thinking about PIO versus DMA, which are the two data transfer
modes of ATA.  We are talking about a situation which replaces PIO with
MMIO, but otherwise looks and acts similarly to PIO+DMA.

	Jeff



