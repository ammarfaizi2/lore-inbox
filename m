Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268044AbTBRSnM>; Tue, 18 Feb 2003 13:43:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268043AbTBRSnM>; Tue, 18 Feb 2003 13:43:12 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:51211 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S268044AbTBRSnL>; Tue, 18 Feb 2003 13:43:11 -0500
Date: Tue, 18 Feb 2003 18:53:09 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: PATCH: make the sl82c105 work again
Message-ID: <20030218185309.C9785@flint.arm.linux.org.uk>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	torvalds@transmeta.com, linux-kernel@vger.kernel.org
References: <E18lCZa-0006Ec-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E18lCZa-0006Ec-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Tue, Feb 18, 2003 at 06:34:29PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2003 at 06:34:29PM +0000, Alan Cox wrote:
> +	hwif->drives[0].pio_speed = XFER_PIO_0;
> +	hwif->drives[0].autotune = 1;
> +	hwif->drives[1].pio_speed = XFER_PIO_1;
> +	hwif->drives[1].autotune = 1;

Is there some reason why drive 1 is PIO 1 and drive 0 is PIO 0 ?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

